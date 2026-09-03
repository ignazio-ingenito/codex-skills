#!/usr/bin/env bash
set -euo pipefail

skill_file="${SKILL_FILE:-projects/baialupo/baia-publish/SKILL.md}"

if grep -Eq '\]\(/web/|^[[:space:]]*(link|image|cover):[[:space:]]*"?/web/|Use public paths with `/web/' "$skill_file"; then
  echo "baia-publish still contains an authoring example with the legacy /web prefix" >&2
  exit 1
fi

grep -Fq '[![Alt text](/img/stories/name.jpg)](/img/stories/name.jpg)' "$skill_file"
grep -Fq 'link: "/news/<public-slug>"' "$skill_file"
grep -Fq 'image: "/img/stories/<image>.jpg"' "$skill_file"
grep -Fq 'Never add `/web/...`' "$skill_file"
