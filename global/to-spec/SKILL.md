---
name: to-spec
description: Trasforma la conversazione corrente o una mappa Wayfinder risolta in una specifica implementabile e la pubblica nel tracker configurato, senza riaprire l'intervista.
disable-model-invocation: true
---

# To Spec

Sintetizza ciò che è già stato deciso. Non interrogare nuovamente l'utente, salvo una sola conferma quando la scelta della superficie di test introduce una decisione non ancora risolta.

## Processo

1. Leggi il contesto corrente, la mappa Wayfinder o gli artefatti indicati.
2. Esplora il repository quanto basta per verificare stato, glossario, ADR e vincoli attivi.
3. Individua la superficie più alta e stabile attraverso cui il comportamento sarà verificato. Preferisci seam esistenti; non introdurne uno nuovo senza necessità concreta.
4. Se il seam non era già deciso, presentalo all'utente per conferma.
5. Pubblica la specifica nel tracker configurato da `setup-matt-pocock-skills`.
6. Applica lo stato o la label che nel repository significa pronta per il lavoro; non inventare nuove label.

## Struttura della specifica

```markdown
## Problem Statement

## Solution

## User Stories

## Implementation Decisions

## Testing Decisions

## Out of Scope

## Further Notes
```

### Regole

- Descrivi problema e soluzione dal punto di vista dell'utente.
- Le user story devono coprire i comportamenti e gli attori realmente in scope, senza gonfiare artificialmente l'elenco.
- Registra moduli, interfacce, contratti, schema, sicurezza e decisioni operative già assunte.
- Non inserire file path o codice destinati a invecchiare rapidamente.
- Puoi includere un frammento prodotto da un prototipo solo quando esprime una decisione meglio della prosa.
- I test devono osservare comportamento esterno attraverso l'interfaccia scelta, non dettagli implementativi.
- Distingui fatti verificati, decisioni assunte e informazioni ancora mancanti.

## Stop condition

La specifica è pronta quando un agente può derivarne ticket verificabili senza dover reinterpretare le decisioni rilevanti.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/to-spec/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.