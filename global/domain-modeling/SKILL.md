---
name: domain-modeling
description: Costruisce e affina il modello di dominio del progetto, chiarendo termini, relazioni, invarianti e decisioni difficili da invertire.
---

# Domain Modeling

Usa questa skill quando il linguaggio del dominio deve essere creato o corretto, non quando serve soltanto leggere la documentazione esistente.

## Fonti autorevoli

Prima di modificare il modello:

1. leggi `AGENTS.md` e le istruzioni attive del repository;
2. individua la fonte autorevole del glossario e degli ADR;
3. usa `docs/agents/domain.md` se esiste;
4. considera `CONTEXT.md` e `docs/adr/` solo come layout predefinito, non come obbligo.

Non creare un nuovo documento quando una fonte autorevole attiva può contenere l'informazione senza perdere chiarezza.

## Disciplina

- Contesta subito termini in conflitto con il glossario.
- Proponi un termine canonico per parole vaghe o sovraccariche.
- Verifica relazioni e invarianti con scenari concreti e casi limite.
- Confronta le affermazioni dell'utente con codice, configurazione e documentazione verificati.
- Distingui fatti, deduzioni e informazioni mancanti.
- Aggiorna il glossario quando un termine viene risolto; non accumulare decisioni da registrare più tardi.
- Mantieni il glossario privo di dettagli implementativi: deve descrivere linguaggio, concetti, relazioni e invarianti.

## ADR

Proponi un ADR soltanto quando la decisione è contemporaneamente:

1. costosa da invertire;
2. sorprendente senza contesto;
3. risultato di un vero compromesso tra alternative.

Un ADR deve indicare contesto, alternative considerate, decisione, motivazione e conseguenze. Se uno dei tre criteri manca, non creare l'ADR.

## Stop condition

Termina quando i termini necessari al task sono non ambigui, le contraddizioni rilevanti sono risolte e le fonti autorevoli interessate rappresentano lo stato corrente.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/domain-modeling/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.