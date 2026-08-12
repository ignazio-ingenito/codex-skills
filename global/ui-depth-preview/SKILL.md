---
name: ui-depth-preview
description: Use when serve mostrare come cambierebbe una UI esistente applicando modifiche di layering o depth, soprattutto da screenshot o immagini di riferimento.
---

# UI Depth Preview

## Obiettivo

Produrre anteprime visive credibili di modifiche al **layering/depth** di una UI esistente. Il layering/depth cambia; non fare redesign generale.

Usa questa skill quando l'utente vuole vedere il risultato prima di implementarlo. Non usarla per creare una nuova UI da zero, fare una review frontend generale o costruire un prototipo funzionante.

## Contratto di fedeltà

Se l'utente ha già indicato quanto deve essere fedele la preview, non chiedere altro. Altrimenti poni una sola domanda di routing:

- **Indicativa** — serve capire rapidamente la direzione visiva; uno screenshot o un'immagine sono normalmente sufficienti.
- **Fedele** — preserva il più possibile composizione, contenuti, proporzioni, palette e tipografia, modificando principalmente layering e depth. Non promettere pixel accuracy.

Per la modalità Fedele, chiedi input aggiuntivi solo quando possono cambiare **materialmente** una proprietà osservabile della preview. Il codice è opzionale: leggilo solo per risolvere ambiguità visive reali, per esempio stato di overlay, superficie parent/child o comportamento sticky.

Se manca uno screenshot e l'app è già disponibile senza modifiche o setup aggiuntivo, puoi acquisirlo. Non implementare o prototipare l'app solo per ottenere la preview.

Leggi `references/preview-fidelity.md` per il routing completo.

## Metodo

1. **Blocca ciò che non deve cambiare.** Mantieni layout, contenuti, identità visiva e gerarchia funzionale salvo modifiche indispensabili per rendere osservabile il nuovo layering.
2. **Mappa i piani visivi.** Identifica canvas/base, superfici contenitive, superfici realmente rialzate e transient/overlay. Non equiparare automaticamente `z-index` a elevation.
3. **Applica i cue in ordine di costo.** Prima surface/tonal separation, poi border se serve, quindi shadow + light per vero distacco. Blur/traslucenza solo quando comunicano una relazione di sovrapposizione o materiale.
4. **Genera la preview con una capacità visuale disponibile** preferendo editing/generazione dell'immagine originale. Se il runtime non può produrre immagini, dichiaralo: non sostituire la preview con una mini-implementazione nascosta.
5. **Confronta e dichiara confidence.** Spiega in poche righe cosa cambia tra le varianti e quanto la preview è rappresentativa dell'esito atteso.

Leggi `references/layering-model.md` prima di decidere livelli e cue.

## Varianti

Per default genera due preview:

- **Balanced** — gerarchia spaziale chiara, depth evidente ma controllata; è la proposta raccomandata.
- **Expressive** — stessa struttura, ma separazione tra piani più marcata e cue più ricchi dove sono semanticamente giustificati.

La terza variante esiste solo se richiesta dall'utente o se emerge una strategia realmente distinguibile; in quel caso usa **Conservative** per la modifica minima efficace.

Le varianti devono cambiare la strategia di layering, non reinventare layout, palette o stile.

## Guardrail effort → risultato

- Non ispezionare codice, design system o stati aggiuntivi se non possono cambiare qualcosa di visibile nella preview.
- Non fare audit completi di `z-index`, component tree o token solo per completezza.
- Non creare app, route, Storybook o prototipi temporanei per generare immagini.
- Non aumentare il numero di layer perché “più profondità” sembra migliore: ogni layer deve comunicare una relazione.
- Preferisci due alternative chiaramente diverse a tre quasi identiche.

## Output minimo

Restituisci:

1. preview **Balanced**;
2. preview **Expressive**;
3. eventuale terza preview solo se giustificata;
4. 3–6 differenze osservabili tra le varianti;
5. `Confidence: alta | media | bassa` con una sola riga di motivazione.

Se la modalità richiesta è Fedele ma gli input non la supportano, non fingere precisione: chiedi il solo input mancante che aumenterebbe davvero la fedeltà oppure degrada esplicitamente a Indicativa con consenso dell'utente.
