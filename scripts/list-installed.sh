#!/usr/bin/env bash
set -euo pipefail

codex_home="${CODEX_HOME:-${HOME}/.codex}"
skills_dir="${codex_home}/skills"

if [[ ! -d "${skills_dir}" ]]; then
  echo "No Codex skills directory found: ${skills_dir}" >&2
  exit 1
fi

find -L "${skills_dir}" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort
