---
name: reality-check
description: Use when a task, plan, decision, or interview is grounded in an existing repository, specification, RFC, ADR, issue, or other authoritative source and the agent must determine what is already decided before asking the user.
---

# Reality Check

## Scopo

Ridurre le domande e impedire l'introduzione di complessità non richiesta prima di `grilling`, `grill-with-docs`, design o pianificazione.

La scelta predefinita è la soluzione più semplice che soddisfa tutte le fonti autorevoli applicabili.

## Quando usarla

Usala quando esistono fonti autorevoli e devi:

- chiarire requisiti o decisioni;
- preparare un'intervista;
- valutare un piano o una proposta;
- distinguere ciò che è già deciso da ciò che richiede davvero una decisione umana.

Non usarla per sostituire ricerca, debugging, prototipi o validazioni eseguibili.

## Procedura

1. Identifica le fonti autorevoli applicabili e usa per impostazione predefinita solo quelle attive.
2. Classifica ogni elemento rilevante come:
   - **Fatto**: presente in una fonte autorevole o verificato nel repository;
   - **Deduzione**: derivazione logica certa da fatti espliciti;
   - **Informazione mancante**: necessaria per scegliere correttamente tra alternative rilevanti.
3. Elimina le domande già risolte da fatti o deduzioni certe.
4. Non inventare entità, stati, regole, documenti o comportamenti di prodotto.
5. Quando più soluzioni sono compatibili, raccomanda quella più semplice ed efficace.
6. Passa a `grilling` o `grill-with-docs` soltanto le decisioni realmente aperte.
7. Fai una sola domanda alla volta e mostra l'avanzamento come `n/N`.

## Regola sul contatore

- `N` è il numero iniziale delle decisioni aperte identificate.
- `N` può diminuire quando una risposta chiude più decisioni.
- `N` può aumentare soltanto se emerge una nuova informazione mancante rilevante; spiega esplicitamente perché non era rilevabile prima.
- Non usare un totale arbitrario o decorativo.

## Output minimo

```text
Reality Check

Fonti consultate:
- ...

Decisioni già determinate: N
Decisioni dedotte: N
Decisioni aperte: N

Domanda 1/N
...
```

Se non restano decisioni aperte, non avviare un'intervista: riporta l'esito e procedi con il flusso successivo appropriato.

## Guardrail

Prima di porre una domanda verifica:

1. La risposta è già presente in una fonte autorevole?
2. È deducibile con certezza da fatti disponibili?
3. La domanda è necessaria per il task corrente?
4. Sto introducendo una complessità che non risponde a un requisito identificabile?
5. Esiste una soluzione più semplice con risultato equivalente?

Se una domanda fallisce una di queste verifiche, non porla.
