---
name: update-docs
description: Use this skill when behavior, workflows, architecture, UI, or assumptions change.
---

# Update Documentation

Use this skill when behavior, workflows, architecture, UI, or assumptions change.

## Read First

- `AGENTS.md`
- affected files in `docs/cap/`
- affected files in `docs/ui/`
- `docs/wiki/`
- `docs/architecture.md`

## Steps

1. Identify what changed.
2. Identify the correct documentation area.
3. Do not modify primary CAP source documents in `docs/cap/` unless explicitly requested.
4. Put interpretations, decisions, and cross-source conclusions in `docs/wiki/syntheses/`.
5. Put unresolved questions in `docs/wiki/questions/`.
6. Update project-level guidance files only for stable guidance that applies across features.
7. Update only the relevant sections.
8. Do not duplicate large blocks of information.
9. Add unclear items to `Open Questions`.
10. Keep documentation concise and operational.
11. When documentation references code, use English identifiers for code-level names and keep Italian only for user-facing labels or source-document terminology.

## Definition of Done

- Documentation matches implementation.
- No obsolete behavior remains documented.
- Open questions are explicit.
- Primary source material remains unchanged unless explicitly intended.
