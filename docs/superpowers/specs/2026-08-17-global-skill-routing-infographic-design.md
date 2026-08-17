# Infografica dei flussi delle skill globali

**Stato:** Archived  
**Data:** 2026-08-17  
**Missione:** rendere immediatamente comprensibile quale skill globale usare e in quale sequenza nei principali scenari di lavoro, mantenendo il repository coerente con RFC-0001.

## Fonti autorevoli

- `AGENTS.md` e RFC-0001 attiva.
- `global/ask-skills/SKILL.md` per il routing generale.
- Le `SKILL.md` presenti sotto `global/` per trigger, precondizioni e passaggi obbligatori.
- `README.md` per l'inventario pubblico delle skill.

L'infografica è una guida di orientamento. Le singole `SKILL.md` restano autorevoli per il comportamento dettagliato.

## Decisioni di design

### Perimetro

L'infografica mostra soltanto le skill globali. Le skill specifiche di CAP Aeris, Homelab, Baialupo e degli altri progetti saranno trattate, se richiesto, in infografiche separate.

### Formato

Creare un SVG versionato nel repository e incorporarlo nel README. L'SVG usa soltanto testo, forme e frecce deterministiche: nessuna dipendenza esterna, nessun testo generato dentro un bitmap e nessun font non standard.

Il file deve rimanere leggibile su sfondo chiaro e scuro, a larghezze desktop e tramite zoom su mobile. Il README deve fornire testo alternativo e rimandare a `global/ask-skills/SKILL.md` per il dettaglio operativo.

### Struttura visuale

L'infografica è composta da quattro zone:

1. **Orientamento iniziale**
   - `ask-skills` come router quando il percorso non è evidente.
   - `reality-check` quando esistono repository, RFC, ADR, specifiche o altre fonti autorevoli.
2. **Scenari principali**
   - corsie orizzontali con skill in sequenza;
   - passaggi condizionali con bordo tratteggiato;
   - decisioni rappresentate come brevi etichette, non come nuovi processi.
3. **Scenari operativi frequenti**
   - un secondo pannello compatto per bug, issue in ingresso, grandi iniziative, feedback di review, conflitti Git e codebase non familiare.
4. **Delivery e chiusura**
   - una coda comune riusata dalle corsie che producono codice di produzione.

### Coda comune di delivery

`writing-plans` → `to-tickets` quando il piano è multi-sessione → `using-git-worktrees` quando serve isolamento → implementazione guidata da `tdd` → `code-review-and-quality` → `verification-before-completion`.

`senior-implementation-discipline` è un guardrail trasversale dell'implementazione quando il cambiamento tocca codice esistente o condiviso; non deve apparire come un passaggio eseguito dopo `tdd`.

`requesting-code-review` e `receiving-code-review` compaiono come ciclo opzionale quando la review è separata dal controllo locale.

## Copertura degli scenari

L'asset copre creazione da idea o specifiche, prototipi, assessment,
semplificazione, interventi architetturali, riscritture, migrazioni tecnologiche
e gli on-ramp operativi più frequenti. Le sequenze non sono duplicate in questo
documento: il router canonico è `global/ask-skills/SKILL.md` e l'SVG ne è la
rappresentazione sintetica.

## Correzioni di coerenza incluse

- Aggiungere all'inventario README le skill globali mancanti:
  - `code-debt-review-loop`;
  - `scrittura-comica`.
- Aggiungere alla sezione CAP Aeris la skill mancante `grill-with-screenshots`; non deve comparire nell'infografica globale.
- Allineare `global/ask-skills/SKILL.md` ai ruoli distinti di `interview-me`, `brainstorming`, `idea-refine`, `code-debt-review-loop` e ai percorsi di migrazione/assessment mostrati nell'infografica.
- Non duplicare nella prosa del README tutte le sequenze dell'SVG. Il README deve spiegare come leggerlo e indicare la fonte di dettaglio.

## Criteri di accettazione

- L'SVG mostra esclusivamente skill presenti sotto `global/`.
- Ogni nome visualizzato coincide esattamente con il frontmatter della relativa `SKILL.md`.
- Le skill condizionali sono distinguibili da quelle sempre necessarie nel singolo percorso.
- I percorsi principali e i sei scenari operativi aggiuntivi sono leggibili senza consultare la sorgente SVG.
- Il README incorpora l'asset con testo alternativo e link alla fonte di routing.
- L'inventario README contiene tutte le skill presenti nelle directory canoniche.
- `ask-skills`, README e infografica non si contraddicono.
- `bash -n scripts/*.sh`, `bash scripts/validate-skills.sh` e i test deterministici del repository passano su un checkout della branch.
- Nessun workflow GitHub Actions viene rilanciato manualmente.
