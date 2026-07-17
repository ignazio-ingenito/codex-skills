---
name: to-tickets
description: Divide una specifica, un piano o la conversazione corrente in ticket tracer-bullet verticali con dipendenze esplicite, pubblicati nel tracker configurato.
disable-model-invocation: true
---

# To Tickets

Trasforma lavoro già definito in ticket eseguibili. Non usare questa skill per risolvere decisioni ancora aperte: torna a `grilling`, `domain-modeling` o `wayfinder`.

## Processo

1. Leggi integralmente la specifica, issue o artefatto indicato, inclusi commenti rilevanti.
2. Esplora il repository quanto basta per usare il linguaggio di dominio, rispettare ADR e riconoscere seam e precedenti utili.
3. Individua eventuale prefactoring strettamente necessario: rendi semplice la modifica, poi esegui la modifica semplice.
4. Progetta tracer-bullet ticket verticali.
5. Presenta all'utente titoli, risultato consegnato e blocker; chiedi approvazione della granularità e delle dipendenze.
6. Pubblica i ticket approvati nel tracker configurato, in ordine di dipendenza.

## Regole per i ticket

- Ogni ticket attraversa gli strati necessari e produce un comportamento o risultato verificabile completo.
- Deve essere eseguibile in una sessione fresca.
- Evita ticket orizzontali del tipo “database”, “backend”, “frontend”, “test”.
- Registra soltanto blocker reali.
- Usa relazioni native del tracker quando disponibili; altrimenti inserisci una sezione `Blocked by`.
- Applica la label o lo stato locale equivalente a `ready-for-agent`; non inventare label.
- Non chiudere o alterare l'artefatto padre.
- Non inserire file path o codice destinati a invecchiare, salvo frammenti di prototipo che codificano una decisione.

## Wide refactor

Un cambiamento meccanico con blast radius ampio può usare expand–migrate–contract invece delle normali vertical slice:

1. aggiungi la nuova forma mantenendo la vecchia;
2. migra i chiamanti in batch che mantengano verde la verifica;
3. rimuovi la vecchia forma soltanto quando non ha più consumatori.

Se nessun batch può restare verde da solo, usa un branch di integrazione e un ticket finale di verifica esplicito.

## Template

```markdown
## Parent

## What to build

## Acceptance criteria

- [ ] ...

## Blocked by

- None — can start immediately
```

## Handoff alla delivery

Dopo la pubblicazione lavora il frontier ticket per ticket usando il percorso minimo applicabile: `writing-plans`, `using-git-worktrees`, `tdd`, skill di disciplina specifiche e `verification-before-completion`. Non dipendere da una skill `implement` separata.

## Upstream

Adattata da `mattpocock/skills`, path `skills/engineering/to-tickets/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`.