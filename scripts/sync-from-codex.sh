#!/usr/bin/env bash
set -euo pipefail

force=0
if [[ "${1:-}" == "--force" ]]; then
  force=1
  shift
fi

if [[ "$#" -ne 0 ]]; then
  echo "Usage: $0 [--force]" >&2
  exit 2
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
repo_skills_dir="${repo_root}/global"
codex_home="${CODEX_HOME:-${HOME}/.codex}"
installed_skills_dir="${codex_home}/skills"

mkdir -p "${repo_skills_dir}"

if [[ ! -d "${installed_skills_dir}" ]]; then
  echo "No installed skills directory found: ${installed_skills_dir}" >&2
  exit 1
fi

while IFS= read -r -d '' source_dir; do
  skill_name="$(basename "${source_dir}")"

  if [[ "${skill_name}" == ".system" ]]; then
    echo "Skip ${skill_name}: system skills are managed by Codex"
    continue
  fi

  if [[ -L "${source_dir}" ]]; then
    resolved="$(readlink -f "${source_dir}")"
    case "${resolved}" in
      "${repo_skills_dir}"/*)
        echo "Skip ${skill_name}: already linked to this repo global directory"
        continue
        ;;
    esac
  fi

  if [[ ! -f "${source_dir}/SKILL.md" ]]; then
    echo "Skip ${skill_name}: no SKILL.md"
    continue
  fi

  dest_dir="${repo_skills_dir}/${skill_name}"
  if [[ -e "${dest_dir}" && "${force}" -ne 1 ]]; then
    echo "Skip ${skill_name}: already exists in repo; use --force to overwrite"
    continue
  fi

  rm -rf "${dest_dir}"
  cp -a "${source_dir}" "${dest_dir}"
  echo "Copied global/${skill_name}"
done < <(find "${installed_skills_dir}" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

echo "Done. Review with git diff before committing."
