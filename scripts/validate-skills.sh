#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
global_skills_dir="${repo_root}/global"
project_skills_dir="${repo_root}/projects"

if [[ ! -d "${global_skills_dir}" ]]; then
  echo "Missing skills directory: ${global_skills_dir}" >&2
  exit 1
fi

status=0
count=0

validate_skill_dir() {
  local skill_dir="$1"
  local label="$2"
  local skill_name
  local skill_file

  count=$((count + 1))
  skill_name="${label}"
  skill_file="${skill_dir}/SKILL.md"

  if [[ ! -f "${skill_file}" ]]; then
    echo "ERROR ${skill_name}: missing SKILL.md" >&2
    status=1
    return
  fi

  if ! head -n 1 "${skill_file}" | grep -qx -- "---"; then
    echo "ERROR ${skill_name}: SKILL.md must start with YAML frontmatter" >&2
    status=1
    return
  fi

  if command -v python3 >/dev/null 2>&1; then
    if ! python3 - "${skill_file}" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8")
if not text.startswith("---\n"):
    raise SystemExit(1)
try:
    _, frontmatter, _ = text.split("---", 2)
except ValueError:
    raise SystemExit(1)

try:
    import yaml  # type: ignore
except Exception:
    raise SystemExit(0)

try:
    data = yaml.safe_load(frontmatter)
except yaml.YAMLError:
    raise SystemExit(1)

if not isinstance(data, dict):
    raise SystemExit(1)
for key in ("name", "description"):
    value = data.get(key)
    if not isinstance(value, str) or not value.strip():
        raise SystemExit(1)
PY
    then
      echo "ERROR ${skill_name}: invalid YAML frontmatter or missing name/description" >&2
      status=1
    fi
  else
    if ! sed -n '2,/^---$/p' "${skill_file}" | grep -Eq '^name:[[:space:]]*.+'; then
      echo "ERROR ${skill_name}: frontmatter missing name" >&2
      status=1
    fi
    if ! sed -n '2,/^---$/p' "${skill_file}" | grep -Eq '^description:[[:space:]]*.+'; then
      echo "ERROR ${skill_name}: frontmatter missing description" >&2
      status=1
    fi
  fi
}

while IFS= read -r -d '' skill_dir; do
  validate_skill_dir "${skill_dir}" "global/$(basename "${skill_dir}")"
done < <(find "${global_skills_dir}" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

if [[ -d "${project_skills_dir}" ]]; then
  while IFS= read -r -d '' skill_dir; do
    rel_path="${skill_dir#${repo_root}/}"
    validate_skill_dir "${skill_dir}" "${rel_path}"
  done < <(find "${project_skills_dir}" -mindepth 2 -maxdepth 2 -type d -print0 | sort -z)
fi

if [[ "${count}" -eq 0 ]]; then
  echo "No skills found"
else
  echo "Validated ${count} skill(s)"
fi

exit "${status}"
