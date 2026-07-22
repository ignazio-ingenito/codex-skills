# Codex Skills

Repository canonico delle skill Codex locali.

- `global/`: skill riusabili, installate in `$CODEX_HOME/skills`.
- `projects/<project-name>/`: skill legate a un progetto, installate in `.agents/skills`.

## Struttura

```text
global/
  skill-name/
    SKILL.md
    agents/openai.yaml   # metadati UI opzionali
    scripts/             # helper deterministici opzionali
    references/          # contesto caricato su richiesta
    assets/              # template o file binari opzionali
projects/
  project-name/
    skill-name/
      SKILL.md
scripts/
  install-local.sh
  install-project.sh
  list-installed.sh
  sync-from-codex.sh
  validate-skills.sh
```

`grill-with-docs` esiste sia tra le skill globali sia in CAP Aeris: le due versioni non sono identiche e restano separate finché non viene decisa una generalizzazione esplicita.

## Inventario

### Globali

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `ask-skills` | `mattpocock/skills` | Individua la skill o il flusso adatto. |
| `brainstorming` | `obra/superpowers` | Chiarisce intento, requisiti e design prima di modificare comportamento. |
| `caveman` | `mattpocock/skills` | Riduce al minimo parole e token. |
| `code-review-and-quality` | `addyosmani/agent-skills` | Revisiona correttezza, leggibilità, architettura, sicurezza e performance. |
| `code-simplification` | `addyosmani/agent-skills` | Semplifica codice funzionante senza cambiarne il comportamento. |
| `codebase-design` | `mattpocock/skills` | Progetta moduli profondi, interfacce piccole e seam puliti. |
| `challenge-me` | locale | Falsifica raccomandazioni e cerca alternative più semplici e reversibili. |
| `critic` | locale | Attacca assunzioni, costi nascosti e complessità non necessaria. |
| `domain-modeling` | `mattpocock/skills` | Definisce termini, relazioni, invarianti e decisioni di dominio. |
| `grill-with-docs` | locale | Stressa piani contro dominio, documentazione e decisioni. |
| `grilling` | `mattpocock/skills` | Intervista in profondità finché le ambiguità sono risolte. |
| `handoff` | `mattpocock/skills` | Compatta una sessione per consentire a un altro agente di continuarla. |
| `humanize-writing` | `jpeggdev/humanize-writing` | Rende il testo più naturale e meno artificiale. |
| `idea-refine` | `addyosmani/agent-skills` | Trasforma idee grezze in concetti chiari e azionabili. |
| `improve-codebase-architecture` | `mattpocock/skills` | Individua attriti architetturali e opportunità di refactor. |
| `interview-me` | `addyosmani/agent-skills` | Chiarisce il bisogno reale una domanda alla volta. |
| `office-hours` | `garrytan/gstack` | Valuta idee, focus e ambizione di prodotto con domande stile YC. |
| `playwright` | `openai/skills` | Automatizza browser reali con Playwright CLI. |
| `prototype` | `mattpocock/skills` | Crea prototipi throwaway per validare design, stato o UI. |
| `receiving-code-review` | `obra/superpowers` | Valuta feedback di review prima di applicarlo. |
| `research` | `mattpocock/skills` | Ricerca con fonti primarie e salva risultati citati. |
| `requesting-code-review` | `obra/superpowers` | Prepara contesto e range per una review. |
| `resolving-merge-conflicts` | `mattpocock/skills` | Risolve conflitti ricostruendo l’intento delle versioni. |
| `senior-implementation-discipline` | locale | Impone disciplina da maintainer su cambi condivisi e rischiosi. |
| `setup-matt-pocock-skills` | `mattpocock/skills` | Configura tracker, label e layout richiesti dalle skill importate. |
| `systematic-debugging` | `obra/superpowers` | Diagnostica prima di proporre fix. |
| `tdd` | `mattpocock/skills` | Guida implementazioni e bugfix con red-green-refactor. |
| `teach` | `mattpocock/skills` | Gestisce percorsi didattici stateful con lezioni, fonti e learning record. |
| `to-spec` | `mattpocock/skills` | Trasforma la conversazione in una specifica pubblicabile. |
| `to-tickets` | `mattpocock/skills` | Divide piani e specifiche in ticket con dipendenze esplicite. |
| `triage` | `mattpocock/skills` | Classifica issue, bug e feature request. |
| `using-git-worktrees` | `obra/superpowers` | Isola feature work e piani complessi con git worktree. |
| `verification-before-completion` | `obra/superpowers` | Richiede evidenze prima di dichiarare un lavoro completato. |
| `wayfinder` | `mattpocock/skills` | Pianifica lavori oltre una sessione tramite ticket di investigazione. |
| `writing-plans` | `obra/superpowers` | Scrive piani multi-step prima dell’implementazione. |
| `writing-skills` | `obra/superpowers` | Crea, modifica e verifica skill. |
| `zoom-out` | `mattpocock/skills` | Ricostruisce la mappa ad alto livello di codice e chiamanti. |

### CAP Aeris

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `api-and-interface-design` | `addyosmani/agent-skills` | Progetta API, contratti e confini frontend/backend. |
| `browser-testing-with-devtools` | `addyosmani/agent-skills` | Verifica UI con DOM, console, network e runtime reale. |
| `deprecation-and-migration` | `addyosmani/agent-skills` | Gestisce rimozioni, migrazioni e sunset. |
| `diagnose` | locale CAP | Diagnostica con riproduzione, ipotesi, strumentazione e regressione. |
| `documentation-and-adrs` | `addyosmani/agent-skills` | Registra decisioni e ADR utili a sviluppatori e agenti. |
| `grill-with-docs` | locale CAP | Stressa piani contro documenti, UI, wiki e decisioni CAP. |
| `improve-codebase-architecture` | `mattpocock/skills` | Individua attriti architetturali e refactor profondi. |
| `performance-optimization` | `addyosmani/agent-skills` | Ottimizza bottleneck misurati. |
| `planning-and-task-breakdown` | `addyosmani/agent-skills` | Divide requisiti in task ordinati e verificabili. |
| `prototype` | `mattpocock/skills` | Valida UI, stati e flussi con prototipi throwaway. |
| `security-and-hardening` | `addyosmani/agent-skills` | Rafforza input, sessioni, dati e integrazioni. |
| `source-driven-development` | `addyosmani/agent-skills` | Ancora le decisioni a fonti autorevoli. |
| `systematic-debugging` | `obra/superpowers` | Diagnostica prima di cambiare codice. |
| `tdd` | locale CAP | Applica red-green-refactor sulle interfacce pubbliche. |
| `triage` | `mattpocock/skills` | Classifica issue CAP prima che diventino lavoro. |
| `update-docs` | locale CAP | Aggiorna documentazione quando cambiano comportamenti o assunzioni. |
| `verification-before-completion` | `obra/superpowers` | Richiede verifiche concrete prima della chiusura. |
| `write-tests` | locale CAP | Aggiunge test coerenti con dominio e documentazione. |
| `writing-plans` | `obra/superpowers` | Produce piani prima dell’implementazione. |
| `zoom-out` | `mattpocock/skills` | Fornisce contesto su moduli, chiamanti e dominio. |

### Baialupo

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `baia-publish` | locale | Pubblica contenuti seguendo workflow editoriale, fonti, immagini ed eventi. |

### Cantieri Protetti AI

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `documentation-and-adrs` | `addyosmani/agent-skills` | Registra decisioni su dominio, payload, API, OCR, LLM e persistenza. |
| `grill-with-docs` | locale | Stressa decisioni contro `CONTEXT.md`, ADR e dominio. |
| `security-and-hardening` | `addyosmani/agent-skills` | Protegge privacy, segreti, file, API e documenti sensibili. |
| `source-driven-development` | `addyosmani/agent-skills` | Ancora implementazioni a fonti tecniche aggiornate. |
| `systematic-debugging` | `obra/superpowers` | Diagnostica pipeline PDF, OCR, LLM, API e CLI. |
| `verification-before-completion` | `obra/superpowers` | Verifica test, lint, CLI e payload prima della chiusura. |

### Homelab

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `grill-with-docs` | locale | Stressa piani GitOps, rete, backup e architettura. |
| `homelab-app-onboarding` | locale | Onboarding applicazioni con manifest, ArgoCD, SOPS, CNPG, routing e backup. |
| `homelab-backup-restore` | locale | Backup, restore e recovery drill. |
| `homelab-ceph-storage-operations` | locale | Ceph, CSI, RGW, RBD, PVC e bucket S3. |
| `homelab-cloudflare-operations` | locale | DNS, Access, Zero Trust e tunnel Cloudflare. |
| `homelab-gateway-routes` | locale | HTTPRoute, Gateway API, Traefik e ingress Cloudflare. |
| `homelab-gitops-operations` | locale | Modifiche GitOps, sync ArgoCD, Kustomize e verifiche live. |
| `homelab-implementation-planning` | locale | Piani di migrazione, rollout, rollback e commit strategy. |
| `homelab-kubernetes-operations` | locale | K3s, risorse, CRD, operatori, rollout, servizi e log. |
| `homelab-network-readiness` | `affaan-m/everything-claude-code` | Verifica rete, DNS, firewall e accesso remoto. |
| `homelab-observability-operations` | locale | Grafana, Loki, Prometheus, Alloy, dashboard e alerting. |
| `homelab-opentofu-terraform` | locale | Terraform/OpenTofu per Cloudflare e state. |
| `homelab-proxmox-operations` | locale | Proxmox, PBS, Ceph, VM/LXC, nodi e storage. |
| `homelab-review-and-debt` | locale | Review del repo per rischio, drift, sicurezza e debito tecnico. |
| `homelab-secret-management` | locale | SOPS, Age, token, credenziali e leak check. |
| `network-config-validation` | `affaan-m/everything-claude-code` | Valida indirizzi, subnet e rischi management-plane. |
| `security-review` | `affaan-m/everything-claude-code` | Controlla segreti, configurazioni, accessi e superfici esposte. |
| `systematic-debugging` | `obra/superpowers` | Diagnostica GitOps, Kubernetes, DNS, Cloudflare, monitoring e backup. |
| `verification-before-completion` | `obra/superpowers` | Verifica comandi, manifest, sync e stato cluster. |

### Obsidian

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `organize-obsidian-wiki` | locale | Organizza il vault senza modificarlo senza conferma. |
| `verification-before-completion` | `obra/superpowers` | Controlla link, duplicati, output e confini read-only. |

### Kong

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `read-vdo-hour-meter` | locale | Legge foto di orametri VDO e genera `readings.yml`. |

### PowerPoint

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `grill-with-docs` | locale | Verifica storyline e assunzioni contro le fonti. |
| `powerpoint-deck-production` | locale | Produce o modifica deck editabili e source-grounded. |
| `pptx-quality-review` | locale | Revisiona storyline, grounding, coerenza visiva e deliverable. |

## Forma di una skill

Ogni skill vive in una directory con `SKILL.md` e frontmatter YAML:

```yaml
---
name: skill-name
description: Quando Codex deve usare questa skill.
---
```

`description` deve essere precisa: Codex la usa per decidere se attivare la skill. Riferimenti lunghi vanno in `references/`; helper deterministici in `scripts/`.

## Installazione

Skill globali:

```bash
scripts/install-local.sh
scripts/install-local.sh playwright grill-with-docs
scripts/install-local.sh --replace
```

Skill di progetto:

```bash
scripts/install-project.sh cap-aeris /home/iingenito/projects/personal/cap-aeris
scripts/install-project.sh --replace cap-aeris /home/iingenito/projects/personal/cap-aeris
```

Gli script usano symlink e non sovrascrivono directory reali. Con `--replace`, spostano prima le voci esistenti in backup con timestamp. Riavvia Codex dopo installazioni o modifiche.

Percorsi runtime:

- globali: `$CODEX_HOME/skills/<skill-name>`
- progetto: `<project-root>/.agents/skills/<skill-name>`

## Sincronizzazione e verifica

```bash
scripts/sync-from-codex.sh
scripts/sync-from-codex.sh --force
scripts/list-installed.sh
scripts/validate-skills.sh
bash -n scripts/*.sh
git status --short
```

`sync-from-codex.sh` salta le skill `.system` e non sovrascrive file esistenti senza `--force`. Le skill di progetto vanno importate manualmente in `projects/<project-name>/`.

`list-installed.sh` usa `find -L`, quindi segue i symlink; un normale `find ~/.codex/skills -type d` non basta.

## Aggiungere una skill

1. Scegli `global/` o `projects/<project-name>/`.
2. Crea `SKILL.md` e gli eventuali file di supporto.
3. Esegui validazione, controllo shell e `git status`.
4. Installa la skill e riavvia Codex.
5. Verifica l’attivazione con un prompt realistico.

## Commit e changelog

Usa Conventional Commits in inglese, per esempio:

```text
feat: add a new project skill
fix: handle existing symlink during install
docs: update skill usage guide
chore: organize skills by scope
ci: generate changelog automatically
```

Il changelog è generato automaticamente con `git-cliff` a ogni push su `main` e quando la workflow `Changelog` viene avviata manualmente.
