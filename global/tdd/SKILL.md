---
name: tdd
description: Guida test-driven development per feature e bug mediante cicli red-green su vertical slice osservabili attraverso interfacce pubbliche.
---

# Test-Driven Development

TDD è un ciclo **red → green**, applicato una vertical slice alla volta. Usa questa skill quando il lavoro introduce o corregge comportamento eseguibile e dispone di un feedback loop affidabile.

## Fonti e linguaggio

Prima di scrivere test:

- leggi `AGENTS.md` e le istruzioni attive;
- usa il glossario di dominio e gli ADR applicabili;
- individua i test analoghi già presenti;
- usa una variante di progetto più specifica quando esiste.

## Buon test

Un buon test:

- osserva comportamento attraverso un'interfaccia pubblica;
- legge come una specifica del comportamento;
- sopravvive ai refactor interni;
- deriva l'atteso da una fonte indipendente: requisito, esempio verificato o valore noto;
- fallisce per il motivo giusto prima dell'implementazione.

Evita:

- test di metodi privati o collaboratori interni;
- mock che replicano l'implementazione;
- asserzioni tautologiche;
- snapshot privi di intenzione;
- scrittura preventiva di tutti i test prima di ogni implementazione.

## Seam

Il seam è il confine pubblico attraverso cui il comportamento viene osservato. Usa il seam più alto e stabile già concordato nella specifica o nel ticket.

Se il seam non è definito e la scelta influenza architettura o contratto, fermati e chiedi conferma. Non introdurre un'astrazione soltanto per rendere semplice un test.

## Ciclo

Per ogni slice:

1. **Red** — scrivi un solo test che descrive il prossimo comportamento; eseguilo e verifica che fallisca per l'assenza di quel comportamento.
2. **Green** — implementa il minimo necessario a far passare quel test senza anticipare slice future.
3. **Verify** — esegui il test mirato e i controlli proporzionati per intercettare regressioni.
4. Ripeti con la slice successiva.

Il refactor strutturale ampio appartiene alla review o a un ticket esplicito, non va nascosto dentro il ciclo red-green.

## Non applicabilità

TDD può essere `NON APPLICABILE` per:

- sole modifiche Markdown;
- inventari o metadati senza comportamento eseguibile;
- configurazioni verificabili soltanto con validazione statica;
- attività esplorative o prototipi throwaway.

In questi casi usa la verifica più semplice che produca evidenza reale.

## Completamento

Prima di dichiarare concluso il lavoro:

- tutti i test nuovi passano;
- i controlli pertinenti del repository passano;
- il test osserva il comportamento concordato, non l'implementazione;
- usa `code-review-and-quality` per Standards + Spec;
- usa `verification-before-completion`.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/tdd/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.