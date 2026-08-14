# Codex Skills - Agent Instructions

## Repository Purpose

This repository stores personal and project-specific Codex skills.

## Agent OS e lifecycle delle skill

- Prima di analizzare, pianificare, modificare o creare issue o pull request, si DEVE leggere integralmente la versione corrente di [RFC-0001 – Principi fondanti della Software Factory](https://github.com/ignazio-ingenito/agent-os/blob/main/rfcs/RFC-0001-principles.md).
- Se la fonte non è accessibile, il lavoro DEVE fermarsi.
- Le regole locali possono restringere la RFC, ma non indebolirla; conflitti o deroghe richiedono l'autorizzazione esplicita dell'utente o di una fonte attiva approvata di autorità superiore.
- Il contenuto della RFC non DEVE essere duplicato in questo repository.
- `global/` e `projects/` sono le sorgenti autorevoli delle skill; i progetti consumatori devono usare symlink installati dagli script, senza copie locali tracciate.

## Shared Global Instructions

- `AGENTS.global.md` contains cross-project agent behavior rules.
- It is not a skill and should not live under `global/` or `projects/`.
- Link it into a project as that project's `AGENTS.md` when the rules must always be active.
- Use `bash scripts/install-global-agents.sh <project-root>` to install the link.
- Use `--replace` only when intentionally backing up and replacing an existing project `AGENTS.md`.

## Commit Rules

- Use Conventional Commits for every commit message.
- Suggested commit messages must always be written in English.
- Keep documentation in Italian unless a technical identifier, command, path, or upstream project name requires English.

## Changelog

- `CHANGELOG.md` is historical release documentation; do not claim automatic generation unless a current workflow proves it.
- `cliff.toml` is the retained git-cliff configuration and must stay aligned with Conventional Commits categories when release/changelog automation uses it.
- Do not hand-edit generated release content when an active automation owns it.

## Repository intelligence

Optional repository-intelligence tools may be used when they are actually available and materially reduce uncertainty. They are not a universal prerequisite for documentation-only edits or for work where repository files, tests and Git history already provide sufficient evidence.

Do not reference untracked `.claude/skills/...` paths or require a specific external index as if it were part of this repository's canonical skill lifecycle. The authoritative skill sources remain `global/` and `projects/`.
