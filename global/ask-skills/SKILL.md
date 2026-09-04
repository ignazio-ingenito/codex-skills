---
name: ask-skills
description: Chiede quale skill o flusso si adatta alla situazione corrente. Router sulle skill documentate in questo repository.
disable-model-invocation: true
---

# Ask Skills

Non devi ricordare ogni skill: chiedi.

Un **flusso** è un percorso attraverso le skill. La maggior parte dei percorsi segue un **flusso principale**; alcuni **on-ramp** vi confluiscono. Tutto il resto è standalone oppure un livello di vocabolario che lavora sotto le altre skill.

Il catalogo autorevole è l'`Inventario Skill` del `README.md`. Le skill specifiche del progetto corrente prevalgono sulle globali equivalenti quando sono installate e documentate.

All'avvio, se è evidente che una skill valida presente nelle directory canoniche non compare nell'inventario, non usarla implicitamente: segnala la discrepanza e proponi di aggiornare il README. Questo è un controllo di coerenza, non un meccanismo di discovery o routing alternativo.

## Skill installate e disponibili

Il catalogo del README descrive tutte le skill disponibili nel repository, non soltanto quelle attualmente installate nel runtime.

Quando suggerisci una skill:

1. verifica se è già disponibile nel runtime corrente;
2. se è installata, suggeriscila normalmente;
3. se è documentata nel repository ma non installata, dichiaralo esplicitamente come **disponibile ma non installata**;
4. mostra il comando di installazione appropriato;
5. ricorda che Codex deve essere riavviato dopo l'installazione.

Per una skill globale usa:

```bash
cd /percorso/del/repository/codex-skills
scripts/install-local.sh <skill-name>
```

Se il checkout corrente è già `codex-skills`, usa semplicemente:

```bash
scripts/install-local.sh <skill-name>
```

Per una skill di progetto usa:

```bash
scripts/install-project.sh <project-name> <project-root>
```

Non affermare che una skill è installata senza evidenza dal runtime. Se non puoi verificarlo, formula il risultato così:

```text
Skill consigliata: <skill-name>
Stato: installazione non verificata
Installazione globale: scripts/install-local.sh <skill-name>
Dopo l'installazione: riavvia Codex
```

Non installare automaticamente una skill soltanto perché è consigliata. Proponi il comando e lascia la decisione all'utente, salvo richiesta esplicita di eseguire l'installazione.

## Il flusso principale: idea → delivery

La maggior parte del lavoro entra da un'idea, una specifica o una modifica a un codebase esistente. Non usare tutte le skill in serie: applica soltanto i passaggi richiesti dalle condizioni seguenti.

1. **Verifica ciò che è già deciso.** Quando esistono repository, RFC, ADR, specifiche o altre fonti autorevoli, usa prima `reality-check`. Elimina domande già risolte e separa fatti, deduzioni e informazioni mancanti.
2. **Chiarisci l'intento prima del design.**
   - Usa `interview-me` quando non sono ancora chiari destinatario, problema, risultato atteso o vincoli.
   - Usa `idea-refine` quando l'intento è abbastanza chiaro ma l'idea è ancora grezza e serve esplorare direzioni alternative.
   - Usa `office-hours` quando la domanda precedente è se l'idea o la scommessa di prodotto meriti davvero investimento.
3. **Risolvi soltanto le decisioni aperte.** In un codebase documentato usa `grill-with-docs`; per un'intervista mirata usa `grilling`; quando il problema riguarda soprattutto termini e invarianti usa `domain-modeling`.
4. **Prototipa prima del design finale, e solo per una domanda eseguibile.** Se una decisione richiede vedere una UI o provare stato, logica o integrazione:
   - usa `handoff` in uscita quando è utile isolare il contesto;
   - usa `prototype` per codice esplicitamente throwaway, prima di invocare `brainstorming`;
   - registra domanda, esito e decisione;
   - elimina il prototipo e usa il risultato come input di `brainstorming`.
5. **Progetta prima di implementare.** Quando il lavoro crea o modifica comportamento, usa `brainstorming` dopo che intento ed eventuali esperimenti sono chiari. Confronta alternative, approva il design e invoca subito `writing-plans`: è l'unico passaggio ammesso dopo `brainstorming`. Non usare `brainstorming` come sostituto di `interview-me`.
6. **Scegli la scala della consegna dopo il piano.**
   - Lavoro multi-sessione → dopo `writing-plans`, usa `to-tickets`; ogni ticket parte da un contesto pulito e dalla propria fonte autorevole.
   - Lavoro contenuto → prosegui dal piano alla delivery nello stesso contesto.
   - Usa `to-spec` quando una conversazione di discovery o un insieme di decisioni deve diventare una fonte pubblicabile prima del design; non inserirla tra `brainstorming` e `writing-plans`.
7. **Implementa e chiudi con evidenze.** Usa `using-git-worktrees` quando serve isolamento, `tdd` per comportamento eseguibile, `senior-implementation-discipline` come guardrail sui cambi condivisi o rischiosi, `code-review-and-quality` per la review e `verification-before-completion` prima della chiusura. Usa `requesting-code-review` e `receiving-code-review` quando la review è un ciclo separato.

### Igiene del contesto

Mantieni intent, decisioni e design nello stesso contesto finché non esiste una fonte implementabile. Ogni ticket implementativo parte poi da un contesto pulito.

Se il contesto diventa troppo grande prima di `to-tickets`, usa `handoff` e continua in una sessione nuova invece di proseguire con contesto degradato.

## On-ramp operativi

Una situazione iniziale che genera lavoro e poi confluisce nel flusso appropriato.

- **Issue, bug report o feature request in ingresso** → `triage`. I ticket già prodotti da `to-tickets` sono pronti e non vanno sottoposti nuovamente a triage.
- **Bug, test o build failure** → `systematic-debugging`, poi fix guidato da `tdd`, review e `verification-before-completion`. Se il problema reale è l'assenza di un seam testabile, passa a `improve-codebase-architecture`.
- **Iniziativa enorme o nebbiosa** → `wayfinder`. Risolvi i decision ticket con `research`, `prototype` o `grilling`, consolida le decisioni con `to-spec`, quindi per ogni workstream eseguibile usa `brainstorming` → `writing-plans` → `to-tickets` quando servono più ticket → delivery ticket per ticket.
- **Feedback di code review** → `receiving-code-review`, verifica tecnica, implementazione proporzionata, `requesting-code-review` quando serve un nuovo controllo separato e `verification-before-completion`.
- **Merge o rebase in conflitto** → `resolving-merge-conflicts`, controlli del repository e `verification-before-completion`.
- **Codebase o modulo non familiare** → `reality-check`, quindi `zoom-out`; rientra poi nello scenario effettivo emerso. La sola comprensione non autorizza un refactor.

## Data Analytics

Quando la richiesta richiede dati strutturati, misure quantitative, metriche, KPI o evidenze numeriche per una decisione di prodotto o business, preferisci le skill Data Analytics più specifiche invece di un generico workflow documentale. Non usare queste skill per semplice scrittura, formattazione o trasformazioni meccaniche prive di analisi quantitativa.

- **Domanda di prodotto/business con decisione o raccomandazione** → `product-business-analysis`.
- **Movimento, anomalia, gap o discrepanza di una metrica** → `metric-diagnostics`; aggiungi `gather-business-context` quando servono definizioni, eventi, owner o decisioni pregresse.
- **Affidabilità di dati, query, dashboard o definizioni metriche** → `analyze-data-quality`; usa `validate-data` quando invece devi revisionare un'analisi già prodotta prima di condividerla o usarla per decidere.
- **Definizione o revisione di KPI, target, driver e guardrail** → `design-kpis`; per scorecard, WBR/MBR/QBR o aggiornamenti executive su KPI esistenti → `kpi-reporting`.
- **Dashboard o scorecard** → `build-dashboard`; usa `visualize-data` quando il bisogno è specificamente progettare, correggere o revisionare grafici e figure quantitative.
- **Report analitico durevole** → `build-report`. Se il report esiste già in HTML e serve una conversione esplicita, usa `report-to-google-doc`, `report-to-google-slides` o `report-to-pdf` secondo il formato richiesto.
- **Notebook SQL/Python riproducibile** → `jupyter-notebooks`.
- **TAM/SAM/SOM o dimensionamento di mercato/opportunità** → `market-sizing`.
- **Contesto analitico persistente o semantic layer** → `create-data-context` soltanto quando l'utente chiede esplicitamente di salvare, creare, aggiornare, ispezionare o riparare quel contesto.

Le skill possono comporsi quando il task lo richiede: per esempio qualità dati → diagnosi metrica → raccomandazione → report. Scegli però sempre il percorso minimo sufficiente e non caricare l'intera suite per una richiesta circoscritta.

## Salute e trasformazione del codebase

Questi percorsi partono da codice esistente e non equivalgono automaticamente a feature work.

- **Assessment generale** → `reality-check` → `zoom-out` → `code-debt-review-loop`. Per il dettaglio usa `code-review-and-quality` sul codice oppure `improve-codebase-architecture` su struttura e testabilità. L'implementazione parte solo dopo la scelta esplicita di un intervento.
- **Semplificazione behavior-preserving** → `reality-check` → `zoom-out` quando necessario → `code-simplification` → `code-review-and-quality` → test mirati → `verification-before-completion`.
- **Miglioramento architetturale** → `reality-check` → `zoom-out` → `improve-codebase-architecture` → scelta del candidato → `codebase-design` e `domain-modeling` quando servono → `grill-with-docs` → `brainstorming` → `writing-plans` → delivery.
- **Riscrittura di codice e architettura** → `reality-check` → `zoom-out` → `code-debt-review-loop` → `improve-codebase-architecture` → `grill-with-docs` → `brainstorming` → `writing-plans` a tranche verticali → delivery. Usa `code-simplification` solo in tranche separate che preservano il comportamento.
- **Cambio di linguaggio o framework** → `reality-check` → `zoom-out` → `research` su versioni e fonti ufficiali → `domain-modeling` per gli invarianti → `codebase-design` per i nuovi confini → `prototype` per i rischi tecnici non risolvibili documentalmente → `brainstorming` → `writing-plans` → `to-tickets` quando il piano è multi-sessione → delivery. Non esiste oggi una skill globale dedicata alla migrazione: non sostituirla implicitamente con una skill specifica di progetto.

## Guardrail trasversali

- **`senior-implementation-discipline`** — applicala durante cambi a codice esistente, contratti, dominio, persistenza, sicurezza o architettura; non trattarla come una fase eseguita dopo `tdd`.
- **`codebase-design`** e **`domain-modeling`** — forniscono vocabolario e invarianti alle skill di processo; non sostituiscono design, piano o verifica.

## Vocabolario sottostante

Riferimenti invocabili dal modello che lavorano sotto le altre skill. Usali direttamente quando il problema sono le parole o la forma del design, oppure lascia che siano le skill di processo a richiamarli.

- **`domain-modeling`** — affina il linguaggio di dominio, risolve termini sovraccarichi e mantiene `CONTEXT.md` come glossario pulito.
- **`codebase-design`** — vocabolario per moduli profondi, interfacce, seam, adapter, leverage e locality. È usato anche da `tdd` e `improve-codebase-architecture`.

## Attraversare le sessioni

- **`handoff`** — compatta una conversazione in un file Markdown quando il thread è pieno o deve diramarsi. La continuazione avviene in una sessione nuova che riferisce quel file.
- **Compattazione del contesto disponibile nel runtime** — resta nella stessa conversazione e usala solo nei confini intenzionali tra fasi. Non compattare nel mezzo di una fase se questo rischia di perdere decisioni operative.

## Standalone

Fuori dal flusso principale.

- **`reality-check`** — verifica fonti autorevoli e decisioni già determinate prima di porre domande o proporre complessità.
- **`grilling`** — intervista mirata e una domanda alla volta quando non serve il comportamento documentale completo di `grill-with-docs`.
- **`prototype`** — piccolo programma throwaway che risponde a una domanda di design su stato, logica o UI.
- **`research`** — ricerca su fonti primarie che produce evidenza citata; alimenta il flusso principale ma non sostituisce le decisioni.
- **`resolving-merge-conflicts`** — risolve conflitti Git già presenti preservando l'intento di entrambe le parti.
- **Skill documentate nell'inventario README** — per documenti, contenuti, browser, dati, slide, publishing, sicurezza, homelab e domini specifici, seleziona la skill più specifica descritta nell'inventario. Non duplicare qui l'intero catalogo: il README ne resta la fonte unica.

## Precondizione

**`setup-matt-pocock-skills`** — eseguila prima del primo flusso engineering quando tracker, label di triage o struttura documentale richiesti dalle skill non sono ancora configurati.

## Provenienza

Adattata da `mattpocock/skills`, path `skills/engineering/ask-matt/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`. Modifiche intenzionali: nome `ask-skills`, riferimenti alle skill effettivamente presenti in `codex-skills`, controllo non invasivo di coerenza dell'inventario, routing source-grounded tramite `reality-check`, routing Data Analytics verso le skill OpenAI documentate e guida all'installazione delle skill disponibili ma non attive.
