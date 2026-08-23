# Codex Skills

**Stato:** Active

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

## Fonti autorevoli e lifecycle documentale

- `global/` e `projects/` contengono le fonti operative autorevoli delle skill.
- [`global/ask-skills/SKILL.md`](global/ask-skills/SKILL.md) è la fonte autorevole per il routing generale; le singole `SKILL.md` governano il comportamento dettagliato.
- Questo README è il catalogo pubblico dello stato corrente. Le skill rimosse scompaiono dall'inventario e restano tracciate nella cronologia Git e nel `CHANGELOG.md`.
- `AGENTS.md` e la RFC-0001 attiva governano il repository. Piani, specifiche e review sotto `docs/` dichiarano il proprio stato e, quando `Archived`, valgono solo come evidenza storica.

## Percorsi consigliati

La mappa riguarda esclusivamente le skill globali. Le skill di progetto avranno percorsi dedicati, perché dipendono dal dominio e dalle convenzioni del singolo repository.

<p align="center">
  <a href="docs/assets/global-skill-routing.svg">
    <img src="docs/assets/global-skill-routing.svg" alt="Percorsi consigliati per scegliere e concatenare le skill globali Codex nei principali scenari di sviluppo" width="100%">
  </a>
</p>

Apri l’immagine per leggerla a piena risoluzione o ingrandirla su schermi piccoli.

- Bordo continuo: passaggio normalmente richiesto.
- Bordo tratteggiato: passaggio condizionale, da usare solo quando vale la nota.
- `D`: coda comune di delivery e verifica.
- `prototype`: esperimento throwaway; se il risultato deve evolvere in prodotto, si torna prima a design e pianificazione.

Il router canonico e i criteri di scelta restano in [`global/ask-skills/SKILL.md`](global/ask-skills/SKILL.md); l’infografica è un orientamento rapido, non una seconda fonte normativa.

## Inventario

### Globali

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `agent-loop` | locale | Coordina explorer, main agent, worker e reviewer per task autonomi bounded. |
| `ask-skills` | `mattpocock/skills` | Individua la skill o il flusso adatto. |
| `brainstorming` | `obra/superpowers` | Chiarisce intento, requisiti e design prima di modificare comportamento. |
| `caveman` | `mattpocock/skills` | Riduce al minimo parole e token. |
| `code-debt-review-loop` | locale | Individua e ordina debito tecnico, hotspot e refactor sicuri prima dell’implementazione. |
| `code-review-and-quality` | `addyosmani/agent-skills` | Revisiona correttezza, leggibilità, architettura, sicurezza e performance. |
| `code-simplification` | `addyosmani/agent-skills` | Semplifica codice funzionante senza cambiarne il comportamento. |
| `codebase-design` | `mattpocock/skills` | Progetta moduli profondi, interfacce piccole e seam puliti. |
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
| `reality-check` | locale | Verifica fonti e decisioni già determinate prima di porre domande o introdurre complessità. |
| `receiving-code-review` | `obra/superpowers` | Valuta feedback di review prima di applicarlo. |
| `research` | `mattpocock/skills` | Ricerca con fonti primarie e salva risultati citati. |
| `scrittura-comica` | locale | Scrive o adatta testi creativi con tono umoristico, ironico o satirico leggero. |
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
| `ui-depth-preview` | locale | Genera preview controllate del layering/depth di una UI esistente. |
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
| `grill-with-screenshots` | locale CAP | Valuta UX, UI, responsività e accessibilità a partire da screenshot reali. |
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
| `homelab-opentofu-terraform` | locale | OpenTofu per Cloudflare, Harbor e state. |
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

### iWant

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `frontend-design-review` | locale | Revisiona fedeltà visuale, struttura e comportamento dell'interfaccia. |

### PowerPoint

| Skill | Sorgente | Uso |
| --- | --- | --- |
| `grill-with-docs` | locale | Verifica storyline e assunzioni contro le fonti. |
| `business-case-storyline` | locale | Costruisce la storyline di un business case. |
| `commercial-deck-quality-review` | locale | Revisiona qualità e coerenza di un deck commerciale. |
| `deck-visual-grounding` | locale | Verifica il grounding visuale del deck rispetto alle fonti. |
| `executive-slide-writing` | locale | Scrive contenuti sintetici per slide executive. |
| `powerpoint-deck-production` | locale | Produce o modifica deck editabili e source-grounded. |
| `powerpoint-manipulation` | locale | Modifica presentazioni PowerPoint mantenendo il pacchetto editabile. |
| `pptx-package-validation` | locale | Valida struttura e integrità del pacchetto PPTX. |
| `pptx-quality-review` | locale | Revisiona storyline, grounding, coerenza visiva e deliverable. |
| `pptx-template-extraction` | locale | Estrae riferimenti e struttura da template PPTX. |
| `proposal-intake` | locale | Trasforma una richiesta commerciale in un input di produzione. |
| `repo-to-deck-brief` | locale | Converte evidenze di repository in un brief per deck. |
| `software-delivery-estimation` | locale | Stima lavoro e vincoli di una delivery software. |
| `wbs-generation` | locale | Genera una work breakdown structure verificabile. |

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
scripts/validate-skills.sh
```