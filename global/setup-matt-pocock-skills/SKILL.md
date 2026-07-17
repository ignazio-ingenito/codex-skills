---
name: setup-matt-pocock-skills
description: Configura una volta per repository il tracker, il vocabolario di triage e la posizione delle fonti di dominio usate dalle skill engineering portate da Matt Pocock.
disable-model-invocation: true
---

# Setup Matt Pocock Skills

Configura soltanto le convenzioni che le skill engineering devono conoscere. È una skill guidata dal dialogo, non uno script deterministico.

## 1. Esplora

Leggi senza assumere:

- remote Git e configurazione del repository;
- `AGENTS.md` e gli eventuali blocchi già dedicati alle skill;
- fonti autorevoli di dominio, glossari, ADR e mappe di contesto;
- `docs/agents/` e precedenti output di questa skill;
- convenzioni locali per issue e file temporanei;
- presenza della skill `triage`;
- segnali reali di monorepo.

## 2. Presenta i risultati

Riassumi ciò che esiste e ciò che manca. Chiedi una decisione alla volta, anticipando la risposta raccomandata.

### Tracker

Se il repository è su GitHub, raccomanda GitHub Issues. In alternativa supporta il tracker effettivamente usato dal progetto o file Markdown locali. Registra la scelta in `docs/agents/issue-tracker.md` con istruzioni operative concrete per leggere, creare, aggiornare, chiudere e collegare issue.

Non introdurre un adapter o un nuovo tracker.

### Triage

Esegui questa sezione solo se `triage` è installata. Raccomanda i ruoli predefiniti:

- `needs-triage`
- `needs-info`
- `ready-for-agent`
- `ready-for-human`
- `wontfix`

Se il progetto usa già label equivalenti, registra la mappatura in `docs/agents/triage-labels.md` invece di creare duplicati.

### Documentazione di dominio

Individua la fonte autorevole esistente. Usa un singolo contesto per impostazione predefinita; proponi più contesti solo davanti a un monorepo o a confini di dominio verificati. Registra posizione e regole di consumo in `docs/agents/domain.md`.

`CONTEXT.md` e `docs/adr/` sono valori predefiniti, non obblighi. Non creare documenti vuoti o duplicati.

## 3. Conferma

Prima di scrivere mostra:

- il blocco `## Agent skills` da inserire o aggiornare in `AGENTS.md`;
- i contenuti dei file sotto `docs/agents/`;
- quali file verranno creati o modificati.

Attendi la conferma dell'utente.

## 4. Scrivi

Aggiorna `AGENTS.md` in-place senza duplicare il blocco e senza sovrascrivere sezioni circostanti. Crea solo i file necessari.

Il blocco deve rimandare alle fonti autorevoli, non duplicarne il contenuto.

## 5. Verifica

Controlla che:

- ogni path registrato esista o sia esplicitamente previsto;
- le operazioni del tracker siano eseguibili con gli strumenti disponibili;
- le label non siano duplicate;
- la fonte di dominio sia unica;
- `AGENTS.md` rappresenti lo stato corrente.

Riporta gli esiti come `SÌ`, `NO` o `NON APPLICABILE`, con evidenza e azione correttiva per ogni `NO`.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/setup-matt-pocock-skills/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.