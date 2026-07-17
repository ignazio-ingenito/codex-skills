---
name: improve-codebase-architecture
description: Individua opportunità concrete per rendere moduli più profondi, testabili e navigabili dagli agenti, quindi accompagna la scelta con un report visuale e grilling.
disable-model-invocation: true
---

# Improve Codebase Architecture

Individua attriti architetturali e proponi **deepening opportunities**: refactor che aumentano leverage e locality dietro interfacce più piccole.

Usa `codebase-design` come fonte del vocabolario: **module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, **locality**, deletion test e interfaccia come superficie di test.

Usa il linguaggio di dominio e gli ADR attivi del repository. `CONTEXT.md` e `docs/adr/` sono default, non assunzioni obbligatorie.

## 1. Definisci lo scope prima della scansione

- Se l'utente indica modulo, sottosistema o dolore specifico, limita lì l'esplorazione.
- Altrimenti usa cronologia recente e aree modificate frequentemente per individuare hot spot.
- Se non emergono hot spot, amplia gradualmente lo scope.

Non scandire indiscriminatamente l'intero repository: YAGNI vale anche per i refactor.

## 2. Esplora

Esplora direttamente con gli strumenti Codex disponibili. Quando sono presenti agenti indipendenti, puoi delegare porzioni autonome; il subagent non è obbligatorio.

Cerca:

- concetti che richiedono continui salti tra moduli;
- moduli shallow con interfacce quasi complesse quanto l'implementazione;
- funzioni estratte solo per testabilità mentre i bug vivono nell'orchestrazione;
- conoscenza o cambiamenti dispersi, con locality bassa;
- seam che perdono dettagli interni;
- comportamento difficile da osservare attraverso interfacce pubbliche.

Applica il deletion test a ogni candidato.

## 3. Presenta i candidati

Produci un report visuale nella posizione temporanea già prevista dall'ambiente. Se Codex non può aprire un file nel browser dell'utente, fornisci il path e una sintesi leggibile nel messaggio.

Per ogni candidato includi:

- file e moduli coinvolti;
- problema osservato ed evidenza;
- soluzione in linguaggio semplice;
- benefici in termini di leverage, locality e testabilità;
- visualizzazione prima/dopo quando aggiunge chiarezza;
- forza della raccomandazione: `Strong`, `Worth exploring`, `Speculative`.

Chiudi con una sola raccomandazione principale. Non progettare ancora le nuove interfacce.

Se una proposta contraddice un ADR, mostrala soltanto quando l'attrito verificato giustifica davvero riaprire la decisione.

## 4. Grilling sul candidato scelto

Dopo la scelta usa `grilling` per chiarire vincoli, dipendenze, forma del modulo, seam e test. Usa `domain-modeling` per aggiornare termini e ADR quando necessario.

Usa `codebase-design` per esplorare alternative di interfaccia. Se il parallelismo è disponibile puoi progettare alternative indipendenti; altrimenti fallo in sequenza.

## Stop condition

La skill termina con un candidato scelto e sufficientemente chiarito da entrare nel normale flusso di specifica o pianificazione. Non implementa automaticamente il refactor.

## Upstream

Aggiornata sulla base di `mattpocock/skills`, path `skills/engineering/improve-codebase-architecture/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.