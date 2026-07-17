---
name: handoff
description: Compatta la sessione corrente in un documento di handoff sufficiente a una nuova sessione Codex per continuare senza duplicare gli artefatti autorevoli.
argument-hint: "Scopo della prossima sessione"
disable-model-invocation: true
---

# Handoff

Crea un documento per una nuova sessione Codex quando il contesto deve essere trasferito, separato o alleggerito.

## Posizione

Salva il file nella posizione temporanea o di handoff già prevista dal repository. Se non esiste una convenzione, proponi un path sotto una directory non autorevole e ignorata da Git, oppure chiedi dove collocarlo quando il file deve essere condiviso.

Non trasformare l'handoff in una nuova fonte autorevole.

## Contenuto

Includi soltanto ciò che serve per riprendere:

- obiettivo della prossima sessione;
- stato corrente e ultimo punto verificato;
- decisioni non ancora registrate altrove;
- riferimenti a issue, specifiche, piani, ADR, branch, commit e diff;
- file modificati o rilevanti;
- verifiche eseguite e loro esito;
- blocchi e informazioni mancanti;
- prossimo passo concreto;
- sezione `Suggested skills` con le skill da usare e il motivo.

Non duplicare contenuti già presenti in artefatti autorevoli: linkali o cita il path.

## Sicurezza

Rimuovi segreti, token, password, credenziali, dati personali non necessari e contenuti sensibili. Se un'informazione è necessaria ma non può essere riportata, indica dove recuperarla in modo sicuro.

Se l'utente specifica lo scopo della prossima sessione, adatta priorità e dettagli a quello scopo.

## Verifica

Prima di consegnare controlla che una sessione fresca possa rispondere a:

1. cosa deve fare;
2. quali fonti sono autorevoli;
3. cosa è già stato deciso;
4. cosa è stato verificato;
5. quale azione viene dopo.

## Upstream

Adattata da `mattpocock/skills`, path `skills/productivity/handoff/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.