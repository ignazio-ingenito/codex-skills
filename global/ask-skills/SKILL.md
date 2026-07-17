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

Il percorso seguito dalla maggior parte del lavoro. Hai un'idea e vuoi realizzarla.

1. **`grill-with-docs`** — affina l'idea tramite intervista. Parti da qui quando **esiste un codebase**: conserva ciò che apprende in `CONTEXT.md` e negli ADR. Se serve soltanto un'intervista mirata usa `grilling`; se il problema sono soprattutto termini e invarianti, usa anche `domain-modeling`.
2. **Branch — ogni domanda può essere risolta in conversazione?** Se una domanda richiede una risposta eseguibile — stato, business logic o una UI da vedere — devia attraverso un prototipo, usando **`handoff`** in entrambe le direzioni:
   - `handoff` in uscita, poi apri una sessione nuova riferita al file;
   - `prototype` per rispondere con codice throwaway;
   - `handoff` di ritorno con ciò che è stato appreso, referenziandolo dal thread originale.
3. **Branch — è un lavoro multi-sessione?**
   - **Sì** → `to-spec`, poi `to-tickets` per dividerlo in tracer-bullet ticket con blocker espliciti. Ogni ticket viene eseguito in un contesto pulito usando le skill di delivery locali.
   - **No** → procedi nello stesso contesto con il percorso di delivery minimo necessario.

   In entrambi i casi, la delivery usa le skill già presenti invece di una skill `implement` separata: `writing-plans` quando proporzionato, `using-git-worktrees` quando serve isolamento, `tdd` per comportamento eseguibile, `senior-implementation-discipline` quando applicabile, `code-review-and-quality` per la review e `verification-before-completion` prima della chiusura. Usa `requesting-code-review` e `receiving-code-review` quando il flusso richiede una review separata.

### Igiene del contesto

Mantieni i passaggi 1–3 nello stesso contesto finché non sono stati prodotti spec e ticket. Ogni ticket implementativo parte poi da un contesto pulito, lavorando dalla propria fonte autorevole.

Se il contesto diventa troppo grande prima di `to-tickets`, usa `handoff` e continua in una sessione nuova invece di proseguire con contesto degradato.

## On-ramp

Una situazione iniziale che genera lavoro e poi confluisce nel flusso principale.

- **Issue, bug report e richieste in ingresso** → `triage`. Produce issue pronte per la delivery.

  Il triage si applica alle richieste arrivate grezze. I ticket generati da `to-tickets` sono già pronti e non vanno sottoposti nuovamente a triage.

- **Qualcosa è rotto** → usa la skill di debugging più specifica documentata per il progetto; in assenza di una variante usa `systematic-debugging`. Crea un feedback loop riproducibile, aggiungi un regression test e poi verifica. Se il problema reale è l'assenza di un seam testabile, passa a `improve-codebase-architecture`.

- **Un'iniziativa enorme e nebbiosa** → `wayfinder`. Usa una mappa condivisa di decision ticket e risolve decisioni, non deliverable, finché il percorso diventa visibile. Riservalo ai lavori che non possono essere contenuti in una sessione.

  Quando la mappa è risolta, rientra nel flusso principale con `to-spec`, quindi `to-tickets` e delivery ticket per ticket.

## Salute del codebase

Non è feature work: è manutenzione.

- **`improve-codebase-architecture`** — individua opportunità di deepening e testabilità. La scelta di un candidato genera un'idea che può rientrare nel flusso principale tramite `grill-with-docs`. `codebase-design` fornisce il vocabolario per progettare il modulo scelto.
- **`code-simplification`** — semplifica codice funzionante preservandone il comportamento.
- **`zoom-out`** — fornisce una mappa ad alto livello quando il codice non è comprensibile localmente.

## Vocabolario sottostante

Riferimenti invocabili dal modello che lavorano sotto le altre skill. Usali direttamente quando il problema sono le parole o la forma del design, oppure lascia che siano le skill di processo a richiamarli.

- **`domain-modeling`** — affina il linguaggio di dominio, risolve termini sovraccarichi e mantiene `CONTEXT.md` come glossario pulito.
- **`codebase-design`** — vocabolario per moduli profondi, interfacce, seam, adapter, leverage e locality. È usato anche da `tdd` e `improve-codebase-architecture`.

## Attraversare le sessioni

- **`handoff`** — compatta una conversazione in un file Markdown quando il thread è pieno o deve diramarsi. La continuazione avviene in una sessione nuova che riferisce quel file.
- **Compattazione del contesto disponibile nel runtime** — resta nella stessa conversazione e usala solo nei confini intenzionali tra fasi. Non compattare nel mezzo di una fase se questo rischia di perdere decisioni operative.

## Standalone

Fuori dal flusso principale.

- **`grilling`** — intervista mirata e una domanda alla volta quando non serve il comportamento documentale completo di `grill-with-docs`.
- **`prototype`** — piccolo programma throwaway che risponde a una domanda di design su stato, logica o UI.
- **`research`** — ricerca su fonti primarie che produce evidenza citata; alimenta il flusso principale ma non sostituisce le decisioni.
- **`resolving-merge-conflicts`** — risolve conflitti Git già presenti preservando l'intento di entrambe le parti.
- **Skill documentate nell'inventario README** — per documenti, contenuti, browser, dati, slide, publishing, sicurezza, homelab e domini specifici, seleziona la skill più specifica descritta nell'inventario. Non duplicare qui l'intero catalogo: il README ne resta la fonte unica.

## Precondizione

**`setup-matt-pocock-skills`** — eseguila prima del primo flusso engineering quando tracker, label di triage o struttura documentale richiesti dalle skill non sono ancora configurati.

## Provenienza

Adattata da `mattpocock/skills`, path `skills/engineering/ask-matt/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`. Modifiche intenzionali: nome `ask-skills`, riferimenti alle skill effettivamente presenti in `codex-skills`, controllo non invasivo di coerenza dell'inventario e guida all'installazione delle skill disponibili ma non attive.