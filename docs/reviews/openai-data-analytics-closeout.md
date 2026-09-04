# Closeout OpenAI Data Analytics

**Stato:** Archived  
**Archiviato:** 2026-09-04 — evidenza di closeout della PR #48; README, `global/ask-skills/SKILL.md` e `config/global-skill-upstreams.tsv` restano le fonti operative correnti.  
**PR:** #48  
**Missione:** rendere disponibili le skill OpenAI Data Analytics come upstream diretti e instradarle tramite `ask-skills` senza vendorizzazione o nuovi meccanismi di runtime.

## Fonti autorevoli riesaminate

- RFC-0001 attiva, versione 0.1.9.
- `AGENTS.md` per lifecycle, upstream diretti e closeout terminale.
- `config/global-skill-upstreams.tsv` per repository, commit e path delle skill upstream.
- `README.md` per inventario pubblico e installazione.
- `global/ask-skills/SKILL.md` per routing generale.
- `openai/role-specific-plugins@fe5608d2512a7d6a7b9821ce8a88c48464ecd6e4` per il contenuto operativo delle skill Data Analytics.

## Decisioni durevoli

- Le 16 skill operative Data Analytics sono consumate direttamente dall'upstream OpenAI al commit pinned; non esistono copie locali.
- Il router upstream `index` non viene installato: `ask-skills` resta il router canonico del repository e contiene il routing Data Analytics necessario a scegliere la skill specialistica.
- Il routing privilegia la skill più specifica e il percorso minimo sufficiente; la suite non viene caricata integralmente per richieste circoscritte.
- `create-data-context` viene consigliata solo per richieste esplicite di persistenza o semantic layer.
- Le skill di conversione `report-to-google-doc`, `report-to-google-slides` e `report-to-pdf` restano narrow conversion skill e vengono consigliate solo quando esiste già l'artefatto analitico richiesto dalla relativa skill.

## Matrice RFC-0001

| Verifica | Esito | Evidenza o motivazione |
|---|---|---|
| La soluzione soddisfa i requisiti applicabili? | SÌ | Manifest upstream, inventario README e routing `ask-skills` coprono disponibilità, discovery e uso delle skill Data Analytics. |
| Esiste un modo più semplice per ottenere lo stesso risultato? | SÌ | È stato riusato il meccanismo upstream già introdotto per `unslop`/`caveman`; nessun installer, wrapper o runtime nuovo. |
| Ogni complessità introdotta ha giustificazione verificabile? | SÌ | La sola nuova logica è il routing documentale in `ask-skills`, necessario perché il router upstream `index` non è installato. |
| Nuovi controlli aggiuntivi o custom richiedono prova di necessità? | NON APPLICABILE | Non sono stati introdotti controlli, workflow, identity, permission, ledger, wrapper o runner nuovi. |
| La proporzionalità è stata valutata sull'intera soluzione? | SÌ | L'integrazione riusa manifest, installer e validator esistenti; non amplia la superficie dei controlli. |
| È richiesto un riesame cumulativo dei controlli? | NON APPLICABILE | La modifica non amplia materialmente i controlli collegati alla missione. |
| Il lavoro fa avanzare una missione identificata? | SÌ | La missione è integrare Data Analytics e renderne effettiva la discovery tramite il router canonico. |
| Sono stati aperti fronti laterali rinviabili? | NO | Nessuna issue, automazione o refactor laterale aggiunto. |
| La fattibilità è verificata? | SÌ | Il manifest usa il formato upstream già supportato; i path puntano a `SKILL.md` presenti al commit OpenAI pinned. |
| I fatti provengono da fonti verificabili? | SÌ | Repository e commit upstream, RFC-0001, AGENTS, README, manifest e `ask-skills`. |
| Sono presenti ipotesi non dichiarate? | NO | Il mancato uso del router `index` e il ruolo di `ask-skills` sono espliciti. |
| Mancano informazioni necessarie? | NO | Scope, upstream, commit, routing e fonti correnti sono determinati. |
| Le decisioni rilevanti sono tracciabili e contestabili? | SÌ | PR #48, manifest, README, `ask-skills` e questo closeout conservano decisione ed evidenza. |
| Ogni informazione operativa ha un solo punto autorevole? | SÌ | Manifest = upstream; README = catalogo; `ask-skills` = routing; questo file è solo evidenza storica `Archived`. |
| Sono state introdotte duplicazioni evitabili? | NO | Nessuna skill vendorizzata; il routing non duplica il contenuto operativo delle singole skill. |
| I documenti interessati hanno stato corretto? | SÌ | Le fonti operative restano correnti; questo documento nasce `Archived` come evidenza di closeout, non come nuova fonte operativa. |
| La documentazione attiva rappresenta lo stato finale? | SÌ | README descrive le 16 skill e `ask-skills` sa consigliarle per scenario. |
| Artefatti superati devono essere archiviati o sostituiti? | NON APPLICABILE | Nessun documento Active è stato reso superato; il router e il catalogo esistenti sono stati aggiornati. |
| Le verifiche producono evidenze osservabili? | SÌ | Diff PR, lettura dei path upstream pinned e ispezione delle fonti aggiornate sono verificabili. |
| Sono necessari retry GitHub Actions? | NO | Nessun retry o rerun manuale è richiesto dal closeout. |

## Verifica del routing Data Analytics

| Scenario | Skill consigliata |
|---|---|
| decisione di prodotto o business basata su metriche | `product-business-analysis` |
| spiegare un movimento o un'anomalia di una metrica | `metric-diagnostics` |
| contesto di business mancante per l'analisi | `gather-business-context` |
| dubbio su affidabilità, grain, freshness o definizioni | `analyze-data-quality` |
| QA di un'analisi già prodotta | `validate-data` |
| definire KPI, target, driver o guardrail | `design-kpis` |
| scorecard, WBR, MBR, QBR o update executive | `kpi-reporting` |
| dashboard o scorecard | `build-dashboard` |
| grafico o figura quantitativa | `visualize-data` |
| report analitico durevole | `build-report` |
| conversione esplicita di report HTML esistente | `report-to-google-doc` / `report-to-google-slides` / `report-to-pdf` |
| notebook SQL/Python riproducibile | `jupyter-notebooks` |
| TAM/SAM/SOM o sizing opportunità | `market-sizing` |
| semantic layer persistente richiesto esplicitamente | `create-data-context` |

## Stato finale

Il closeout non introduce nuove istruzioni operative. Dopo il merge della PR #48, lo stato corrente deve essere letto da `README.md`, `global/ask-skills/SKILL.md` e `config/global-skill-upstreams.tsv`; questo documento conserva esclusivamente l'evidenza della missione conclusa.
