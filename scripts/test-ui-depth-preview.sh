#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill="${repo_root}/global/ui-depth-preview/SKILL.md"
layering_ref="${repo_root}/global/ui-depth-preview/references/layering-model.md"
fidelity_ref="${repo_root}/global/ui-depth-preview/references/preview-fidelity.md"
readme="${repo_root}/README.md"

fail() {
  echo "ERROR ui-depth-preview: $1" >&2
  exit 1
}

require_text() {
  local file="$1"
  local text="$2"
  grep -Fq -- "${text}" "${file}" || fail "missing '${text}' in ${file#${repo_root}/}"
}

[[ -f "${skill}" ]] || fail "missing global/ui-depth-preview/SKILL.md"
[[ -f "${layering_ref}" ]] || fail "missing references/layering-model.md"
[[ -f "${fidelity_ref}" ]] || fail "missing references/preview-fidelity.md"

require_text "${skill}" "name: ui-depth-preview"
require_text "${skill}" "Indicativa"
require_text "${skill}" "Fedele"
require_text "${skill}" "Balanced"
require_text "${skill}" "Expressive"
require_text "${skill}" "materialmente"
require_text "${skill}" "confidence"
require_text "${skill}" "references/layering-model.md"
require_text "${skill}" "references/preview-fidelity.md"
require_text "${readme}" '`ui-depth-preview`'

if grep -Fq -- "Implementation accurate" "${skill}"; then
  fail "must not introduce an Implementation accurate mode"
fi

if ! grep -Eiq -- "(non|mai).*(implement|prototip).*(solo|soltanto).*(preview|anteprima)" "${skill}"; then
  fail "missing guardrail against implementation/prototyping only to obtain the preview"
fi

if ! grep -Eiq -- "(default|predefinit).*(2|due).*(preview|anteprime|varianti)" "${skill}"; then
  fail "missing two-preview default"
fi

if ! grep -Eiq -- "terz.*(solo|soltanto).*(richiest|distinguibil)" "${skill}"; then
  fail "missing conditional third-preview rule"
fi

if ! grep -Eiq -- "(layering|depth).*(non|senza).*(redesign|ridisegn)" "${skill}"; then
  fail "missing layering-only scope guardrail"
fi

echo "ui-depth-preview checks passed"
