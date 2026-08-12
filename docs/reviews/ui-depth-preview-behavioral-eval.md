# Eval comportamentale `ui-depth-preview`

**Issue:** #25  
**PR:** #29  
**Data:** 2026-08-12

## Metodo

Il repository non dispone di un harness/subagent per eval di skill. Il RED usa quindi **failure mode realmente osservati nella sessione di design precedente alla creazione della skill**, non un test artificiale basato sull'assenza del file. Il GREEN ripete gli stessi casi caricando esplicitamente le regole finali di `ui-depth-preview` e verificando il comportamento risultante.

Questo eval misura il comportamento decisionale della skill; `scripts/test-ui-depth-preview.sh` resta separato e copre soltanto il contratto strutturale.

## Scenario 1 — fedeltà massima senza implementazione temporanea

**Prompt di pressione**

> Voglio una preview il più fedele possibile di questa UI. Puoi usare anche il codice; fammi vedere il risultato prima di decidere se implementarlo.

### RED osservato senza skill

Durante il design iniziale l'agente propose una modalità **Implementation accurate** con pipeline `codice → patch → render → screenshot`, quindi una vera implementazione temporanea solo per ottenere la preview. Il maintainer la respinse perché l'effort era sproporzionato rispetto al valore decisionale dell'anteprima.

**Failure mode:** confondere maggiore fedeltà con maggiore implementazione.

### GREEN con `ui-depth-preview`

Comportamento verificato applicando la skill:

- seleziona **Fedele**;
- usa lo screenshot come fonte primaria;
- consulta codice solo se risolve un'ambiguità visibile (sticky/overlay/parent-child/token rilevante);
- non implementa né prototipa l'app per generare la preview;
- produce di default **Balanced + Expressive**;
- dichiara la confidence senza promettere pixel accuracy.

**Esito:** PASS.

## Scenario 2 — evitare intake e varianti inutili

**Prompt di pressione**

> Ti passo uno screenshot: fammi vedere come migliorerebbe il layering. Voglio capire velocemente se la direzione funziona.

### RED osservato senza skill

Nella fase iniziale l'agente propose:

- tre preview fisse (`Conservative`, `Balanced`, `Expressive`);
- una dipendenza/intervista più ampia per raccogliere input sulla fedeltà.

Il successivo audit effort→risultato mostrò che questi passaggi non garantivano una differenza osservabile proporzionata.

**Failure mode:** aumentare domande e output per completezza invece che per valore visibile.

### GREEN con `ui-depth-preview`

Comportamento verificato applicando la skill:

- se la richiesta implica chiaramente rapidità/direzione, usa **Indicativa** con lo screenshot disponibile; se il livello di fedeltà resta realmente ambiguo, pone una sola domanda `Indicativa | Fedele`;
- non richiede codice, viewport o token se non cambiano materialmente la preview;
- genera **due** varianti di default: `Balanced` e `Expressive`;
- aggiunge `Conservative` solo su richiesta o se costituisce una strategia realmente distinguibile.

**Esito:** PASS.

## Regressioni che questo eval deve impedire

- reintrodurre `Implementation accurate` o una patch applicativa come requisito di preview;
- rendere obbligatorio `interview-me` o un intake multi-domanda;
- tornare a tre varianti di default;
- ispezionare tutto il codice per aumentare nominalmente la confidence;
- trasformare la skill in redesign frontend generale.

## Limite dichiarato

Questo è un before/after comportamentale basato su failure mode osservati e replay manuale con la skill caricata. Non è un benchmark cross-model né un eval automatizzato di Codex: il repository non possiede oggi l'infrastruttura necessaria, e introdurla per questa singola skill sarebbe sproporzionato.
