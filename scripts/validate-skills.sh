#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
global_skills_dir="${repo_root}/global"
project_skills_dir="${repo_root}/projects"
upstreams_file="${repo_root}/config/global-skill-upstreams.tsv"

if [[ ! -d "${global_skills_dir}" ]]; then
  echo "Missing skills directory: ${global_skills_dir}" >&2
  exit 1
fi

status=0
count=0
upstream_count=0

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
import re
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
    yaml = None

if yaml is not None:
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
    raise SystemExit(0)

# Minimal YAML fallback for required scalar fields when PyYAML is unavailable.
# It supports inline scalars and folded/literal block scalars used by skill files.
lines = frontmatter.splitlines()
values: dict[str, str] = {}
index = 0
key_pattern = re.compile(r"^([A-Za-z0-9_-]+):(?:[ \t]*(.*))?$")
block_markers = {"|", "|-", "|+", ">", ">-", ">+"}

while index < len(lines):
    line = lines[index]
    if not line or line[0].isspace() or line.lstrip().startswith("#"):
        index += 1
        continue

    match = key_pattern.match(line)
    if not match:
        raise SystemExit(1)

    key, raw_value = match.group(1), (match.group(2) or "").strip()
    if raw_value in block_markers:
        index += 1
        block_lines: list[str] = []
        while index < len(lines):
            candidate = lines[index]
            if candidate and not candidate[0].isspace() and key_pattern.match(candidate):
                break
            if candidate.strip() and not candidate.lstrip().startswith("#"):
                if not candidate[0].isspace():
                    raise SystemExit(1)
                block_lines.append(candidate.strip())
            index += 1
        values[key] = "\n".join(block_lines).strip()
        continue

    values[key] = raw_value
    index += 1

for required in ("name", "description"):
    if not values.get(required, "").strip():
        raise SystemExit(1)
PY
    then
      echo "ERROR ${skill_name}: invalid YAML frontmatter or missing name/description" >&2
      status=1
    fi
  else
    if ! sed -n '2,/^---$/p' "${skill_file}" | grep -Eq '^name:[[:space:]]*[^[:space:]].*'; then
      echo "ERROR ${skill_name}: frontmatter missing name" >&2
      status=1
    fi
    if ! sed -n '2,/^---$/p' "${skill_file}" | grep -Eq '^description:[[:space:]]*(.+|[|>][-+]?)$'; then
      echo "ERROR ${skill_name}: frontmatter missing description" >&2
      status=1
    fi
  fi
}

validate_upstreams() {
  local skill_name repo_url ref skill_path extra
  declare -A seen=()

  [[ -f "${upstreams_file}" ]] || return 0

  while IFS=$'\t' read -r skill_name repo_url ref skill_path extra || [[ -n "${skill_name:-}" ]]; do
    [[ -z "${skill_name:-}" || "${skill_name}" == \#* ]] && continue
    upstream_count=$((upstream_count + 1))

    if [[ -n "${extra:-}" || -z "${repo_url:-}" || -z "${ref:-}" || -z "${skill_path:-}" ]]; then
      echo "ERROR upstream/${skill_name}: expected name, repository, full commit SHA and skill path" >&2
      status=1
      continue
    fi
    if [[ ! "${skill_name}" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
      echo "ERROR upstream/${skill_name}: invalid skill name" >&2
      status=1
    fi
    if [[ ! "${repo_url}" =~ ^https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+\.git$ ]]; then
      echo "ERROR upstream/${skill_name}: repository must be an original GitHub HTTPS clone URL" >&2
      status=1
    fi
    if [[ ! "${ref}" =~ ^[0-9a-fA-F]{40}$ ]]; then
      echo "ERROR upstream/${skill_name}: ref must be a full commit SHA" >&2
      status=1
    fi
    if [[ "${skill_path}" == /* || "${skill_path}" =~ (^|/)\.\.(/|$) ]]; then
      echo "ERROR upstream/${skill_name}: invalid skill path ${skill_path}" >&2
      status=1
    fi
    if [[ -n "${seen[${skill_name}]+x}" ]]; then
      echo "ERROR upstream/${skill_name}: duplicate definition" >&2
      status=1
    fi
    if [[ -d "${global_skills_dir}/${skill_name}" ]]; then
      echo "ERROR upstream/${skill_name}: duplicate local copy exists in global/${skill_name}" >&2
      status=1
    fi

    seen["${skill_name}"]=1
  done < "${upstreams_file}"
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

validate_upstreams

if [[ "${count}" -eq 0 && "${upstream_count}" -eq 0 ]]; then
  echo "No skills found"
else
  echo "Validated ${count} local skill(s) and ${upstream_count} pinned upstream skill definition(s)"
fi

exit "${status}"
