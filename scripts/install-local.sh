#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_dir="${repo_root}/global"
codex_home="${CODEX_HOME:-${HOME}/.codex}"
dest_dir="${codex_home}/skills"
replace=0

while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --replace)
      replace=1
      shift
      ;;
    --help)
      echo "Usage: $0 [--replace] [skill-name ...]"
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: $0 [--replace] [skill-name ...]" >&2
      exit 2
      ;;
  esac
done

mkdir -p "${dest_dir}"

if [[ "$#" -gt 0 ]]; then
  skill_names=("$@")
else
  mapfile -t skill_names < <(find "${skills_dir}" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
fi

if [[ "${#skill_names[@]}" -eq 0 ]]; then
  echo "No global skills to install"
  exit 0
fi

for skill_name in "${skill_names[@]}"; do
  source_dir="${skills_dir}/${skill_name}"
  target_dir="${dest_dir}/${skill_name}"

  if [[ ! -f "${source_dir}/SKILL.md" ]]; then
    echo "ERROR global/${skill_name}: ${source_dir}/SKILL.md not found" >&2
    exit 1
  fi

  if [[ -L "${target_dir}" ]]; then
    current_target="$(readlink "${target_dir}")"
    if [[ "${current_target}" == "${source_dir}" ]]; then
      echo "OK global/${skill_name}: already linked"
      continue
    fi
    if [[ "${replace}" -ne 1 ]]; then
      echo "ERROR global/${skill_name}: ${target_dir} is a symlink to ${current_target}" >&2
      echo "Use --replace to move it to a backup and relink." >&2
      exit 1
    fi
    backup_dir="${target_dir}.backup-$(date +%Y%m%d%H%M%S)"
    mv "${target_dir}" "${backup_dir}"
    echo "Moved existing symlink to ${backup_dir}"
  fi

  if [[ -e "${target_dir}" ]]; then
    if [[ "${replace}" -ne 1 ]]; then
      echo "ERROR global/${skill_name}: ${target_dir} already exists and is not a symlink" >&2
      echo "Use --replace to move it to a backup and relink." >&2
      exit 1
    fi
    backup_dir="${target_dir}.backup-$(date +%Y%m%d%H%M%S)"
    mv "${target_dir}" "${backup_dir}"
    echo "Moved existing directory to ${backup_dir}"
  fi

  ln -s "${source_dir}" "${target_dir}"
  echo "Linked global/${skill_name} -> ${target_dir}"
done

echo "Restart Codex to pick up new or changed skills."
