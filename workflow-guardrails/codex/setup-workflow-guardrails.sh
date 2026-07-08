#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: setup-workflow-guardrails.sh [options] <project-root>

Install workflow guardrail references into a target project and optionally start Codex.

Options:
  --replace       Replace existing managed files or managed blocks when needed.
  --copy          Copy guardrail files into the target project instead of symlinking them.
  --no-launch     Do not launch Codex after setup.
  --codex-cmd CMD Command used to launch Codex. Default: codex
  --help          Show this help.

What it creates in <project-root>:
  docs/workflow/
  docs/codex/
  docs/handoffs/

What it links or copies:
  workflow-guardrails/chatGPT/project-workflow-guardrails.md
  workflow-guardrails/chatGPT/implementation-handoff-template.md
  workflow-guardrails/chatGPT/project-bootstrap-template.md
  workflow-guardrails/codex/codex-implementation-contract.md

What it references:
  AGENTS.md
  CONTEXT.md
  MEMORY.md
USAGE
}

replace=0
copy_mode=0
launch=1
codex_cmd="codex"

while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --replace)
      replace=1
      shift
      ;;
    --copy)
      copy_mode=1
      shift
      ;;
    --no-launch)
      launch=0
      shift
      ;;
    --codex-cmd)
      if [[ -z "${2:-}" ]]; then
        echo "ERROR --codex-cmd requires a value" >&2
        exit 2
      fi
      codex_cmd="$2"
      shift 2
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ "$#" -ne 1 ]]; then
  usage >&2
  exit 2
fi

project_root="$1"
if [[ ! -d "${project_root}" ]]; then
  echo "ERROR project root does not exist: ${project_root}" >&2
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source_root="${repo_root}/workflow-guardrails"
chatgpt_source="${source_root}/chatGPT"
codex_source="${source_root}/codex"

for required in \
  "${chatgpt_source}/project-workflow-guardrails.md" \
  "${chatgpt_source}/implementation-handoff-template.md" \
  "${chatgpt_source}/project-bootstrap-template.md" \
  "${codex_source}/codex-implementation-contract.md"; do
  if [[ ! -f "${required}" ]]; then
    echo "ERROR required guardrail file not found: ${required}" >&2
    exit 1
  fi
done

mkdir -p \
  "${project_root}/docs/workflow" \
  "${project_root}/docs/codex" \
  "${project_root}/docs/handoffs"

install_ref() {
  local src="$1"
  local dest="$2"

  if [[ -e "${dest}" || -L "${dest}" ]]; then
    if [[ "${replace}" -ne 1 ]]; then
      echo "SKIP ${dest}: already exists. Use --replace to update it." >&2
      return
    fi
    rm -f "${dest}"
  fi

  if [[ "${copy_mode}" -eq 1 ]]; then
    cp "${src}" "${dest}"
    echo "Copied ${src} -> ${dest}"
  else
    ln -s "${src}" "${dest}"
    echo "Linked ${src} -> ${dest}"
  fi
}

install_ref "${chatgpt_source}/project-workflow-guardrails.md" "${project_root}/docs/workflow/project-workflow-guardrails.md"
install_ref "${chatgpt_source}/implementation-handoff-template.md" "${project_root}/docs/workflow/implementation-handoff-template.md"
install_ref "${chatgpt_source}/project-bootstrap-template.md" "${project_root}/docs/workflow/project-bootstrap-template.md"
install_ref "${codex_source}/codex-implementation-contract.md" "${project_root}/docs/codex/codex-implementation-contract.md"

upsert_managed_block() {
  local file="$1"
  local title="$2"
  local body="$3"
  local begin="<!-- workflow-guardrails:${title}:begin -->"
  local end="<!-- workflow-guardrails:${title}:end -->"

  touch "${file}"

  if grep -qF "${begin}" "${file}"; then
    if [[ "${replace}" -ne 1 ]]; then
      echo "OK ${file}: managed block '${title}' already present"
      return
    fi
    python3 - "$file" "$begin" "$end" "$body" <<'PY'
from pathlib import Path
import sys
path = Path(sys.argv[1])
begin = sys.argv[2]
end = sys.argv[3]
body = sys.argv[4]
text = path.read_text()
start = text.index(begin)
stop = text.index(end, start) + len(end)
replacement = f"{begin}\n{body.rstrip()}\n{end}"
path.write_text(text[:start] + replacement + text[stop:])
PY
    echo "Updated ${file}: managed block '${title}'"
  else
    {
      printf '\n%s\n' "${begin}"
      printf '%s\n' "${body}"
      printf '%s\n' "${end}"
    } >> "${file}"
    echo "Added ${file}: managed block '${title}'"
  fi
}

agents_body=$(cat <<'EOF_AGENTS'
## Workflow guardrails

Before implementation, read:

- `docs/codex/codex-implementation-contract.md`
- the task-specific handoff in `docs/handoffs/` when present

Codex must follow the contract, produce the operational pre-flight, disclose relevant tool/MCP/plugin/skill usage, and return control when implementation would require requirement, architecture, product, or scope decisions.
EOF_AGENTS
)

context_body=$(cat <<'EOF_CONTEXT'
## Workflow guardrails context

Project decision workflow lives in:

- `docs/workflow/project-workflow-guardrails.md`
- `docs/workflow/implementation-handoff-template.md`
- `docs/workflow/project-bootstrap-template.md`

Codex implementation behavior lives in:

- `docs/codex/codex-implementation-contract.md`
EOF_CONTEXT
)

memory_body=$(cat <<'EOF_MEMORY'
## Workflow guardrails memory

Do not treat chat history as the source of truth for implementation. Use the approved handoff and the Codex Implementation Contract. Keep checkpoints compact enough to survive context compaction or handoff.
EOF_MEMORY
)

upsert_managed_block "${project_root}/AGENTS.md" "agents" "${agents_body}"
upsert_managed_block "${project_root}/CONTEXT.md" "context" "${context_body}"
upsert_managed_block "${project_root}/MEMORY.md" "memory" "${memory_body}"

if [[ "${launch}" -eq 1 ]]; then
  if ! command -v "${codex_cmd}" >/dev/null 2>&1; then
    echo "ERROR Codex command not found: ${codex_cmd}" >&2
    echo "Setup completed, but Codex was not launched. Use --codex-cmd or --no-launch." >&2
    exit 1
  fi
  cd "${project_root}"
  exec "${codex_cmd}"
fi

echo "Workflow guardrails setup completed."
