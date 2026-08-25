#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_dir="${repo_root}/global"
upstreams_file="${repo_root}/config/global-skill-upstreams.tsv"
codex_home="${CODEX_HOME:-${HOME}/.codex}"
dest_dir="${codex_home}/skills"
upstreams_cache="${codex_home}/upstream-skills"
replace=0

declare -A upstream_repo=()
declare -A upstream_ref=()
declare -A upstream_path=()

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

load_upstreams() {
  local skill_name repo_url ref skill_path extra

  [[ -f "${upstreams_file}" ]] || return 0

  while IFS=$'\t' read -r skill_name repo_url ref skill_path extra || [[ -n "${skill_name:-}" ]]; do
    [[ -z "${skill_name:-}" || "${skill_name}" == \#* ]] && continue

    if [[ -n "${extra:-}" || -z "${repo_url:-}" || -z "${ref:-}" || -z "${skill_path:-}" ]]; then
      echo "ERROR invalid upstream skill definition for ${skill_name}" >&2
      exit 1
    fi
    if [[ ! "${skill_name}" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
      echo "ERROR invalid upstream skill name: ${skill_name}" >&2
      exit 1
    fi
    if [[ ! "${repo_url}" =~ ^https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+\.git$ ]]; then
      echo "ERROR invalid upstream repository for ${skill_name}: ${repo_url}" >&2
      exit 1
    fi
    if [[ ! "${ref}" =~ ^[0-9a-fA-F]{40}$ ]]; then
      echo "ERROR upstream ref for ${skill_name} must be a full commit SHA" >&2
      exit 1
    fi
    if [[ "${skill_path}" == /* || "${skill_path}" =~ (^|/)\.\.(/|$) ]]; then
      echo "ERROR invalid upstream skill path for ${skill_name}: ${skill_path}" >&2
      exit 1
    fi
    if [[ -n "${upstream_repo[${skill_name}]+x}" ]]; then
      echo "ERROR duplicate upstream skill definition: ${skill_name}" >&2
      exit 1
    fi
    if [[ -d "${skills_dir}/${skill_name}" ]]; then
      echo "ERROR ${skill_name} exists both in global/ and ${upstreams_file}" >&2
      exit 1
    fi

    upstream_repo["${skill_name}"]="${repo_url}"
    upstream_ref["${skill_name}"]="${ref}"
    upstream_path["${skill_name}"]="${skill_path}"
  done < "${upstreams_file}"
}

prepare_upstream_skill() {
  local skill_name="$1"
  local checkout_dir="${upstreams_cache}/${skill_name}"
  local repo_url="${upstream_repo[${skill_name}]}"
  local ref="${upstream_ref[${skill_name}]}"
  local skill_path="${upstream_path[${skill_name}]}"
  local origin_url resolved_ref

  if ! command -v git >/dev/null 2>&1; then
    echo "ERROR git is required to install upstream skill ${skill_name}" >&2
    exit 1
  fi

  mkdir -p "${upstreams_cache}"

  if [[ ! -e "${checkout_dir}" ]]; then
    git clone --depth 1 --filter=blob:none --no-checkout "${repo_url}" "${checkout_dir}" >&2
  elif [[ ! -d "${checkout_dir}/.git" ]]; then
    echo "ERROR upstream cache exists but is not a git repository: ${checkout_dir}" >&2
    exit 1
  fi

  origin_url="$(git -C "${checkout_dir}" remote get-url origin)"
  if [[ "${origin_url}" != "${repo_url}" ]]; then
    echo "ERROR upstream cache for ${skill_name} points to ${origin_url}, expected ${repo_url}" >&2
    exit 1
  fi

  if ! git -C "${checkout_dir}" cat-file -e "${ref}^{commit}" 2>/dev/null; then
    git -C "${checkout_dir}" fetch --depth 1 origin "${ref}" >&2
  fi

  resolved_ref="$(git -C "${checkout_dir}" rev-parse "${ref}^{commit}")"
  if [[ "${resolved_ref}" != "${ref}" ]]; then
    echo "ERROR upstream ref mismatch for ${skill_name}: expected ${ref}, got ${resolved_ref}" >&2
    exit 1
  fi

  git -C "${checkout_dir}" checkout --detach --force "${ref}" >/dev/null 2>&1

  resolved_source_dir="${checkout_dir}/${skill_path}"
  if [[ ! -f "${resolved_source_dir}/SKILL.md" ]]; then
    echo "ERROR upstream ${skill_name}: ${resolved_source_dir}/SKILL.md not found" >&2
    exit 1
  fi
}

load_upstreams
mkdir -p "${dest_dir}"

if [[ "$#" -gt 0 ]]; then
  skill_names=("$@")
else
  mapfile -t local_skill_names < <(find "${skills_dir}" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
  upstream_skill_names=("${!upstream_repo[@]}")
  mapfile -t skill_names < <(printf '%s\n' "${local_skill_names[@]}" "${upstream_skill_names[@]}" | sed '/^$/d' | sort -u)
fi

if [[ "${#skill_names[@]}" -eq 0 ]]; then
  echo "No global skills to install"
  exit 0
fi

for skill_name in "${skill_names[@]}"; do
  if [[ -d "${skills_dir}/${skill_name}" ]]; then
    source_dir="${skills_dir}/${skill_name}"
  elif [[ -n "${upstream_repo[${skill_name}]+x}" ]]; then
    resolved_source_dir=""
    prepare_upstream_skill "${skill_name}"
    source_dir="${resolved_source_dir}"
  else
    echo "ERROR unknown global skill: ${skill_name}" >&2
    exit 1
  fi

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
