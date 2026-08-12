# Validazione `ui-depth-preview`

**Stato:** Active  
**Origine:** Issue #25 / PR #29  
**Ultimo aggiornamento:** Issue #31 / PR #32  
**Rischio:** Light

## Obiettivo

`ui-depth-preview` genera preview visuali del layering/depth di una UI esistente senza trasformare il lavoro in un redesign o in una implementazione temporanea.

## Contratto attuale

- Due varianti di default: **Balanced** e **Expressive**.
- **Balanced** usa soprattutto gerarchia delle surface, separazione tonale, bordi e shadow leggere.
- **Expressive** usa la stessa mappa semantica, ma può aggiungere material, blur, traslucenza, refraction sottile e cue lens-like.
- Gli effetti Expressive sono ammessi solo su superfici già floating, transient o parte del chrome applicativo.
- Niente glassmorphism diffuso, nuovi layer semantici o lens/material sulle normali content/document card e sul canvas.
- Layout, contenuti, palette principale, tipografia e identità della UI devono restare riconoscibili.
- La skill non implementa o prototipa l'app solo per ottenere una preview.

## Verifica visiva

Smoke test reale su due schermate Aeris, con 4 preview:

- Dashboard — Balanced
- Dashboard — Expressive
- Workflow — Balanced
- Workflow — Expressive

Esito: **PASS**.

Osservazioni:

- Balanced ed Expressive sono distinguibili a colpo d'occhio.
- Expressive usa i cue material/lens soprattutto su sidebar, topbar e superfici floating.
- Le card di contenuto restano sobrie.
- Layout, contenuti e identità Aeris sono preservati.
- Nessun redesign o imitazione macOS.

Nota non bloccante: il glow Expressive può essere ridotto leggermente in alcuni casi, ma non modifica l'esito della validazione.

## Verifica automatica

HEAD verificato prima della chiusura della Wave: `300005a9e5f808828de0ec48de21bf6c5c268729`.

GitHub Actions `Validate skills`, run **#14**: **success**.

Copertura rilevante:

- sintassi shell;
- `scripts/validate-skills.sh` su 104 skill;
- tutti i `scripts/test-*.sh`;
- test dedicato `ui-depth-preview`;
- quick validation;
- installazione della skill;
- guardrail che mantengono Balanced sobria e Expressive selettiva.

## Eval comportamentale

Il RED/GREEN originario resta documentato in `docs/reviews/ui-depth-preview-behavioral-eval.md`.

I failure mode che non devono ricomparire sono:

- implementazione temporanea solo per generare la preview;
- intake più ampio del necessario;
- tre varianti obbligatorie;
- audit completo del codice senza beneficio visivo;
- redesign frontend generale.

## Catalogo e installazione

`README.md` resta il catalogo autorevole e include `ui-depth-preview` tra le skill globali.

`scripts/install-local.sh` scopre già automaticamente le directory sotto `global/`; non serve alcun registry aggiuntivo.

## Fonti di design

Il modello usa principalmente Fluent 2 e normalizza principi generali di depth/layering. Atlassian Elevation e Carbon Layering restano riferimenti complementari.

## Esito

La skill soddisfa l'obiettivo con una soluzione minima: preview visuali confrontabili, due strategie realmente distinguibili e guardrail che evitano redesign e complessità non necessaria.
