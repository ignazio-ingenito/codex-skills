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

# Balanced remains the restrained baseline.
require_text "${layering_ref}" "L0/L1 leggibili soprattutto tramite surface e spacing."
require_text "${layering_ref}" "Shadow selettiva solo su elementi davvero Raised/Overlay."
require_text "${layering_ref}" "Contrasto tra layer sufficiente ma non teatrale."

# Expressive must be visibly stronger without changing the semantic layer map.
require_text "${skill}" "material / blur / translucency / subtle refraction / lens-like effects"
require_text "${skill}" "floating, transient o parte del chrome applicativo"
require_text "${layering_ref}" "stessa identica mappa semantica"
require_text "${layering_ref}" "topbar, sidebar/rail, toolbar/action bar, controlli floating, popover e overlay"
require_text "${layering_ref}" "content card, document card, canvas/base"
require_text "${layering_ref}" "glassmorphism diffuso"
require_text "${layering_ref}" "non creare nuovi layer semantici"

balanced_section="$(sed -n '/^### Balanced$/,/^### Expressive$/p' "${layering_ref}")"
if grep -Eiq -- "(refraction|lens-like|traslucen|translucen)" <<<"${balanced_section}"; then
  fail "Balanced must not gain Expressive material/lens cues"
fi

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
