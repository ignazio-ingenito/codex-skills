# Validazione `ui-depth-preview`

**Stato:** Active  
**Issue:** #25  
**PR:** #29  
**Rischio:** Light

## Scope verificato

La Wave aggiunge una skill globale focalizzata esclusivamente su preview di layering/depth UI. Non introduce un renderer, un prototipo applicativo, un nuovo registry o un nuovo framework di test.

## RED → GREEN

Il test `scripts/test-ui-depth-preview.sh` è stato creato prima della skill.

**RED osservato:**

```text
ERROR ui-depth-preview: missing global/ui-depth-preview/SKILL.md
```

Dopo l'implementazione e il refactor finale del `SKILL.md`:

```text
ui-depth-preview checks passed
Validated 1 skill(s)
```

`bash -n scripts/test-ui-depth-preview.sh` termina con exit code 0. Il `SKILL.md` finale è di 441 parole, sotto il target di ~500 parole per una skill non pesante.

Il replay del validator usa la stessa logica di `scripts/validate-skills.sh` sulla nuova directory. Le skill preesistenti non sono modificate dalla Wave; la loro precedente validazione resta riusabile. Un'esecuzione completa del repository non aggiungerebbe evidenza causale sulla nuova skill e non viene simulata o dichiarata.

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

Sono stati esclusi perché non producono beneficio osservabile proporzionato:

- modalità `Implementation accurate`;
- intervista completa come dipendenza obbligatoria;
- implementazione temporanea dell'app;
- audit completo di component tree, `z-index` o token;
- tre preview obbligatorie;
- nuovo registry/config per le skill globali;
- nuovo workflow CI dedicato.

## Installazione e catalogo

`README.md` resta il catalogo autorevole e include `ui-depth-preview` tra le skill globali. `scripts/install-local.sh` scopre già automaticamente le directory sotto `global/`, quindi non serve modificare configurazioni o registri.

Verifica con `CODEX_HOME` temporaneo:

```text
Linked global/ui-depth-preview -> <temp>/skills/ui-depth-preview
Restart Codex to pick up new or changed skills.
```

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

## Diff e collateral

Il diff intenzionale è limitato a:

- `global/ui-depth-preview/`;
- `scripts/test-ui-depth-preview.sh`;
- `README.md`;
- questo documento di validazione.

`CHANGELOG.md` può comparire nel diff perché il workflow `Changelog` del repository aggiorna automaticamente il file sulle sincronizzazioni della PR; non è stato modificato manualmente dalla Wave.

## Esito RFC-0001

| Verifica | Esito | Evidenza |
|---|---|---|
| Requisiti soddisfatti con soluzione minima? | SÌ | Una skill, due reference, un test deterministico; nessun runtime aggiuntivo. |
| Ogni passaggio produce risultato osservabile? | SÌ | Routing, preview variants, confidence, layering rules e installabilità sono verificabili. |
| Complessità evitabile rimossa? | SÌ | Eliminati implementation-accurate, full interview, prototipi temporanei e terza preview obbligatoria. |
| Duplicazione con `prototype`? | NO | `prototype` costruisce codice throwaway; `ui-depth-preview` evita esplicitamente quell'approccio. |
| Configurazione globale coerente? | SÌ | L'installer esistente auto-discovera `global/`; README aggiornato. |
