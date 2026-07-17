---
name: research
description: Indaga una domanda usando fonti primarie ad alta affidabilità e registra i risultati in un singolo documento Markdown citato nel repository.
---

# Research

Usa questa skill quando una decisione dipende da fatti esterni al contesto corrente o richiede lettura sostanziale di documentazione, specifiche, API o codice sorgente.

## Processo

1. Formula una domanda precisa e il criterio che renderà la ricerca sufficiente.
2. Individua fonti primarie: documentazione ufficiale, specifiche, repository sorgente, paper originali e API first-party.
3. Segui ogni affermazione rilevante fino alla fonte che ne è responsabile.
4. Distingui chiaramente fatti verificati, deduzioni e informazioni non trovate.
5. Scrivi i risultati in un unico file Markdown, nella posizione già usata dal repository per note di ricerca. Se non esiste una convenzione, proponi il path più semplice e dichiaralo.
6. Cita la fonte accanto a ogni affermazione che influenza una decisione.

## Parallelismo

Quando Codex dispone di agenti indipendenti, la ricerca può essere delegata e svolta in parallelo al lavoro non dipendente. In assenza di tale capacità, eseguila nella sessione corrente o in una sessione separata. Il parallelismo non è un requisito della skill.

## Output minimo

```markdown
# <Question>

## Answer

## Verified facts

## Deductions

## Missing information

## Sources
```

Non sostituire la fase decisionale: la ricerca fornisce fatti a `grilling`, `domain-modeling`, `wayfinder` o alla skill che l'ha richiesta.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/research/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.