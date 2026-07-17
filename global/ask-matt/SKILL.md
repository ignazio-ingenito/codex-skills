---
name: ask-matt
description: Indica quale skill o breve flusso di codex-skills è adatto alla situazione corrente, privilegiando la capacità più specifica e il percorso minimo sufficiente.
disable-model-invocation: true
---

# Ask Matt

Non è necessario ricordare tutte le skill: descrivi la situazione e questa skill suggerirà la prossima mossa.

`ask-matt` è un **router consultivo**. Non esegue automaticamente un workflow completo e non mostra il catalogo intero salvo richiesta esplicita.

## Regole di selezione

1. Leggi `AGENTS.md` e le istruzioni attive del repository.
2. Preferisci una skill specifica del progetto corrente rispetto a una globale equivalente.
3. Scegli il percorso più corto che riduce l'incertezza o completa il task.
4. Non raccomandare una skill i cui prerequisiti non sono disponibili.
5. Se il task è piccolo, chiaro e non richiede una skill specifica, dichiaralo invece di inventare processo.

## Output

Restituisci:

1. **Situazione rilevata** — fatti disponibili e informazioni mancanti rilevanti.
2. **Prossima skill** — una skill principale oppure un flusso breve.
3. **Perché** — motivo proporzionato e alternative escluse.
4. **Risultato atteso** — artefatto o evidenza prodotta.
5. **Poi** — il successivo punto di innesto, se già prevedibile.

Indica “non usare ancora” soltanto quando evita un errore probabile.

## Main flow: idea → delivery

### Idea circoscritta ma ancora ambigua

- `brainstorming` quando occorre definire o approvare il design prima di implementare.
- `grill-with-docs` quando la richiesta va stressata contro linguaggio di dominio, codice e decisioni documentate.
- `grilling` per una decisione HITL mirata; `domain-modeling` quando sono i termini o gli invarianti a essere ambigui.

### Domanda che richiede evidenza concreta

- `prototype` per logica, stato o UI throwaway.
- `research` per fatti esterni ricavati da fonti primarie.
- `handoff` prima e dopo una deviazione che richiede una sessione separata.

### Lavoro multi-sessione ma già definibile

- `to-spec` per condensare decisioni in una specifica.
- `to-tickets` per dividerla in tracer-bullet ticket con blocker espliciti.

### Delivery di un ticket

Usa soltanto i passaggi proporzionati:

- `writing-plans` per lavoro multi-step;
- `using-git-worktrees` quando serve isolamento;
- `tdd` per comportamento eseguibile;
- `senior-implementation-discipline` per contratti, dominio, persistenza, sicurezza o componenti condivisi;
- `code-review-and-quality` per conformità a spec e standard;
- `requesting-code-review` per preparare una review esterna;
- `verification-before-completion` prima di dichiarare concluso il lavoro.

Non cercare una skill `implement`: in questo repository il flusso è composto dalle skill esistenti.

## On-ramps

### Iniziativa enorme o nebbiosa

`wayfinder` → `to-spec` → `to-tickets` → delivery ticket per ticket.

Usa Wayfinder solo quando la strada verso la destinazione non può essere contenuta in una sessione. Non usarla per una feature già ben delimitata.

### Bug o test rotto

- `systematic-debugging` globale;
- oppure `diagnose` specifica del progetto, quando presente;
- regression test e `tdd` quando applicabile;
- `verification-before-completion`.

### Issue o PR in ingresso

- `triage` per richieste non create dal flusso `to-tickets`.
- I ticket generati da `to-tickets` sono già pronti: non sottoporli nuovamente a triage.

### Conflitti Git

- `resolving-merge-conflicts` quando merge o rebase è già in conflitto.

## Review

- `code-review-and-quality`: esegue la review reale del diff su spec/task e standard di qualità.
- `requesting-code-review`: prepara e richiede la review.
- `receiving-code-review`: valuta e applica feedback ricevuto con rigore tecnico.
- `verification-before-completion`: richiede evidenze prima della chiusura.

## Codebase health

- `improve-codebase-architecture`: individua opportunità di deepening.
- `codebase-design`: vocabolario e disciplina per moduli, interfacce e seam.
- `code-simplification`: semplifica codice funzionante preservando il comportamento.
- `zoom-out`: fornisce una mappa ad alto livello quando il codice non è comprensibile localmente.

## Continuità

Usa `handoff` quando una sessione deve terminare, deviare o trasferire il contesto a una nuova sessione Codex. L'handoff rimanda agli artefatti autorevoli e non li duplica.

## Skill di progetto

Prima di scegliere una globale, controlla le skill installate sotto `.agents/skills` e le varianti in `projects/<project-name>/`. Una variante di progetto prevale quando contiene fonti, comandi o vincoli locali più specifici.

## Precondizione

Quando tracker, label di triage o fonti di dominio non sono configurati, usa `setup-matt-pocock-skills` prima dei flussi che ne dipendono.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/ask-matt/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.