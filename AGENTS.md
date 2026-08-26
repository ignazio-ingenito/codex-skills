# Codex Skills - Agent Instructions

## Repository Purpose

This repository stores personal and project-specific Codex skills.

## Agent OS e lifecycle delle skill

- Prima di analizzare, pianificare, modificare o creare issue o pull request, si DEVE leggere integralmente la versione corrente di [RFC-0001 – Principi fondanti della Software Factory](https://github.com/skunklabs-uk/agent-os/blob/main/rfcs/RFC-0001-principles.md).
- Se la fonte non è accessibile, il lavoro DEVE fermarsi.
- Le regole locali possono restringere la RFC, ma non indebolirla; conflitti o deroghe richiedono l'autorizzazione esplicita dell'utente o di una fonte attiva approvata di autorità superiore.
- Il contenuto della RFC non DEVE essere duplicato in questo repository.
- `global/` e `projects/` sono le sorgenti autorevoli delle skill mantenute localmente; `config/global-skill-upstreams.tsv` è la sorgente autorevole per le skill globali consumate direttamente dai repository upstream originali.
- Una skill dichiarata in `config/global-skill-upstreams.tsv` NON DEVE essere copiata o vendorizzata in `global/` o `projects/`: l'installer deve usare il repository upstream e il commit approvati dal manifest.

## Shared Global Instructions

- `AGENTS.global.md` contains cross-project agent behavior rules.
- It is not a skill and should not live under `global/` or `projects/`.
- Link it into a project as that project's `AGENTS.md` when the rules must always be active.
- Use `bash scripts/install-global-agents.sh <project-root>` to install the link.
- Use `--replace` only when intentionally backing up and replacing an existing project `AGENTS.md`.

## Arresto e prosecuzione

Fermarsi solo quando il lavoro richiede una decisione non documentata, supera lo scope approvato, viola una fonte `Active`, comporta conseguenze rilevanti non valutate oppure richiede una verifica obbligatoria che resta ineseguibile dopo ragionevoli tentativi.

Prima di fermarsi, indicare la condizione applicabile, il fatto osservato e la decisione o informazione necessaria.

Una condizione di stop si applica al solo perimetro che la richiede. Il blocco di un task, una fase o un'operazione non blocca automaticamente l'intera missione: il lavoro già autorizzato e determinato che non dipende da quella condizione deve proseguire.

Quando la fonte attiva o il task corrente identifica già il lavoro successivo necessario nella stessa missione, proseguire senza chiedere una conferma meccanica, salvo che si applichi una condizione di stop reale.

Non fermarsi per passaggi già approvati, errori locali correggibili, verifiche risolvibili entro lo scope, stato documentale correggibile in modo univoco o fallback già autorizzati.

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

Do not reference untracked `.claude/skills/...` paths or require a specific external index as if it were part of this repository's canonical skill lifecycle. The authoritative local skill sources remain `global/` and `projects/`; direct upstream global skills are governed only by `config/global-skill-upstreams.tsv` and their pinned original repositories.
