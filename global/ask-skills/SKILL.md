---
name: ask-skills
description: Suggerisce la skill o il breve flusso più adatto tra le skill documentate in codex-skills, incluse globali e specifiche di progetto, privilegiando la capacità più specifica e il percorso minimo sufficiente.
disable-model-invocation: true
---

# Ask Skills

Non è necessario ricordare tutte le skill: descrivi la situazione e questa skill suggerirà la prossima mossa.

`ask-skills` è un **router consultivo**. Non esegue automaticamente un workflow completo e non mostra l'intero catalogo salvo richiesta esplicita.

## Fonti autorevoli

1. Leggi `AGENTS.md` e le istruzioni attive del repository corrente.
2. Usa l'inventario del `README.md` di `codex-skills` come catalogo autorevole delle skill globali e di progetto.
3. Nel progetto corrente, considera le skill installate sotto `.agents/skills` per applicare eventuali varianti specifiche già documentate.
4. Non introdurre scansioni generiche del filesystem, scoring automatici o inferenze da directory non documentate.

Quando README, installazione locale e repository corrente non concordano, segnala la discrepanza invece di inventare una precedenza.

## Regole di selezione

1. Individua l'intento principale della richiesta.
2. Preferisci una skill specifica del progetto corrente rispetto a una globale equivalente.
3. Scegli il percorso più corto che riduce l'incertezza o completa il task.
4. Preferisci una sola skill principale; proponi un flusso breve solo quando le fasi hanno responsabilità distinte.
5. Non raccomandare una skill i cui prerequisiti non sono disponibili.
6. Considera anche skill non ingegneristiche: contenuti, documenti, presentazioni, dati, publishing, homelab e altri domini presenti nell'inventario.
7. Se il task è piccolo, chiaro e non richiede una skill specifica, dichiaralo invece di inventare processo.
8. Se emerge una decisione di architettura, processo o prodotto non risolta, fermati e segnala la decisione richiesta.

## Output

Restituisci:

1. **Situazione rilevata** — fatti disponibili e informazioni mancanti rilevanti.
2. **Skill consigliata** — nome esatto della skill principale oppure un flusso breve.
3. **Perché** — motivo concreto e alternative vicine escluse.
4. **Risultato atteso** — artefatto, modifica o evidenza prodotta.
5. **Poi** — il successivo punto di innesto, solo se già prevedibile.
6. **Precedenza applicata** — quando una variante di progetto sostituisce una globale.

Indica “non usare ancora” soltanto quando evita un errore probabile.

## Main flow: idea → delivery

### Idea circoscritta ma ancora ambigua

- `brainstorming` per chiarire intento, requisiti e design prima di modificare comportamento.
- `idea-refine` per trasformare un'idea grezza in un concetto più chiaro e azionabile.
- `office-hours` per valutare focus, ambizione e trade-off di prodotto.
- `grill-with-docs` quando il piano va stressato contro dominio, codice e decisioni documentate.
- `grilling` per una decisione HITL mirata.
- `domain-modeling` quando termini, invarianti o confini di dominio sono ambigui.

### Domanda che richiede evidenza concreta

- `prototype` per logica, stato o UI throwaway.
- `research` per fatti esterni ricavati da fonti primarie.
- `source-driven-development` quando una variante di progetto richiede sviluppo ancorato a fonti tecniche autorevoli.
- `handoff` prima o dopo una deviazione che richiede una sessione separata.

### Lavoro multi-sessione ma già definibile

- `to-spec` per condensare decisioni in una specifica implementabile.
- `to-tickets` per dividerla in ticket verticali con blocker espliciti.
- `writing-plans` per un piano esecutivo multi-step quando proporzionato.

### Iniziativa enorme o nebbiosa

`wayfinder` → `to-spec` → `to-tickets` → delivery ticket per ticket.

Usa `wayfinder` solo quando la strada verso la destinazione non può essere contenuta in una sessione.

### Delivery di un ticket

Usa soltanto i passaggi necessari:

- `using-git-worktrees` quando serve isolamento;
- `tdd` per comportamento eseguibile;
- `senior-implementation-discipline` per contratti, dominio, persistenza, sicurezza o componenti condivisi;
- `code-review-and-quality` per review su spec/task e standard;
- `requesting-code-review` per preparare una review esterna;
- `receiving-code-review` per valutare feedback ricevuto;
- `verification-before-completion` prima di dichiarare concluso il lavoro.

Non cercare una skill `implement`: in questo repository il flusso è composto dalle skill esistenti.

## On-ramps operativi

### Bug o test rotto

- `systematic-debugging` globale;
- oppure `diagnose` specifica del progetto, quando presente;
- regression test e `tdd` quando applicabile;
- `verification-before-completion`.

### Issue o PR in ingresso

- `triage` per richieste non create dal flusso `to-tickets`.
- I ticket generati da `to-tickets` sono già pronti e non vanno sottoposti nuovamente a triage.

### Conflitti Git

- `resolving-merge-conflicts` quando merge o rebase è già in conflitto.

### Codebase health

- `improve-codebase-architecture` per opportunità di deepening.
- `codebase-design` per moduli, interfacce, seam e design-it-twice.
- `code-simplification` per semplificare codice funzionante preservando comportamento.
- `zoom-out` per ottenere una mappa ad alto livello.

## Domini non engineering

Usa l'inventario del README per individuare la skill specifica, ad esempio:

- `humanize-writing`, `caveman`, `interview-me` per scrittura e comunicazione;
- `baia-publish` per il workflow editoriale Baialupo;
- `organize-obsidian-wiki` per Obsidian;
- `powerpoint-deck-production` e `pptx-quality-review` per presentazioni;
- `read-vdo-hour-meter` per il flusso Kong;
- le skill `homelab-*` per operazioni homelab specifiche;
- le varianti CAP Aeris e di altri progetti quando il repository corrente le installa.

Non mantenere qui una seconda copia completa dell'inventario: il README resta la fonte autorevole e questa sezione descrive solo le famiglie principali.

## Catalogo su richiesta

Se l'utente chiede il catalogo completo:

1. leggi l'inventario del README;
2. raggruppa le skill per globali e progetto;
3. mostra nome, descrizione breve e ambito;
4. evidenzia duplicati intenzionali e precedenze progetto/globale;
5. segnala eventuali discrepanze osservate con le skill installate nel progetto corrente.

## Configurazione

Quando tracker, label di triage o fonti di dominio non sono configurati, usa `setup-matt-pocock-skills` prima dei flussi che ne dipendono.

## Provenienza

Adattata dal router consultivo `ask-matt` di `mattpocock/skills`, path `skills/engineering/ask-matt/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`. Rinominata `ask-skills` ed estesa al catalogo documentato di `codex-skills`, senza discovery dinamica o orchestrazione automatica.