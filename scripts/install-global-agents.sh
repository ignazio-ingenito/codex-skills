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
      echo "Usage: $0 [--replace] <project-root>"
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: $0 [--replace] <project-root>" >&2
      exit 2
      ;;
  esac
done

if [[ "$#" -ne 1 ]]; then
  echo "Usage: $0 [--replace] <project-root>" >&2
  exit 2
fi

project_root="$1"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="${repo_root}/AGENTS.global.md"
target_file="${project_root}/AGENTS.md"

if [[ ! -f "${source_file}" ]]; then
  echo "Shared agent instructions not found: ${source_file}" >&2
  exit 1
fi

if [[ ! -d "${project_root}" ]]; then
  echo "Project root not found: ${project_root}" >&2
  exit 1
fi

if [[ -L "${target_file}" ]]; then
  current_target="$(readlink "${target_file}")"
  if [[ "${current_target}" == "${source_file}" ]]; then
    echo "OK AGENTS.md: already linked"
    exit 0
  fi
  if [[ "${replace}" -ne 1 ]]; then
    echo "ERROR AGENTS.md: ${target_file} is a symlink to ${current_target}" >&2
    echo "Use --replace to move it to a backup and relink." >&2
    exit 1
  fi
  backup_file="${target_file}.backup-$(date +%Y%m%d%H%M%S)"
  mv "${target_file}" "${backup_file}"
  echo "Moved existing symlink to ${backup_file}"
fi

if [[ -e "${target_file}" ]]; then
  if [[ "${replace}" -ne 1 ]]; then
    echo "ERROR AGENTS.md: ${target_file} already exists and is not a symlink" >&2
    echo "Use --replace to move it to a backup and relink." >&2
    exit 1
  fi
  backup_file="${target_file}.backup-$(date +%Y%m%d%H%M%S)"
  mv "${target_file}" "${backup_file}"
  echo "Moved existing file to ${backup_file}"
fi

ln -s "${source_file}" "${target_file}"
echo "Linked AGENTS.global.md -> ${target_file}"
echo "Restart Codex or reopen the project session to pick up changed instructions."
