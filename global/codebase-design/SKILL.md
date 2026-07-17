---
name: codebase-design
description: Vocabolario condiviso per progettare moduli profondi, interfacce piccole, seam puliti e codice testabile e navigabile dagli agenti.
---

# Codebase Design

Progetta **moduli profondi**: molto comportamento dietro un'interfaccia piccola, collocata in un seam pulito e verificabile attraverso la stessa interfaccia usata dai chiamanti.

## Vocabolario

- **Modulo**: qualunque elemento con un'interfaccia e un'implementazione.
- **Interfaccia**: tutto ciò che un chiamante deve conoscere per usare correttamente il modulo, inclusi invarianti, errori, configurazione e caratteristiche operative.
- **Implementazione**: ciò che vive dentro il modulo.
- **Profondità**: quantità di comportamento ottenuta per unità di interfaccia da comprendere.
- **Seam**: punto in cui il comportamento può essere sostituito senza modificare il chiamante.
- **Adapter**: implementazione concreta che occupa un seam e soddisfa l'interfaccia.
- **Leverage**: capacità riusata da molti chiamanti attraverso una sola interfaccia.
- **Locality**: concentrazione di conoscenza, cambiamenti e verifica in un solo luogo.

## Principi

- La profondità è una proprietà dell'interfaccia, non del numero di righe dell'implementazione.
- Usa il deletion test: se eliminando il modulo la complessità riappare nei chiamanti, il modulo sta producendo valore.
- L'interfaccia è la superficie primaria di test.
- Non introdurre un seam ipotetico: una sola implementazione non giustifica automaticamente un'astrazione; due adapter reali rendono il seam concreto.
- Accetta le dipendenze invece di crearle internamente quando questo migliora testabilità e sostituibilità.
- Preferisci risultati osservabili a side effect nascosti.
- Riduci metodi, parametri e conoscenze richieste ai chiamanti.

## Verifica del design

Per ogni modulo proposto verifica:

1. quale problema o requisito affronta;
2. quale complessità nasconde;
3. se esiste un'interfaccia più piccola equivalente;
4. dove vive il seam e perché è reale;
5. come viene testato attraverso l'interfaccia;
6. quale leverage e locality produce.

Se la proposta aggiunge solo pass-through o un layer senza beneficio verificabile, scartala.

Quando sono utili alternative radicalmente diverse, progettale in sequenza o in parallelo se Codex dispone di agenti indipendenti; il parallelismo non è un requisito.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/codebase-design/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.