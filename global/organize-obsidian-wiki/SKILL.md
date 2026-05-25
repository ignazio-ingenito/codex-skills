---
name: organize-obsidian-wiki
description: Organize an Obsidian vault into a linked personal wiki for use as conversational memory with Codex. Use when the user asks to read, clean up, classify, connect, summarize, deduplicate, or turn Obsidian notes into durable wiki/project/reference notes; when a discussion should consult the vault; or when Codex needs to preserve personal context without inventing memory. For this user, treat the OneDrive Obsidian vault as read-only and create derived files only in the support workspace after explicit confirmation.
---

# Organize Obsidian Wiki

## Overview

Use this skill to treat an Obsidian vault as a personal wiki source: inspect existing notes, preserve raw context, create curated derived notes, and keep links, status, and terminology coherent.

For `/mnt/c/Users/iingenito/OneDrive - TXT e-solutions S.p.A/Documents/Obsidian Vault`, use the vault only for reading unless the user explicitly approves a write. Put generated files in `/home/iingenito/projects/personal/obsidian`.

When working from `/home/iingenito/projects/personal/obsidian`, read `AGENTS.md` first if present. Read `CONTEXT.md` when terminology, note categories, or domain language matter.

For the default conventions, read [references/vault-conventions.md](references/vault-conventions.md) when creating or reorganizing derived notes.

## Workflow

1. Locate the source vault and workspace.
   - Default source vault: `/mnt/c/Users/iingenito/OneDrive - TXT e-solutions S.p.A/Documents/Obsidian Vault`.
   - Default workspace for generated files: `/home/iingenito/projects/personal/obsidian`.
   - If unclear, ask before assuming a different write location.

2. Build local context before changing notes.
   - Use `rg --files` to list markdown files.
   - Use `rg` for the relevant topic, aliases, tags, and related project names.
   - Read only the notes needed for the task.
   - Distinguish facts found in notes from inferences made during the discussion.

3. Classify notes conservatively.
   - Keep unprocessed fragments as raw notes.
   - Promote only stable, connected, understandable material into wiki notes.
   - Preserve original wording when details may be legally, personally, or historically significant.

4. Ask before editing.
   - Before any file modification, ask for explicit confirmation.
   - Never create, edit, move, or delete files inside the source vault unless the user explicitly approves that exact scope.
   - Write derived files only in the workspace after confirmation.

5. Edit in small batches.
   - Prefer targeted edits, frontmatter normalization, link additions, and short summaries.
   - Avoid broad rewrites unless the user explicitly asks for synthesis.
   - Maintain dates as absolute dates when events, decisions, or deadlines are involved.

6. Check coherence.
   - Look for duplicate notes, conflicting terminology, stale status, missing backlinks, and orphaned concepts.
   - If a canonical term is chosen, propose an update to workspace `CONTEXT.md`.
   - Create ADR-style decision notes only for durable, non-obvious decisions with real trade-offs.

7. Report what changed.
   - List created or edited files.
   - Mention any unresolved ambiguity or notes that need user judgment.
   - Cite vault files used as sources.

## Adding Notes

When using this skill to add an appunto intended for Obsidian, always handle the note as part of the vault structure, not as an isolated file:

1. Search the source vault first.
   - Look for the note topic, aliases, project/client names, technologies, and likely synonyms.
   - Check whether an existing note should be updated or linked instead of creating a new note.

2. Choose the best location.
   - Propose the folder/path that best matches the existing vault organization.
   - If the location is ambiguous, state the alternatives and the recommended one.
   - Remember that the user's real Obsidian vault is read-only by default; create or modify files only after explicit approval and only in the approved location.

3. Add tags.
   - Add relevant area, client/context, project, technology, document type, status, and sensitivity tags.
   - Prefer the user's established tag taxonomy when present.
   - Mark notes containing credentials, tokens, IPs, private URLs, HR/personal data, or other restricted operational details with a sensitivity tag.

4. Check duplicates and conflicts.
   - Report possible duplicate notes before creating or changing content.
   - Flag conflicting facts, naming differences, stale status, or overlapping concepts.
   - Preserve original wording when the conflict cannot be safely resolved.

5. Add Obsidian links.
   - Add `[[...]]` links to related hub, project, meeting, architecture, procedure, and reference notes.
   - Prefer links that create useful backlinks in Obsidian Graph View.
   - Avoid treating embedded attachments `![[...]]` as conceptual relationships.

6. Summarize the integration.
   - State the chosen path, tags, related notes, duplicates/conflicts found, and links added or proposed.

## Note Types

Use the source vault's existing structure as reading context. For generated files in the workspace, use:

- `Inbox/` for raw, unprocessed notes.
- `Wiki/` for curated, stable notes.
- `Projects/` for active initiatives with objectives, status, next actions, and decisions.
- `Areas/` for ongoing responsibilities.
- `References/` for source material and extracted references.
- `Archive/` for inactive material worth keeping.

## Editing Standards

- Use Obsidian links like `[[Note Title]]` inside notes.
- Use YAML frontmatter only when it helps filtering or maintenance.
- Keep frontmatter keys simple: `type`, `status`, `updated`, `tags`.
- Prefer `status: draft`, `status: active`, `status: stable`, or `status: archived`.
- Add a short `## Sintesi` section to curated notes when useful.
- Add `## Domande Aperte` when the note depends on unresolved assumptions.

## Safety Rules

- Do not invent personal memory that is not in the vault or current conversation.
- Do not delete raw notes merely because a summary was created.
- Do not collapse conflicting notes into one narrative without flagging the conflict.
- Ask before any file modification.
- Treat the OneDrive Obsidian vault as read-only by default.
