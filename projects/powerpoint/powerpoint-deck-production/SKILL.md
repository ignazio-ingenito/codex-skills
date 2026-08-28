---
name: powerpoint-deck-production
description: Use when creating, updating, restructuring, or exporting a commercial, PMO, proposal, business-case, or executive PowerPoint deck from materials in skunklabs-uk/powerpoint-ai.
---

# PowerPoint Deck Production

## Overview

Use this skill to turn repository source material into a concise executive deck while preserving source grounding, PowerPoint editability, and the project's visual conventions. Treat the repository instructions and `docs/` content as the primary source of truth.

## Workflow

1. Read the current project instructions before making changes:
   - `AGENTS.md` when present or provided in the conversation.
   - all `docs/reference*.md` files.
   - any other `docs/` files directly relevant to the requested deck.

2. Inspect `ui/` before designing slides:
   - list available files;
   - read `ui/README.md` if present;
   - inspect reference images, PDFs, or screenshots enough to infer proportions, title placement, typography scale, palette, spacing, divider style, footer/header conventions, and treatment of diagrams/tables/roadmaps/economics.

3. Build or preserve the standard storyline unless the user explicitly requests otherwise:
   - Contesto ed esigenza/obiettivi
   - AS IS
   - TO BE
   - Piano di lavoro
   - Economics

4. Separate source-backed content from assumptions:
   - do not invent facts, commitments, costs, dates, scope, technologies, client details, commercial claims, examples, or implementation details;
   - ask the user when needed information is missing or ambiguous;
   - only create placeholders or assumptions when the user explicitly asks for them, and make them visible in the deck or notes.

5. Prefer editable PowerPoint construction:
   - use `pptxgenjs` unless the repository already has a stronger established generator;
   - use real text boxes, shapes, tables, connectors, and editable diagrams where practical;
   - use images only for visual assets, screenshots, background textures, or references that should remain raster.

6. Normalize and validate generated `.pptx` packages before delivery. Do not rely only on LibreOffice export success.

7. Save final deliverables in the repository root:
   - primary output: `.pptx`;
   - optional output: `.pdf` only when requested;
   - optional page images or previews only when explicitly requested.

## Content Rules

Write in Italian unless the user asks otherwise. Use a clear, commercial, C-level tone. Prefer slide titles that state the message or implication, not generic labels such as "TO BE" or "Architecture".

Keep slide text brief. Split executive synthesis, delivery detail, assumptions/open points, and economics into distinct slides or visual regions when density would otherwise increase.

## Visual Rules

Use `ui/` only as layout and style reference. Do not copy client-specific or confidential content from reference decks unless explicitly instructed. Do not write generated deliverables into `ui/` or `docs/`.

Match the reference system for slide ratio, title grid, typography hierarchy, color palette, spacing, dividers, tables, process diagrams, roadmap, and economics. Keep diagrams and tables readable at presentation size.

### Authoritative Visual Reference

When the user identifies a specific deck as the visual reference, that deck becomes the authoritative visual baseline for the generated deck. Do not treat it as a loose inspiration and do not replace its visual language with an approximate reconstruction.

Keep these roles separate:

- `docs/` and user instructions are the content/storyline source of truth.
- The user-named reference `.pptx` is the visual source of truth for layout, typography, color, logos, images, decorative elements, slide proportions, object positioning, and object sizing.
- `ui/` remains supplemental visual context unless the user explicitly says it overrides the named `.pptx`.
- A PowerPoint-repaired copy is a package-hygiene baseline only; it must not override the visual baseline unless the user explicitly approves it as the visual reference.

Operationally:

- inspect the named reference `.pptx` package directly, especially `ppt/slides/*.xml`, `ppt/slides/_rels/*.rels`, `ppt/theme/*.xml`, `ppt/media/`, slide masters, and layouts;
- copy exact geometry, font family, font size, theme colors, gradient fills, line widths, logos, picture parts, crop settings, and decorative elements from the reference when the new slide uses the same pattern;
- reuse actual editable/raster elements from the reference deck where permitted instead of recreating them manually;
- when text must change, preserve the original text box styling and replace only the text content;
- if an element cannot be copied safely, document the deviation and keep the closest editable equivalent;
- validate that the generated slide did not convert a picture/logo/decoration into a visually different approximation.

Gradient styling is part of the visual baseline. If the reference deck uses gradient fills for text, lines, borders, dividers, connectors, or decorative elements, the generated deck must preserve gradient styling instead of flattening it to a single color. In `TXT Novigo AI Orchestration.pptx`, many line and rounded-rectangle borders use a green-to-blue gradient (`56B093` to `307FE2`) with DrawingML `<a:gradFill>`; generated shapes using the same visual role should use the same gradient line/border treatment and comparable line width.

When a valid source or reference `.pptx` exists in the project root, inspect its theme and slide XML before choosing fonts and colors. For the Novigo/TXT references observed in this repository, the visual baseline uses:

- theme fonts: `Poppins` / `Poppins SemiBold`;
- primary green/teal: `56B093`;
- primary blue: `307FE2`;
- theme names such as `1_TXT Slide Master_White` and `Novigo`.

Do not default to Office/Aptos styling when the repository already provides a Novigo/TXT theme. If a repaired PowerPoint baseline is used only to avoid package corruption, do not let it overwrite the visual theme unless that repaired file is also the approved visual reference.

If the user identifies a specific `.pptx` as the visual reference, treat that deck as authoritative over inferred style from `ui/` screenshots. For cover slides, prefer reusing the actual editable/raster elements from the reference deck where possible instead of recreating them by approximation. In the observed `TXT Novigo AI Orchestration.pptx` cover:

- the title shape uses `Poppins SemiBold`, 32 pt, and a multi-stop gradient fill;
- the right-side decorative visual is a picture part, not manually recreated arc shapes;
- the top-left logo is a picture part, not reconstructed with text boxes;
- positioning and dimensions should be copied from the reference slide XML unless the user asks to change layout.

### TXT Novigo AI Orchestration Visual Fidelity Rules

When `TXT Novigo AI Orchestration.pptx` is the visual reference, apply these operational rules:

- **Logo assets**
  - Do not recreate the TXT/Novigo logo with text boxes.
  - Reuse the logo picture part from the reference deck, including relationship, geometry, aspect ratio, crop behavior, and position.
  - Verify every generated slide that should show the logo points to the same logo asset and does not contain `TXT` / `NOVIGO` as faux-logo text.

- **Cover slide**
  - Reuse the actual cover visual elements from the reference deck where possible:
    - right-side decorative picture;
    - logo picture;
    - title text box geometry and gradient style.
  - Replace only the text content needed for the new deck.
  - Do not redraw the cover decoration with manually created arcs or other approximate shapes.

- **Gradient text**
  - Preserve title gradient fills as DrawingML `<a:gradFill>`.
  - Do not flatten gradient text to a single solid color.
  - For the cover title, preserve the reference typography and fill: `Poppins SemiBold`, 32 pt, multi-stop gradient.

- **Gradient lines and box borders**
  - Preserve the reference gradient treatment for brand lines, dividers, connectors, and borders.
  - In this reference, brand box/card borders commonly use green-to-blue gradient DrawingML:
    - start: `56B093`;
    - end: `307FE2`;
    - `<a:gradFill>` inside `<a:ln>`.
  - Do not leave primary brand box borders as a single `solidFill` when the matching reference pattern uses a gradient.
  - Warning/assumption boxes may keep amber solid borders when that color encodes status rather than brand styling.

- **Icons in text boxes/cards**
  - When creating or redesigning boxes/cards that contain text, include a small meaningful icon where practical.
  - Icons should support scanning and clarify the box meaning, not act as generic decoration.
  - Prefer icons from a consistent outline icon library such as Lucide (`https://lucide.dev/icons/`) when the reference deck does not provide a stronger icon system.
  - Avoid generic PowerPoint flowchart symbols as card icons unless the reference deck uses that language explicitly.
  - When using library icons in generated PPTX files, embed them as lightweight SVG/vector assets where possible and keep the icon set small and semantically mapped.
  - For Novigo/TXT TRUDI-style references such as `ui/trudi-2.0-04.png`, render icons as white outline symbols centered inside a filled circular green-to-blue gradient badge.
  - Keep icon size, stroke, color, and alignment consistent across a slide.
  - Do not use icons when they would overcrowd dense tables, warning notes, footers, or very small labels.
  - Do not invent client logos or product logos; use only generic capability/process icons unless a source asset is provided.

- **Box detection**
  - Do not check only shapes that contain visible text.
  - In generated and reference PPTX files, a visual card may be a `roundRect` shape with no text, while the title/body text is layered in separate text boxes.
  - Validate the border/fill styling of the underlying `roundRect`/`rect` shapes directly.

- **Validation checks**
  - Count brand `roundRect`/card borders that still use `solidFill` instead of `gradFill`; this count should be zero unless explicitly justified.
  - Check that faux-logo text is absent where a logo picture should be used.
  - Check that cover title, logo, and right-side decoration match the reference slide geometry and object type.

## Final Check

Before finalizing, verify:

- the five storyline sections are present or intentionally adapted;
- every substantive claim is grounded in `docs/`, user-provided material, or explicit assumptions;
- outputs are saved in the project root;
- titles communicate slide messages;
- slide text is not overloaded;
- diagrams, tables, roadmap, and economics are legible;
- no confidential reference content was copied accidentally.

## PPTX Package Hygiene

After generating a `.pptx`, validate and normalize the OPC package before delivery:

- `unzip -t <file>.pptx`
- parse all `.xml` files
- verify every `[Content_Types].xml` Override points to an existing part
- verify every `.rels` target resolves
- avoid decorative shapes with weak PowerPoint compatibility when simple shapes are enough
- export temporarily to PDF with LibreOffice as a smoke test

### PowerPoint Repair Prevention

PowerPoint can report "problem with content" even when `unzip -t`, XML parsing, relationship checks, and LibreOffice export all pass. Treat PowerPoint's repair behavior as the highest-fidelity signal.

When generating with `pptxgenjs`, explicitly check for these known issues before delivering:

1. **Dangling content type overrides**
   - Inspect `[Content_Types].xml`.
   - Remove every `<Override>` whose `PartName` points to a package part that does not exist.
   - Known failure pattern: declarations for `ppt/slideMasters/slideMaster2.xml` ... `slideMasterN.xml` while only `ppt/slideMasters/slideMaster1.xml` exists.

2. **Non-canonical empty XML elements**
   - PowerPoint repaired generated decks by rewriting empty paired tags into self-closing tags.
   - Normalize harmless empty elements where possible:
     - `<a:ln></a:ln>` -> `<a:ln/>`
     - `<a:avLst></a:avLst>` -> `<a:avLst/>`
     - `<p:nvPr></p:nvPr>` -> `<p:nvPr/>`
   - Do not remove non-empty line, geometry, or non-visual properties; only canonicalize empty elements.

3. **PowerPoint-saved baseline comparison**
   - If PowerPoint repairs a generated deck and the user saves the repaired file, compare the generated and repaired packages.
   - Preserve visible slide content unless PowerPoint changed it.
   - Prefer adopting package-level normalization from the repaired file: content types, properties, notes metadata, and self-closing XML normalization.
   - Do not blindly copy theme files from a repaired baseline; a repaired baseline may contain fallback Office/Aptos themes and can visually regress fonts, colors, and object styling.

4. **Notes master and theme normalization**
   - A generated package can pass structural checks but still trigger PowerPoint repair because notes metadata is not PowerPoint-canonical.
   - Known failure pattern observed with `pptxgenjs`:
     - generated deck contains `ppt/theme/theme1.xml` only;
     - generated `ppt/notesMasters/_rels/notesMaster1.xml.rels` points notes master to `../theme/theme1.xml`;
     - generated `ppt/notesMasters/notesMaster1.xml` contains notes placeholder scaffold such as "Click to edit Master text styles";
     - PowerPoint repair adds `ppt/theme/theme2.xml`, rewrites the notes master relationship to `../theme/theme2.xml`, minimizes `notesMaster1.xml`, and rewrites presentation properties.
   - Fix by adopting the PowerPoint-saved package-level parts when a repaired baseline is available:
     - `ppt/theme/theme2.xml`;
     - `ppt/notesMasters/notesMaster1.xml`;
     - `ppt/notesMasters/_rels/notesMaster1.xml.rels`;
     - `ppt/presProps.xml`;
     - the content type override for `/ppt/theme/theme2.xml`.
   - If no repaired baseline is available, create a canonical notes theme part, point the notes master relationship to `../theme/theme2.xml`, remove notes placeholder scaffold from `notesMaster1.xml`, and add a valid content type override for `/ppt/theme/theme2.xml`.
   - This normalization must not alter visible slide text, storyline, or assets.

5. **Presentation metadata normalization**
   - PowerPoint may reorder `ppt/presentation.xml` so `notesMasterIdLst` appears before `sldIdLst` and may add a presentation extension list.
   - Treat these as package metadata fixes only. Apply them only when they can be done mechanically or copied from a repaired baseline with the same slide structure.

6. **Invalid negative shape extents**
   - PowerPoint repair can be triggered by generated DrawingML shape transforms with negative extents, for example `<a:ext cx="749808" cy="-45720"/>`.
   - This can happen when `pptxgenjs` line shapes are created with negative `w` or `h`.
   - Do not generate line shapes with negative width or height. Rewrite the geometry, flatten minor negative offsets, or use a connector/shape approach that produces non-negative `cx` and `cy`.
   - Before delivery, scan all slide XML for `<a:ext>` values where `cx < 0` or `cy < 0`; fix or fail validation.
   - If a repaired PowerPoint baseline exists, compare whether PowerPoint changed negative extents to zero or positive values and mirror that behavior when it does not alter visible content.

7. **Slide XML canonicalization**
   - PowerPoint may canonicalize empty slide elements without changing visible content:
     - `<p:cNvPr ...></p:cNvPr>` -> `<p:cNvPr .../>`;
     - `<a:bodyPr ...></a:bodyPr>` -> `<a:bodyPr .../>`;
     - shape-only `<p:sp>` elements may receive an empty `<p:txBody>`.
   - These changes are usually secondary. Avoid adding empty text bodies to every shape unless it is proven necessary, because it can make purely graphical shapes behave differently in PowerPoint.
   - If PowerPoint still repairs a package after structural checks pass, compare slide XML against the repaired baseline and adopt canonical slide XML only when visible text and slide structure match and object editability is not degraded.

8. **Decorative shapes**
   - Do not assume decorative shapes are the cause unless PowerPoint removes or changes them during repair.
   - In the observed repair, `prst="arc"` shapes were preserved by PowerPoint, so arcs were not the primary cause.
   - Still prefer simple shapes unless the design reference clearly benefits from the decoration.

### Required Validation Script Logic

Before final delivery of a generated `.pptx`, run or implement equivalent checks:

- unzip the package to `/tmp`;
- parse every `.xml` file;
- parse `[Content_Types].xml` and fail if any `Override PartName` does not exist;
- parse every `.rels` file and fail if any non-external target does not exist;
- check for suspicious generated XML patterns and normalize them in a new file, not in-place:
  - empty paired `<a:ln></a:ln>`;
  - empty paired `<a:avLst></a:avLst>`;
  - empty paired `<p:nvPr></p:nvPr>`;
- check notes master/theme canonicalization:
  - `ppt/notesMasters/_rels/notesMaster1.xml.rels` should resolve;
  - if a notes master exists, ensure its theme relationship points to an existing theme part;
  - if PowerPoint previously repaired the file by adding `theme2.xml`, include that theme part and content type override in regenerated files;
  - remove generated notes-master placeholder scaffold when it is not part of visible deck content;
- check every `<a:ext>` in slide XML and fail or normalize if any `cx` or `cy` is negative;
- repackage the `.pptx`;
- run `unzip -t` on the repackaged file;
- export to a temporary PDF with LibreOffice;
- if available, open in PowerPoint or ask the user to confirm PowerPoint opens without repair.

Never overwrite the original generated deck when repairing package structure. Write a new file with a clear suffix such as `- Fixed.pptx` or regenerate cleanly from the script.
