# Vault Conventions

These conventions apply to the support workspace `/home/iingenito/projects/personal/obsidian`.

The real Obsidian vault is `/mnt/c/Users/iingenito/OneDrive - TXT e-solutions S.p.A/Documents/Obsidian Vault`. Treat it as a read-only source unless the user explicitly approves a specific write.

## Language

- Write notes and responses in Italian unless the source note or user request uses another language.
- Use "vault" for the real Obsidian directory.
- Use "workspace" for `/home/iingenito/projects/personal/obsidian`.
- Use "wiki personale" for curated notes intended as durable conversational memory.
- Use "nota grezza" for unprocessed capture.
- Use "nota curata" for reviewed wiki material.

## Recommended Workspace Directories

- `Inbox/`: unprocessed captures and temporary notes.
- `Wiki/`: durable personal knowledge.
- `Projects/`: active projects.
- `Areas/`: ongoing responsibilities.
- `References/`: external sources, excerpts, schemas, manuals, and copied material.
- `Archive/`: inactive notes retained for history.

## Curated Wiki Note Template

```md
---
type: wiki
status: draft
updated: YYYY-MM-DD
tags: []
---

# Title

## Sintesi

## Dettagli

## Collegamenti

## Domande Aperte
```

## Project Note Template

```md
---
type: project
status: active
updated: YYYY-MM-DD
tags: []
---

# Project Name

## Obiettivo

## Stato

## Prossime Azioni

## Decisioni

## Collegamenti
```

## Review Checklist

- Every curated note has a clear title.
- Important concepts link to related notes.
- Dates are absolute, not relative.
- Open questions are explicit.
- Raw source notes remain available when a summary is created.
