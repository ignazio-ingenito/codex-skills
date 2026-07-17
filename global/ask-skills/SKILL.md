---
name: ask-skills
description: Suggerisce la skill o il breve flusso più adatto tra tutte le skill disponibili in codex-skills, incluse globali e specifiche di progetto, privilegiando la capacità più specifica e il percorso minimo sufficiente.
disable-model-invocation: true
---

# Ask Skills

Non è necessario ricordare il catalogo: descrivi la situazione e questa skill individuerà la prossima mossa tra **tutte** le skill disponibili in `codex-skills`.

`ask-skills` è un **router consultivo**. Non esegue automaticamente un workflow completo e non mostra l'intero catalogo salvo richiesta esplicita.

## Principio fondamentale

Non usare un catalogo hardcoded come fonte di verità. Il repository evolve: scopri le skill realmente presenti al momento dell'invocazione.

## Scoperta del catalogo

1. Leggi `AGENTS.md` e le istruzioni attive del repository corrente.
2. Individua tutti i file `SKILL.md` accessibili nelle directory previste dal repository, almeno:
   - `global/*/SKILL.md`;
   - `projects/*/*/SKILL.md` e livelli equivalenti presenti;
   - `.agents/skills/*/SKILL.md` nel progetto corrente, se esiste;
   - eventuali altre directory dichiarate da `AGENTS.md` o dall'inventario autorevole.
3. Per ogni candidata pertinente, leggi almeno il frontmatter (`name`, `description`, eventuale `disable-model-invocation`) e, quando serve per distinguere capacità simili, le sezioni operative rilevanti.
4. Ignora template, file di supporto e directory prive di un `SKILL.md` valido.
5. Non assumere che una skill provenga da Matt Pocock: origine e autore non influenzano la selezione.

## Precedenza

Applica questo ordine:

1. skill specifica del progetto corrente;
2. skill locale installata in `.agents/skills`;
3. skill globale specializzata;
4. skill globale generica;
5. nessuna skill, quando il task è piccolo e il processo aggiungerebbe solo attrito.

Una skill più specifica prevale solo se copre davvero il task e i suoi prerequisiti sono disponibili. Non scegliere una variante di progetto soltanto perché il nome somiglia.

## Regole di selezione

1. Classifica prima l'intento: ideazione, ricerca, pianificazione, delivery, debugging, review, documentazione, operazioni, contenuti, dati, presentazioni o altro dominio emerso dal catalogo.
2. Scegli il percorso più corto che riduce l'incertezza o completa il task.
3. Preferisci una sola skill principale; proponi un flusso breve solo quando le fasi hanno responsabilità realmente distinte.
4. Non raccomandare una skill i cui prerequisiti non sono disponibili.
5. Non inventare skill che non esistono nel catalogo corrente.
6. Non limitarti alle skill ingegneristiche: considera tutte le skill globali e di progetto trovate, comprese quelle per documenti, slide, dati, publishing, homelab, automazione, sicurezza e domini specifici.
7. Se due skill si sovrappongono, confronta esplicitamente scope, output e vincoli; seleziona quella più specifica.
8. Se la richiesta implica una decisione di architettura, processo o prodotto non già risolta, segnala il punto di arresto invece di fingere che una skill possa deciderlo autonomamente.

## Output

Restituisci:

1. **Situazione rilevata** — fatti disponibili e informazioni mancanti rilevanti.
2. **Skill consigliata** — nome esatto e percorso della skill principale.
3. **Perché** — ragione concreta e alternative vicine escluse.
4. **Risultato atteso** — artefatto, modifica o evidenza prodotta.
5. **Flusso successivo** — solo i passaggi già prevedibili e necessari.
6. **Precedenza applicata** — indica quando una variante di progetto ha sostituito una globale.

Indica “non usare ancora” soltanto quando evita un errore probabile.

## Pattern ricorrenti

Questi sono orientamenti, non un catalogo esaustivo. Verifica sempre che le skill esistano davvero.

- Idea ambigua → skill di brainstorming o grilling appropriata → eventuale specifica.
- Iniziativa enorme e nebbiosa → `wayfinder` → `to-spec` → `to-tickets`.
- Ticket implementativo → piano proporzionato → TDD quando applicabile → review → verifica finale.
- Bug o test rotto → skill di debugging più specifica disponibile → regression test → verifica.
- Issue o PR in ingresso → `triage`, salvo ticket già generati e pronti dal flusso di pianificazione.
- Conflitto Git già in corso → `resolving-merge-conflicts`.
- Domanda fattuale esterna → `research` o una skill di dominio più specifica.
- Passaggio tra sessioni → `handoff`.

## Catalogo su richiesta

Se l'utente chiede di vedere il catalogo:

1. raggruppa le skill per dominio e progetto;
2. mostra nome, descrizione breve e percorso;
3. evidenzia duplicati intenzionali e precedenze progetto/globale;
4. non omettere skill solo perché non sono ingegneristiche o non provengono da Matt;
5. segnala file non validi o template separatamente, senza presentarli come skill attive.

## Configurazione

Quando un flusso dipende da tracker, label di triage o fonti di dominio non configurate, suggerisci la skill di setup effettivamente presente nel catalogo. Non assumere un nome storico: scopri e usa quello reale.

## Provenienza

Evoluzione del router consultivo upstream `mattpocock/skills` (`ask-matt`), estesa per coprire dinamicamente l'intero catalogo `codex-skills`, incluse skill globali, locali e specifiche di progetto.