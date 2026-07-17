---
name: wayfinder
description: Pianifica un'iniziativa troppo grande o nebbiosa per una singola sessione come mappa condivisa di decision ticket, risolti uno alla volta finché la strada è chiara.
disable-model-invocation: true
---

# Wayfinder

Usa Wayfinder quando la destinazione è importante ma il percorso non è ancora descrivibile in una singola sessione. La skill produce **decisioni**, non deliverable.

## Principi

- La mappa è l'artefatto canonico e funge da indice; ogni decisione vive in un solo ticket.
- Riferisci mappe e ticket per titolo, con link; non usare numeri nudi nel testo destinato all'utente.
- Non creare ticket per ciò che non è ancora formulabile con precisione: registralo in `Not yet specified`.
- Ciò che è oltre la destinazione va in `Out of scope`, non nella nebbia.
- Un ticket HITL richiede realmente la decisione dell'utente; l'agente non risponde al suo posto.
- Di norma risolvi un solo decision ticket per sessione. Ticket di ricerca indipendenti possono essere eseguiti in parallelo quando Codex dispone di agenti adatti; altrimenti sequenzialmente.

## Mappa

Usa il tracker configurato in `docs/agents/issue-tracker.md`. Se manca, esegui `setup-matt-pocock-skills`.

Corpo minimo:

```markdown
## Destination

## Notes

## Decisions so far

## Not yet specified

## Out of scope
```

La mappa deve puntare ai ticket senza duplicarne la risoluzione.

## Tipi di ticket

- **research**: fatto esterno necessario a una decisione; usa `research`.
- **prototype**: artefatto throwaway necessario per reagire a comportamento o forma.
- **grilling**: decisione HITL tramite `grilling` e, quando serve, `domain-modeling`.
- **task**: attività necessaria a sbloccare una decisione, non a consegnare la destinazione.

## Chart the map

1. Usa `grilling` e `domain-modeling` per fissare la destinazione.
2. Esplora il territorio in ampiezza e identifica decisioni già formulabili, dipendenze, nebbia e fuori scope.
3. Se tutto è già chiaro e contenibile in una sessione, fermati: Wayfinder non è necessario.
4. Crea la mappa sul tracker.
5. Crea i decision ticket formulabili e registra i blocker con relazioni native quando disponibili, altrimenti nel corpo.
6. Avvia o programma la ricerca indipendente; non risolvere manualmente gli altri ticket durante la sessione di charting.

## Work through the map

1. Carica la mappa a bassa risoluzione.
2. Scegli il primo ticket aperto, non bloccato e non già preso, salvo indicazione dell'utente.
3. Segna il claim con il meccanismo del tracker, se disponibile.
4. Risolvi il ticket usando le skill indicate nelle note.
5. Registra la risoluzione nel ticket, chiudilo e aggiungi alla mappa una sola riga con link e sintesi.
6. Crea nuovi ticket emersi, aggiorna dipendenze, fai avanzare la nebbia e rimuovi ciò che è diventato fuori scope.

## Stop condition

La mappa è completa quando non restano ticket aperti né informazioni in-scope ancora troppo vaghe, e il risultato può passare a `to-spec` o all'artefatto indicato nella destinazione.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/wayfinder/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.