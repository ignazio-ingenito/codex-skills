# Validazione `ui-depth-preview`

**Stato:** Active — attesa evidenza CI fresca  
**Issue:** #25  
**PR:** #29  
**Rischio:** Light

## Scope verificato

La Wave aggiunge una skill globale focalizzata esclusivamente su preview di layering/depth UI. Non introduce un renderer o un prototipo applicativo. Dopo la review è stato aggiunto un workflow CI generale e senza segreti che espone come status GitHub le validazioni già presenti nel repository.

## TDD documentale: RED → GREEN

Il RED comportamentale non è l'assenza di `SKILL.md`. I failure mode reali sono quelli osservati nella sessione di design precedente alla creazione della skill:

- proposta di una modalità **Implementation accurate** con patch/render dell'app solo per ottenere la preview;
- tre varianti fisse anche quando non producevano tre strategie distinguibili;
- intake/intervista più ampia del necessario.

Questi comportamenti sono stati respinti perché aumentavano effort senza un miglioramento osservabile proporzionato.

Il replay GREEN applica `ui-depth-preview` agli stessi casi e verifica invece:

- `Fedele` senza implementazione temporanea;
- screenshot come fonte primaria e codice solo per ambiguità visive materiali;
- `Balanced + Expressive` come default;
- una sola domanda `Indicativa | Fedele` quando la fedeltà è realmente ambigua;
- `Conservative` solo se richiesta o distinguibile.

Evidenza completa: `docs/reviews/ui-depth-preview-behavioral-eval.md`.

## Guardrail deterministico

`scripts/test-ui-depth-preview.sh` non viene più presentato come RED comportamentale. Verifica soltanto che il contratto documentale continui a contenere i guardrail richiesti: routing di fedeltà, due varianti di default, terza variante condizionale, confidence e divieto di implementazione/prototipazione solo per la preview.

## Evidenza eseguibile

`.github/workflows/validate-skills.yml` esegue sulle PR interessate:

```text
bash -n scripts/*.sh
bash scripts/validate-skills.sh
bash scripts/test-*.sh
CODEX_HOME=<temp> bash scripts/install-local.sh ui-depth-preview
```

L'ultimo step verifica anche che il symlink installato punti alla directory `global/ui-depth-preview` del checkout. La Wave non deve essere dichiarata completata finché il check sull'HEAD corrente non termina con successo.

## Scenari verificati

| Scenario | Comportamento atteso | Esito |
|---|---|---|
| Screenshot, preview rapida | Usa modalità **Indicativa**, evita domande/codice non necessari, produce Balanced + Expressive. | SÌ |
| Screenshot completo, fedeltà alta | Usa **Fedele**, preserva composizione/contenuti e modifica principalmente layering/depth. | SÌ |
| Fedele con ambiguità sticky/overlay | Consulta solo il codice necessario a risolvere l'ambiguità visibile. | SÌ |
| Manca screenshot e l'app richiederebbe lavoro dedicato | Chiede lo screenshot; non implementa né prototipa l'app per creare la preview. | SÌ |
| Terza variante non richiesta e non distinta | Produce solo Balanced + Expressive. | SÌ |
| Runtime senza generazione immagini | Dichiara il limite e restituisce il piano; non maschera una mini-implementazione come preview. | SÌ |

## Effort → risultato

Sono esclusi perché non producono beneficio osservabile proporzionato:

- modalità `Implementation accurate`;
- intervista completa come dipendenza obbligatoria;
- implementazione temporanea dell'app;
- audit completo di component tree, `z-index` o token;
- tre preview obbligatorie;
- nuovo registry/config per le skill globali.

Il workflow di validazione è l'unica aggiunta infrastrutturale successiva alla review: riusa script esistenti, non richiede segreti e produce l'evidenza fresca che mancava alla PR.

## Installazione e catalogo

`README.md` resta il catalogo autorevole e include `ui-depth-preview` tra le skill globali. `scripts/install-local.sh` scopre già automaticamente le directory sotto `global/`, quindi non serve modificare configurazioni o registri.

`config/global-skill-prune.txt` è una lista di elementi da rimuovere, non un registry: è intenzionalmente invariato.

## Modello di layering

Il riferimento operativo usa Fluent 2 come fonte principale e normalizza solo principi osservabili:

- quattro ruoli minimi: Base, Surface, Raised, Overlay;
- surface/tonal separation prima della shadow;
- shadow + light per vera distanza percepita;
- `z-index` distinto dalla depth semantica;
- nesting contenuto;
- materiale/blur solo quando comunica sovrapposizione o transienza.

Fonti primarie:

- Fluent 2 Elevation: https://fluent2.microsoft.design/elevation
- Fluent 2 Material: https://fluent2.microsoft.design/material
- Fluent 2 Design: https://fluent2.microsoft.design/get-started/design
- Atlassian Elevation: https://atlassian.design/foundations/elevation/
- Carbon Color/Layering: https://carbondesignsystem.com/elements/color/overview/
- OpenAI Codex multimodal input: https://help.openai.com/en/articles/11096431
- OpenAI Codex app image generation: https://openai.com/index/introducing-the-codex-app/

## Diff intenzionale

- `global/ui-depth-preview/`;
- `scripts/test-ui-depth-preview.sh`;
- `.github/workflows/validate-skills.yml`;
- `README.md` solo per l'inventario;
- `docs/reviews/ui-depth-preview-validation.md`;
- `docs/reviews/ui-depth-preview-behavioral-eval.md`.

`CHANGELOG.md` può comparire nel diff perché il workflow `Changelog` del repository aggiorna automaticamente il file sulle sincronizzazioni della PR; non è modificato manualmente dalla Wave.

## Esito RFC-0001

| Verifica | Esito | Evidenza |
|---|---|---|
| Requisiti soddisfatti con soluzione minima? | SÌ | Una skill, due reference, un test deterministico e un check CI che riusa gli script esistenti. |
| Ogni passaggio produce risultato osservabile? | SÌ | Routing, preview variants, confidence, eval comportamentale e status CI sono osservabili. |
| Complessità evitabile rimossa? | SÌ | Eliminati implementation-accurate, full interview, prototipi temporanei e terza preview obbligatoria. |
| Duplicazione con `prototype`? | NO | `prototype` costruisce codice throwaway; `ui-depth-preview` evita esplicitamente quell'approccio. |
| Configurazione globale coerente? | SÌ | L'installer esistente auto-discovera `global/`; README aggiornato. |
