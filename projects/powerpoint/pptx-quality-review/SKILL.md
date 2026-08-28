---
name: pptx-quality-review
description: Use when inspecting, validating, critiquing, or quality-checking a .pptx, exported PDF, slide images, or generated presentation in skunklabs-uk/powerpoint-ai before delivery.
---

# PPTX Quality Review

## Overview

Use this skill to review a presentation as a delivery artifact, not just as a file. Prioritize factual grounding, executive usefulness, readability, and consistency with repository rules and visual references.

## Inputs To Read

Before reviewing a deck, read or inspect:

- current project instructions, especially `AGENTS.md` when present or provided in the conversation;
- all `docs/reference*.md` files;
- other relevant `docs/` source files;
- available `ui/` references, including `ui/README.md` and visual files;
- the target `.pptx`, exported `.pdf`, or slide images.

Do not use GitNexus for this repository unless reusable code or generators have been introduced and the task specifically requires code relationship analysis.

## Review Workflow

1. Extract or inspect deck content slide by slide:
   - title;
   - main message;
   - key claims;
   - tables/economics;
   - assumptions/open points;
   - visual structure.

2. Check storyline coverage:
   - Contesto ed esigenza/obiettivi
   - AS IS
   - TO BE
   - Piano di lavoro
   - Economics

3. Check grounding:
   - flag claims not supported by `docs/`, user-provided material, or explicit assumptions;
   - flag invented costs, dates, delivery scope, technologies, client facts, benefits, commitments, examples, and implementation details;
   - distinguish missing source from weak wording.

4. Check executive clarity:
   - titles should communicate the slide message;
   - text should be concise and readable;
   - detail should not bury business value, impact, risks, timing, or economics;
   - technical content should explain business relevance.

5. Check visual and layout consistency:
   - compare slide ratio, grid, title placement, typography scale, palette, spacing, footer/header conventions, and divider style with `ui/`;
   - verify diagrams, roadmaps, tables, and economics are legible;
   - flag overcrowded slides and inconsistent visual hierarchy.

6. Check deliverable hygiene:
   - final generated files should live in the repository root;
   - `.pptx` should remain the primary editable deliverable;
   - PDFs, PNGs, previews, and screenshots should exist only when requested;
   - generated outputs should not be written into `docs/` or `ui/`.

## Output Format

Lead with findings ordered by severity. For each finding, include:

- slide number or file reference when available;
- issue;
- why it matters;
- recommended fix.

Then provide:

- open questions or missing source material;
- concise overall readiness assessment;
- optional next actions.

If no material issues are found, say that clearly and mention residual risks such as unverified exports, missing source files, or visual checks that could not be run.

## Fixing Scope

When the user asks to fix the reviewed deck, make scoped edits that address the findings. Preserve unrelated user changes and reference content. If a finding requires missing business input, ask instead of inventing content.
