# Validazione porting Matt Pocock

**Stato:** Archived
**Archiviato:** 2026-08-20 — PR #16 conclusa; README e skill del repository restano le fonti operative correnti.
**PR:** #16
**Fonti autorevoli:** issue #10, RFC-0001, `mattpocock/skills@9603c1cc8118d08bc1b3bf34cf714f62178dea3b`, README e skill del repository.

## Deroga approvata

`teach` era inizialmente esclusa dalla issue #10. Il maintainer ne ha richiesto esplicitamente l'inclusione durante l'implementazione. La deroga è quindi intenzionale, tracciata e limitata a `global/teach/` e ai tre formati associati.

## Matrice RFC-0001

| Verifica | Esito | Evidenza |
|---|---|---|
| La soluzione soddisfa tutti i requisiti applicabili? | SÌ | Skill richieste presenti; `teach` inclusa tramite deroga esplicita del maintainer; validazione strutturale eseguita su 89 skill. |
| Esiste un modo più semplice per ottenere lo stesso risultato? | SÌ | Riutilizzate skill locali esistenti; non sono state introdotte copie di `implement`, `code-review` o nuovi framework. |
| Ogni complessità introdotta ha una giustificazione verificabile? | SÌ | Ogni nuova skill corrisponde a una capability richiesta; i soli adattamenti locali sono compatibilità Codex, routing e riferimenti reali. |
| La fattibilità della soluzione è stata verificata? | SÌ | `scripts/validate-skills.sh`, `bash -n scripts/*.sh`, controllo YAML e `git diff --check` hanno prodotto esito positivo prima della PR. |
| I fatti utilizzati provengono da fonti verificabili? | SÌ | Issue #10, RFC-0001, repository upstream pin-nato e file del repository. |
| Ogni deduzione cita i fatti e il passaggio logico da cui deriva? | SÌ | Le decisioni di adattamento sono riportate nelle sezioni Provenance e nella PR. |
| Sono presenti ipotesi non dichiarate? | NO | Le limitazioni di runtime, il fallback sequenziale e la deroga `teach` sono espliciti. |
| Mancano informazioni necessarie per assumere decisioni rilevanti? | NO | Scope, fonti, branch, criteri e deroga sono noti. |
| Le decisioni rilevanti sono tracciabili e contestabili? | SÌ | Commit separati, issue #10-#15, PR #16 e sezioni Provenance. |
| Ogni informazione operativa ha una sola fonte autorevole? | SÌ | README è il catalogo; le skill sono le fonti operative; questo file contiene solo evidenze di validazione. |
| Sono state introdotte duplicazioni evitabili? | NO | Nessuna skill canonica duplicata; le varianti di progetto restano separate solo dove già intenzionali. |
| I documenti interessati hanno uno stato corretto? | SÌ | Al closeout questo documento è stato archiviato; issue e PR conservano lo stato storico del lavoro. |
| La documentazione attiva rappresenta lo stato corrente del progetto? | SÌ | README aggiornato e condensato; inventario coerente con le directory presenti. |
| Le verifiche producono evidenze osservabili? | SÌ | Output osservati: `Validated 89 skill(s)`, `All skill frontmatter valid`, nessun errore Bash o diff. |

## Scenari realistici verificati

La verifica è stata eseguita per ispezione del workflow, dei riferimenti e delle stop condition; dove applicabile sono stati controllati i fallback Codex e i collegamenti alle skill locali.

| Skill | Scenario verificato | Esito |
|---|---|---|
| `ask-skills` | Richiesta: scegliere il prossimo passo dopo validazione di un branch. Instrada verso review, verifica e richiesta di review senza avviare un flusso sproporzionato. | SÌ |
| `setup-matt-pocock-skills` | Repository senza mapping label o struttura tracker. Propone la configurazione richiesta senza introdurre un nuovo runtime. | SÌ |
| `to-spec` | Conversazione con decisioni già risolte. Produce una specifica implementabile e non riapre il discovery. | SÌ |
| `to-tickets` | Specifica approvata con dipendenze. Produce ticket tracer-bullet ordinati e con blocker espliciti. | SÌ |
| `wayfinder` | Iniziativa multi-sessione con decisioni ancora aperte. Crea una mappa di decision ticket e rientra in `to-spec` quando risolta. | SÌ |
| `research` | Domanda tecnica che richiede fonti primarie. Produce evidenza citata e separa fatti da decisioni. | SÌ |
| `tdd` | Bugfix con comportamento riproducibile. Richiede red-green-refactor e fallback sequenziale. | SÌ |
| `domain-modeling` | Due termini sovraccarichi nel dominio. Aggiorna glossario, invarianti e decisioni senza inventare concetti. | SÌ |
| `codebase-design` | Modulo shallow con interfaccia ampia. Usa depth, seam, leverage e locality per confrontare alternative. | SÌ |
| `resolving-merge-conflicts` | Conflitto tra refactor e modifica funzionale. Ricostruisce l'intento di entrambe le versioni prima della risoluzione. | SÌ |
| `handoff` | Sessione lunga da continuare altrove. Produce un file autosufficiente con stato, decisioni e prossimi passi. | SÌ |
| `grilling` | Piano ambiguo ma circoscritto. Intervista una domanda alla volta e si ferma quando le decisioni sono sufficienti. | SÌ |
| `teach` | Percorso didattico nel workspace. Usa missione, risorse e learning record senza perdere lo stato tra lezioni. | SÌ, deroga approvata |
| `triage` | Bug incompleto in ingresso. Mantiene la macchina a stati upstream, usa `grill-with-docs` solo quando serve e adatta l'invocazione a Codex. | SÌ |
| `improve-codebase-architecture` | Ricerca di moduli shallow. Mantiene report HTML e grilling upstream, con esplorazione parallela opzionale e fallback per l'apertura del file. | SÌ |
| `code-review-and-quality` | PR conforme ai test ma non alla spec. Riporta separatamente `Standards` e `Spec`; un FAIL blocca l'approvazione. | SÌ |
| `grill-with-screenshots` | Skill legacy senza frontmatter. Il contenuto operativo resta invariato e la skill torna validabile. | SÌ |

## Verifiche operative

```text
scripts/validate-skills.sh
Validated 89 skill(s)

bash -n scripts/*.sh
PASS

frontmatter YAML check
All skill frontmatter valid

git diff --check origin/main...HEAD
PASS

git status --short
clean
```

Le verifiche successive appartengono al normale ciclo di validazione del repository; questo documento conserva soltanto le evidenze della PR #16.
