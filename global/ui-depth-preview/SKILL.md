---
name: ui-depth-preview
description: Use when a user needs to preview how an existing UI would change after layering or depth adjustments, especially from screenshots or reference images.
---

# UI Depth Preview

## Obiettivo

Produrre anteprime visive di modifiche al **layering/depth** di una UI esistente. Il layering/depth cambia; non fare redesign generale.

Non usare questa skill per creare UI da zero, review frontend generiche o prototipi funzionanti.

## Fedeltà

Se l'utente ha già indicato la fedeltà, non chiedere altro. Altrimenti chiedi una sola volta:

- **Indicativa** — mostra rapidamente la direzione; normalmente basta uno screenshot/immagine.
- **Fedele** — conserva composizione, contenuti, proporzioni, palette e tipografia, cambiando principalmente layering/depth. Non promettere pixel accuracy.

In modalità Fedele chiedi input aggiuntivi solo se possono cambiare **materialmente** qualcosa di osservabile nella preview. Il codice è opzionale: leggilo solo per risolvere ambiguità visive reali.

Se manca uno screenshot e l'app è già disponibile senza modifiche o setup dedicato, puoi acquisirlo. Non implementare o prototipare l'app solo per ottenere la preview.

Dettagli: `references/preview-fidelity.md`.

## Metodo

1. **Preserva l'originale.** Mantieni layout, contenuti, identità e gerarchia funzionale salvo ciò che serve a rendere visibile il layering.
2. **Mappa i piani.** Distingui base, surface, raised e overlay. `z-index` non equivale automaticamente a elevation.
3. **Applica cue proporzionati.** Prima surface/tonal separation, poi border se necessario, quindi shadow + light per vero distacco. Blur/traslucenza solo se comunicano sovrapposizione o materiale.
4. **Genera visualmente.** Preferisci editing/generazione dello screenshot originale. Se il runtime non può produrre immagini, dichiaralo: non sostituire la preview con una mini-implementazione.
5. **Confronta.** Evidenzia differenze osservabili e dichiara la confidence.

Modello: `references/layering-model.md`.

## Varianti

Per default genera due preview:

- **Balanced** — depth chiara e controllata; proposta raccomandata.
- **Expressive** — stessa mappa semantica, separazione tra piani più marcata e cue più ricchi dove giustificati. Può usare selettivamente `material / blur / translucency / subtle refraction / lens-like effects` su superfici già floating, transient o parte del chrome applicativo.

> Expressive may use selective material, blur, translucency or lens/refraction effects only on surfaces that are already semantically floating, transient or part of the application chrome. These effects must strengthen an existing depth relationship, never create one decoratively.
>
> Balanced and Expressive must remain based on the same semantic layer map. Expressive differs through stronger visual treatment, not through additional structural layers.

La terza variante esiste solo se richiesta o realmente distinguibile; usa **Conservative** per la modifica minima efficace.

Le varianti cambiano il trattamento del layering, non layout, contenuti, palette principale, tipografia o identità. Expressive deve restare riconoscibile a colpo d'occhio come la stessa UI: niente imitazione di Apple/macOS, glassmorphism generico o materiale diffuso su normali content/document card e canvas.

## Guardrail effort → risultato

- Non ispezionare codice, design system o stati se non possono cambiare qualcosa di visibile.
- Non fare audit completi di `z-index`, component tree o token per completezza.
- Non creare app, route, Storybook o prototipi temporanei per generare immagini.
- Ogni layer deve comunicare una relazione percepibile.
- Preferisci due alternative chiaramente diverse a tre quasi identiche.

## Output minimo

1. preview **Balanced**;
2. preview **Expressive**;
3. terza preview solo se giustificata;
4. 3–6 differenze osservabili;
5. `Confidence: alta | media | bassa` con una riga di motivazione.

Se gli input non supportano una preview Fedele, chiedi solo il dato che aumenterebbe davvero la fedeltà oppure proponi di degradare esplicitamente a Indicativa.
