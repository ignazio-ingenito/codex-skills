#!/usr/bin/env bash
set -euo pipefail

replace=0
install_global_agents=1
while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --replace)
      replace=1
      shift
      ;;
    --no-global-agents)
      install_global_agents=0
      shift
      ;;
    --help)
      echo "Usage: $0 [--replace] [--no-global-agents] <project-name> <project-root> [skill-name ...]"
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: $0 [--replace] [--no-global-agents] <project-name> <project-root> [skill-name ...]" >&2
      exit 2
      ;;
  esac
done

if [[ "$#" -lt 2 ]]; then
  echo "Usage: $0 [--replace] [--no-global-agents] <project-name> <project-root> [skill-name ...]" >&2
  exit 2
fi

project_name="$1"
project_root="$2"
shift 2

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${repo_root}/projects/${project_name}"
dest_root="${project_root}/.agents/skills"
global_agents_source="${repo_root}/AGENTS.global.md"
global_agents_target="${project_root}/AGENTS.md"

if [[ ! -d "${source_root}" ]]; then
  echo "Project skills not found: ${source_root}" >&2
  exit 1
fi

install_global_agents_file() {
  if [[ ! -f "${global_agents_source}" ]]; then
    echo "ERROR global agents file not found: ${global_agents_source}" >&2
    exit 1
  fi

  if [[ -L "${global_agents_target}" ]]; then
    current_target="$(readlink "${global_agents_target}")"
    if [[ "${current_target}" == "${global_agents_source}" ]]; then
      echo "OK AGENTS.md: already linked"
      return
    fi
    if [[ "${replace}" -ne 1 ]]; then
      echo "ERROR AGENTS.md: ${global_agents_target} is a symlink to ${current_target}" >&2
      echo "Use --replace to move it to a backup and relink." >&2
      exit 1
    fi
    backup_file="${global_agents_target}.backup-$(date +%Y%m%d%H%M%S)"
    mv "${global_agents_target}" "${backup_file}"
    echo "Moved existing AGENTS.md symlink to ${backup_file}"
  fi

  if [[ -e "${global_agents_target}" ]]; then
    if [[ "${replace}" -ne 1 ]]; then
      echo "ERROR AGENTS.md: ${global_agents_target} already exists and is not a symlink" >&2
      echo "Use --replace to move it to a backup and relink." >&2
      exit 1
    fi
    backup_file="${global_agents_target}.backup-$(date +%Y%m%d%H%M%S)"
    mv "${global_agents_target}" "${backup_file}"
    echo "Moved existing AGENTS.md to ${backup_file}"
  fi

  ln -s "${global_agents_source}" "${global_agents_target}"
  echo "Linked AGENTS.global.md -> ${global_agents_target}"
}

if [[ "${install_global_agents}" -eq 1 ]]; then
  install_global_agents_file
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

echo "Restart Codex to pick up new or changed skills and agent instructions."
