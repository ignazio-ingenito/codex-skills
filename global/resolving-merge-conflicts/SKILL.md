---
name: resolving-merge-conflicts
description: Risolve conflitti Git durante merge o rebase ricostruendo l'intento di entrambe le modifiche e verificando il risultato con i controlli del repository.
---

# Resolving Merge Conflicts

Usa questa skill quando un merge o rebase è già in corso e presenta conflitti.

## Processo

1. **Osserva lo stato reale**
   - identifica merge o rebase in corso;
   - leggi history, branch coinvolti e file in conflitto;
   - non modificare file non coinvolti senza una ragione verificabile.

2. **Ricostruisci l'intento**
   - leggi commit, PR, issue, specifiche e ADR che hanno originato entrambi i lati;
   - distingui fatti verificati, deduzioni e informazioni mancanti;
   - individua il risultato che il merge deve ottenere.

3. **Risolvi per intento, hunk per hunk**
   - preserva entrambi gli intenti quando compatibili;
   - quando sono incompatibili, scegli quello coerente con l'obiettivo dichiarato del merge e registra il compromesso;
   - non inventare nuovo comportamento per “migliorare” il codice durante la risoluzione;
   - non usare `--ours` o `--theirs` indiscriminatamente.

4. **Verifica**
   - assicurati che non restino marker di conflitto;
   - esegui i controlli previsti dal repository, tipicamente validazione statica, typecheck, test e formattazione;
   - usa test mirati sui comportamenti toccati e amplia la verifica in base al rischio;
   - correggi soltanto regressioni causate dalla risoluzione.

5. **Concludi**
   - stage dei file risolti;
   - continua merge o rebase fino al completamento;
   - riporta conflitti risolti, decisioni prese, verifiche ed eventuali rischi residui.

## Stop e sicurezza

Non abortire automaticamente il merge o rebase. Fermati e coinvolgi l'utente solo quando:

- gli intenti sono realmente incompatibili e nessuna fonte autorevole stabilisce la precedenza;
- la scelta modifica comportamento, contratto, dati, sicurezza o architettura;
- mancano informazioni indispensabili per una risoluzione corretta.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/resolving-merge-conflicts/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.