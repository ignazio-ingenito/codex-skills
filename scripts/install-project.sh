#!/usr/bin/env bash
set -euo pipefail

replace=0
while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --replace)
      replace=1
      shift
      ;;
    --help)
      echo "Usage: $0 [--replace] <project-name> <project-root> [skill-name ...]"
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: $0 [--replace] <project-name> <project-root> [skill-name ...]" >&2
      exit 2
      ;;
  esac
done

if [[ "$#" -lt 2 ]]; then
  echo "Usage: $0 [--replace] <project-name> <project-root> [skill-name ...]" >&2
  exit 2
fi

project_name="$1"
project_root="$2"
shift 2

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${repo_root}/projects/${project_name}"
dest_root="${project_root}/.agents/skills"

if [[ ! -d "${source_root}" ]]; then
  echo "Project skills not found: ${source_root}" >&2
  exit 1
fi

mkdir -p "${dest_root}"

if [[ "$#" -gt 0 ]]; then
  skill_names=("$@")
else
  mapfile -t skill_names < <(find "${source_root}" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
fi

for skill_name in "${skill_names[@]}"; do
  source_dir="${source_root}/${skill_name}"
  target_dir="${dest_root}/${skill_name}"

  if [[ ! -f "${source_dir}/SKILL.md" ]]; then
    echo "ERROR projects/${project_name}/${skill_name}: ${source_dir}/SKILL.md not found" >&2
    exit 1
  fi

  if [[ -L "${target_dir}" ]]; then
    current_target="$(readlink "${target_dir}")"
    if [[ "${current_target}" == "${source_dir}" ]]; then
      echo "OK projects/${project_name}/${skill_name}: already linked"
      continue
    fi
    if [[ "${replace}" -ne 1 ]]; then
      echo "ERROR projects/${project_name}/${skill_name}: ${target_dir} is a symlink to ${current_target}" >&2
      echo "Use --replace to move it to a backup and relink." >&2
      exit 1
    fi
    backup_dir="${target_dir}.backup-$(date +%Y%m%d%H%M%S)"
    mv "${target_dir}" "${backup_dir}"
    echo "Moved existing symlink to ${backup_dir}"
  fi

  if [[ -e "${target_dir}" ]]; then
    if [[ "${replace}" -ne 1 ]]; then
      echo "ERROR projects/${project_name}/${skill_name}: ${target_dir} already exists and is not a symlink" >&2
      echo "Use --replace to move it to a backup and relink." >&2
      exit 1
    fi
    backup_dir="${target_dir}.backup-$(date +%Y%m%d%H%M%S)"
    mv "${target_dir}" "${backup_dir}"
    echo "Moved existing directory to ${backup_dir}"
  fi

  ln -s "${source_dir}" "${target_dir}"
  echo "Linked projects/${project_name}/${skill_name} -> ${target_dir}"
done

echo "Restart Codex to pick up new or changed skills."
