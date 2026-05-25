# Codex Skills

Repository per skill Codex personali e specifiche di progetto.

Questo repository e la sorgente canonica delle skill locali. Le skill sono
organizzate per ambito: globali se riusabili in piu repository, specifiche di
progetto se contengono assunzioni, workflow o documentazione legati a un solo
progetto.

## Struttura

Usa due contenitori principali:

- `global/`: skill globali utili in piu repository, collegabili in
  `$CODEX_HOME/skills`.
- `projects/<project-name>/`: skill che hanno senso solo dentro un progetto e
  vanno collegate nella directory `.agents/skills` di quel progetto.

```text
global/                    # skill globali installate in $CODEX_HOME/skills
  skill-name/
    SKILL.md
    agents/openai.yaml      # metadati UI opzionali
    scripts/                # helper deterministici opzionali
    references/             # contesto opzionale caricato su richiesta
    assets/                 # template o asset binari opzionali
projects/                  # skill specifiche raggruppate per progetto
  project-name/
    skill-name/
      SKILL.md
scripts/
  install-local.sh          # collega le skill globali a Codex
  install-project.sh        # collega le skill progetto a .agents/skills
  list-installed.sh         # elenca le skill installate seguendo i symlink
  sync-from-codex.sh        # copia le skill locali installate nel repo
  validate-skills.sh        # valida la forma delle skill
```

Struttura attuale:

```text
global/
  brainstorming/
  caveman/
  code-review-and-quality/
  code-simplification/
  grill-with-docs/
  humanize-writing/
  idea-refine/
  improve-codebase-architecture/
  interview-me/
  office-hours/
  playwright/
  prototype/
  receiving-code-review/
  requesting-code-review/
  senior-implementation-discipline/
  systematic-debugging/
  triage/
  using-git-worktrees/
  verification-before-completion/
  writing-plans/
  writing-skills/
  zoom-out/
projects/
  baialupo/
    baia-publish/
  cap-aeris/
    api-and-interface-design/
    browser-testing-with-devtools/
    deprecation-and-migration/
    diagnose/
    documentation-and-adrs/
    grill-with-docs/
    improve-codebase-architecture/
    performance-optimization/
    planning-and-task-breakdown/
    prototype/
    security-and-hardening/
    source-driven-development/
    systematic-debugging/
    tdd/
    triage/
    update-docs/
    verification-before-completion/
    write-tests/
    writing-plans/
    zoom-out/
  cantieri-protetti-ai/
    documentation-and-adrs/
    grill-with-docs/
    security-and-hardening/
    source-driven-development/
    systematic-debugging/
    verification-before-completion/
  homelab/
    grill-with-docs/
    homelab-app-onboarding/
    homelab-backup-restore/
    homelab-ceph-storage-operations/
    homelab-cloudflare-operations/
    homelab-gateway-routes/
    homelab-gitops-operations/
    homelab-implementation-planning/
    homelab-kubernetes-operations/
    homelab-network-readiness/
    homelab-observability-operations/
    homelab-opentofu-terraform/
    homelab-proxmox-operations/
    homelab-review-and-debt/
    homelab-secret-management/
    network-config-validation/
    security-review/
    systematic-debugging/
    verification-before-completion/
  obsidian/
    organize-obsidian-wiki/
    verification-before-completion/
  powerpoint/
    grill-with-docs/
    powerpoint-deck-production/
    pptx-quality-review/
```

`grill-with-docs` esiste in entrambi i contenitori perche la versione globale e
quella CAP Aeris non sono identiche. Tienile separate, salvo decisione esplicita
di generalizzare la versione CAP.

## Inventario Skill

### Globali

| Skill | Repo sorgente | Descrizione breve |
| --- | --- | --- |
| `brainstorming` | `obra/superpowers` | Esplora intento, requisiti e design prima di lavori creativi o modifiche di comportamento. |
| `caveman` | `mattpocock/skills` | Modalita di comunicazione ultra-sintetica per ridurre token e rumore. |
| `code-review-and-quality` | `addyosmani/agent-skills` | Review multi-asse su correttezza, leggibilita, architettura, sicurezza e performance. |
| `code-simplification` | `addyosmani/agent-skills` | Semplifica codice gia funzionante preservando il comportamento. |
| `grill-with-docs` | personale locale | Stress-test di piani contro linguaggio di dominio, documentazione e decisioni. |
| `humanize-writing` | `jpeggdev/humanize-writing` | Rende testi meno robotici e piu naturali, rimuovendo pattern tipici della scrittura AI. |
| `idea-refine` | `addyosmani/agent-skills` | Trasforma idee grezze in concetti piu chiari e azionabili. |
| `improve-codebase-architecture` | `mattpocock/skills` | Cerca opportunita di miglioramento architetturale e testabilita. |
| `interview-me` | `addyosmani/agent-skills` | Intervista l'utente una domanda alla volta per chiarire il bisogno reale. |
| `office-hours` | `garrytan/gstack` | Domande stile YC/CEO per valutare idee, focus e ambizione di prodotto. |
| `playwright` | `openai/skills` | Automazione browser reale tramite Playwright CLI e workflow associati. |
| `prototype` | `mattpocock/skills` | Costruisce prototipi throwaway per validare design, stato o UI prima dell'implementazione. |
| `receiving-code-review` | `obra/superpowers` | Gestisce feedback di review con rigore tecnico prima di applicare modifiche. |
| `requesting-code-review` | `obra/superpowers` | Prepara richieste di review quando un lavoro e pronto o vicino al merge. |
| `senior-implementation-discipline` | personale locale | Impone disciplina da maintainer per modifiche a codice condiviso, contratti, dominio, persistenza, sicurezza e architettura. |
| `systematic-debugging` | `obra/superpowers` | Impone un ciclo disciplinato prima di proporre fix a bug o test rotti. |
| `triage` | `mattpocock/skills` | Triage di issue, bug e feature request tramite stati e ruoli. |
| `using-git-worktrees` | `obra/superpowers` | Usa workspace isolati con git worktree per feature work o piani complessi. |
| `verification-before-completion` | `obra/superpowers` | Richiede evidenze di verifica prima di dichiarare un lavoro completato. |
| `writing-plans` | `obra/superpowers` | Scrive piani per task multi-step prima di toccare codice. |
| `writing-skills` | `obra/superpowers` | Crea, modifica e verifica skill con struttura corretta. |
| `zoom-out` | `mattpocock/skills` | Chiede una mappa ad alto livello quando una parte di codice non e chiara. |

### CAP Aeris

| Skill | Repo sorgente | Descrizione breve |
| --- | --- | --- |
| `api-and-interface-design` | `addyosmani/agent-skills` | Guida design di API, contratti e confini frontend/backend. |
| `browser-testing-with-devtools` | `addyosmani/agent-skills` | Verifica UI browser con DevTools, DOM, console, network e runtime reale. |
| `deprecation-and-migration` | `addyosmani/agent-skills` | Gestisce rimozione, migrazione e sunset di API, sistemi o feature. |
| `diagnose` | `cap-aeris` locale | Diagnosi disciplinata: riproduzione, ipotesi, strumentazione, fix e regressione. |
| `documentation-and-adrs` | `addyosmani/agent-skills` | Registra decisioni, ADR e documentazione utile a futuri agenti e sviluppatori. |
| `grill-with-docs` | `cap-aeris` locale | Stress-test di piani contro documenti CAP, UI, wiki e decisioni note. |
| `improve-codebase-architecture` | `mattpocock/skills` | Individua attriti architetturali e opportunita di refactor profondo. |
| `performance-optimization` | `addyosmani/agent-skills` | Ottimizza performance quando esistono metriche, regressioni o bottleneck misurati. |
| `planning-and-task-breakdown` | `addyosmani/agent-skills` | Spezza specifiche e requisiti in task ordinati e verificabili. |
| `prototype` | `mattpocock/skills` | Usa prototipi throwaway per validare UI, stati o flussi prima di consolidare. |
| `security-and-hardening` | `addyosmani/agent-skills` | Rafforza codice che gestisce input, sessioni, dati e integrazioni esterne. |
| `source-driven-development` | `addyosmani/agent-skills` | Ancora le decisioni a documentazione autorevole e fonti ufficiali. |
| `systematic-debugging` | `obra/superpowers` | Debug strutturato prima di cambiare codice o proporre fix. |
| `tdd` | `cap-aeris` locale | Red-green-refactor con test orientati al comportamento e alle interfacce pubbliche. |
| `triage` | `mattpocock/skills` | Triage di issue CAP, bug e richieste feature prima che diventino lavoro eseguibile. |
| `update-docs` | `cap-aeris` locale | Aggiorna documentazione quando cambiano comportamenti, workflow, UI o assunzioni. |
| `verification-before-completion` | `obra/superpowers` | Impone verifiche concrete prima di dichiarare una modifica completata. |
| `write-tests` | `cap-aeris` locale | Guida aggiunta o aggiornamento test coerenti con dominio e documentazione CAP. |
| `writing-plans` | `obra/superpowers` | Produce piani multi-step prima dell'implementazione. |
| `zoom-out` | `mattpocock/skills` | Fornisce contesto alto livello su moduli, chiamanti e linguaggio di dominio. |

### Baialupo

| Skill | Repo sorgente | Descrizione breve |
| --- | --- | --- |
| `baia-publish` | `baialupo` locale | Pubblica articoli, eventi e aggiornamenti Baialupo seguendo workflow editoriale, fonti, immagini, eventi e passaggio di naturalezza. |

### Cantieri Protetti AI

| Skill | Repo sorgente | Descrizione breve |
| --- | --- | --- |
| `documentation-and-adrs` | `addyosmani/agent-skills` | Registra decisioni, ADR e documentazione quando cambiano dominio, payload, API, OCR, LLM o persistenza. |
| `grill-with-docs` | personale locale | Stress-test di decisioni contro `CONTEXT.md`, ADR e linguaggio di dominio. |
| `security-and-hardening` | `addyosmani/agent-skills` | Rafforza privacy, segreti, input file, API e gestione di contenuti documentali sensibili. |
| `source-driven-development` | `addyosmani/agent-skills` | Ancora implementazioni a fonti autorevoli e documentazione tecnica aggiornata. |
| `systematic-debugging` | `obra/superpowers` | Diagnosi strutturata per pipeline PDF, OCR, LLM, API e CLI. |
| `verification-before-completion` | `obra/superpowers` | Richiede evidenze di test, lint, comandi CLI e verifica payload prima di chiudere il lavoro. |

### Homelab

| Skill | Repo sorgente | Descrizione breve |
| --- | --- | --- |
| `grill-with-docs` | personale locale | Sfida piani GitOps, rete, backup e architettura contro documentazione e manifest reali. |
| `homelab-app-onboarding` | personale locale | Guida onboarding app con manifest, ArgoCD, SOPS, CNPG, HTTPRoute, Cloudflare, Homepage e backup. |
| `homelab-backup-restore` | personale locale | Guida backup, restore, CNPG, Barman Cloud Plugin, RGW, rclone e drill di recovery. |
| `homelab-ceph-storage-operations` | personale locale | Guida Ceph, Ceph CSI, RGW, RBD, PVC, bucket S3 e percorsi storage. |
| `homelab-cloudflare-operations` | personale locale | Guida DNS, Access, Zero Trust, tunnel cloudflared e raggiungibilita pubblica. |
| `homelab-gateway-routes` | personale locale | Guida HTTPRoute, Gateway API, Traefik, Cloudflare DNS/Access e tunnel ingress. |
| `homelab-gitops-operations` | personale locale | Guida modifiche GitOps, sync ArgoCD, Kustomize, dry-run e verifiche live. |
| `homelab-implementation-planning` | personale locale | Guida piani per migrazioni, rollout GitOps, rollback, verifiche e commit strategy. |
| `homelab-kubernetes-operations` | personale locale | Guida K3s, risorse Kubernetes, CRD, operatori, rollout, servizi, endpoint e log. |
| `homelab-network-readiness` | `affaan-m/everything-claude-code` | Checklist di readiness per rete homelab, DNS locale, firewall e accesso remoto. |
| `homelab-observability-operations` | personale locale | Guida Grafana, Loki, Prometheus, Alloy, dashboard, alerting, label e metriche. |
| `homelab-opentofu-terraform` | personale locale | Guida Terraform/OpenTofu per Cloudflare Zero Trust, DNS, Access, tunnel e state. |
| `homelab-proxmox-operations` | personale locale | Guida Proxmox, PBS, Ceph, VM/LXC, nodi, storage e backup infrastrutturali. |
| `homelab-review-and-debt` | personale locale | Guida review del repo per debito tecnico, rischio operativo, drift, sicurezza e nuove implementazioni. |
| `homelab-secret-management` | personale locale | Guida SOPS, Age, Reflector, rotazione token, credenziali DB e leak check. |
| `network-config-validation` | `affaan-m/everything-claude-code` | Review preventiva di configurazioni rete, indirizzi, subnet e rischi management-plane. |
| `security-review` | `affaan-m/everything-claude-code` | Checklist sicurezza per segreti, configurazioni, accessi e superfici esposte. |
| `systematic-debugging` | `obra/superpowers` | Debug strutturato per GitOps, Kubernetes, DNS, Cloudflare, monitoring e backup. |
| `verification-before-completion` | `obra/superpowers` | Verifica comandi, sync, manifest e stato cluster prima di dichiarare completata una modifica. |

### Obsidian

| Skill | Repo sorgente | Descrizione breve |
| --- | --- | --- |
| `organize-obsidian-wiki` | personale locale | Organizza note del vault in wiki personale senza modificare il vault reale senza conferma. |
| `verification-before-completion` | `obra/superpowers` | Controlla link, duplicati, output e confini read-only prima di chiudere un riordino. |

### PowerPoint

| Skill | Repo sorgente | Descrizione breve |
| --- | --- | --- |
| `grill-with-docs` | personale locale | Verifica storyline, assunzioni e contenuti contro documenti sorgente e riferimenti. |
| `powerpoint-deck-production` | personale locale | Produce o modifica deck PowerPoint editabili e source-grounded. |
| `pptx-quality-review` | personale locale | Revisiona deck per storyline, grounding, assunzioni, coerenza visiva e igiene deliverable. |

## Forma Di Una Skill

Ogni skill deve essere una directory con un file `SKILL.md` e frontmatter YAML
che includa almeno `name` e `description`.

```text
skill-name/
  SKILL.md
  agents/openai.yaml      # metadati UI opzionali
  scripts/                # helper deterministici opzionali
  references/             # contesto opzionale caricato solo quando serve
  assets/                 # template, immagini o asset binari opzionali
```

`SKILL.md` deve iniziare con frontmatter YAML contenente:

```yaml
---
name: skill-name
description: Quando Codex deve usare questa skill.
---
```

Mantieni la descrizione precisa. Codex usa `name` e `description` per decidere
quando attivare la skill.

## Validazione

```bash
scripts/validate-skills.sh
```

## Lista Skill Installate

Per elencare le skill realmente visibili a Codex, usa lo script dedicato:

```bash
scripts/list-installed.sh
```

Lo script usa `find -L`, quindi segue i symlink creati da `install-local.sh`.
Un semplice `find ~/.codex/skills -type d` non basta, perche molte skill sono
collegate come symlink dal repository.

## Installazione Locale

Installa ogni skill globale come symlink in `$CODEX_HOME/skills`, che di default
corrisponde a `~/.codex/skills`:

```bash
scripts/install-local.sh
```

Installa solo alcune skill globali:

```bash
scripts/install-local.sh playwright grill-with-docs
```

Le skill gia installate non vengono sovrascritte, a meno che siano gia symlink
che puntano a questo repository.

Per convertire directory gia installate in symlink gestiti dal repo:

```bash
scripts/install-local.sh --replace
```

`--replace` sposta le voci esistenti in percorsi `.backup-*` con timestamp prima
di creare il link.

Riavvia Codex dopo avere installato o modificato skill.

## Installazione Skill Di Progetto

Le skill di progetto sono salvate in `projects/<project-name>/` perche spesso
contengono assunzioni di dominio specifiche del progetto.

```bash
scripts/install-project.sh cap-aeris /home/iingenito/projects/personal/cap-aeris
```

Questo collega `projects/cap-aeris/*` in:

```text
/home/iingenito/projects/personal/cap-aeris/.agents/skills/
```

Lo script di installazione progetto rifiuta di sovrascrivere directory skill
esistenti che non siano symlink. Importa o sposta le skill di progetto esistenti
prima di collegarle.

Per convertire directory skill di progetto gia esistenti in symlink gestiti dal
repo:

```bash
scripts/install-project.sh --replace cap-aeris /home/iingenito/projects/personal/cap-aeris
```

## Modello Di Installazione

Gli script di installazione usano symlink. In questo modo il repository Git resta
la sorgente modificabile, mentre Codex vede le skill nei percorsi runtime attesi:

- percorso runtime globale: `$CODEX_HOME/skills/<skill-name>`
- percorso runtime progetto: `<project-root>/.agents/skills/<skill-name>`

Gli script rifiutano di sovrascrivere directory esistenti che non siano symlink.
Se una skill e gia installata come directory reale, importala o spostala prima di
collegarla. Con `--replace`, le voci esistenti vengono spostate in percorsi
`.backup-*` con timestamp e poi viene creato il symlink.

## Importazione Skill Locali Esistenti

Copia nel repo le skill personali attualmente installate in `$CODEX_HOME/skills`:

```bash
scripts/sync-from-codex.sh
```

Lo script salta le skill `.system` di default e non sovrascrive mai skill gia
presenti nel repo, salvo uso esplicito di `--force`.

```bash
scripts/sync-from-codex.sh --force
```

Le skill di progetto vanno importate manualmente in `projects/<project-name>/`,
cosi il confine del progetto resta esplicito.

## Aggiungere Una Nuova Skill

1. Decidi se la skill e globale o specifica di progetto.
2. Crea la cartella sotto `global/` oppure `projects/<project-name>/`.
3. Aggiungi `SKILL.md` con frontmatter `name` e `description`.
4. Metti riferimenti lunghi in `references/`, invece di appesantire `SKILL.md`.
5. Metti helper deterministici in `scripts/`.
6. Esegui `scripts/validate-skills.sh`.
7. Installa con `install-local.sh` oppure `install-project.sh`.
8. Riavvia Codex e verifica che la skill si attivi su un prompt realistico.

## Controlli Del Repository

Prima del commit:

```bash
scripts/validate-skills.sh
bash -n scripts/*.sh
git status --short
```

Controlla con attenzione le modifiche alle skill importate, perche il testo di
una skill cambia il comportamento dell'agente.

## Commit E Changelog

Questo repository usa Conventional Commits. I messaggi di commit devono essere in
inglese, anche quando la documentazione o la conversazione sono in italiano.

Esempi:

```text
feat: add a new project skill
fix: handle existing symlink during install
docs: update skill usage guide
chore: organize skills by scope
ci: generate changelog automatically
```

Quando Codex propone un messaggio di commit per questo repository, deve proporlo
sempre in inglese e in formato Conventional Commits.

Il changelog e generato automaticamente da GitHub Actions con `git-cliff` a ogni
push su `main` e quando la workflow `Changelog` viene avviata manualmente.
