# Layering model

Questo riferimento normalizza principi di Fluent 2, Atlassian e Carbon in una grammatica minima per la preview. Non serve a imitare un brand: serve a decidere **quali piani esistono, perché esistono e quale cue visivo li rende leggibili**.

## Modello minimo

| Livello | Ruolo | Cue preferiti | Evita |
|---|---|---|---|
| **L0 — Base** | canvas/app background | colore/surface di base | shadow decorativa |
| **L1 — Surface** | regioni e gruppi di contenuto | tonal separation, spacing, border sottile se serve | trasformare ogni gruppo in card |
| **L2 — Raised** | elemento che deve apparire sopra o indipendente dalla surface | shadow + light coerenti, eventuale contrasto di surface | elevare figli solo perché annidati |
| **L3 — Overlay** | popover, menu, modal, transient surface | shadow più ampia/soft, occlusion; materiale/blur solo se utile | blur generalizzato o z-index usato come design |

Non aggiungere un livello se non comunica una relazione percepibile: contenimento, indipendenza, sovrapposizione, focus o transienza.

## Regole decisionali

1. **Surface prima di shadow.** Se basta una variazione tonale a separare due regioni, non elevare.
2. **Shadow implica distanza.** Ombre più nette indicano vicinanza; aumentando la distanza devono diventare più ampie e morbide. Mantieni una direzione luminosa coerente.
3. **Border è separazione, non elevation.** Usalo quando due superfici adiacenti hanno contrasto insufficiente, non per simulare profondità.
4. **Overlay è semanticamente diverso da Raised.** Un popover/menu/modal vive sopra il flusso e può occludere il contenuto; una card raised resta parte del contenuto.
5. **`z-index` e depth non sono sinonimi.** `z-index` governa stacking/overlap tecnico; la preview deve rappresentare il ruolo percepito.
6. **Nesting con budget.** Mantieni la maggior parte dei componenti vicina alla surface. Evita catene di card dentro card dentro card; normalmente non servono più di due livelli contenitivi visivamente distinti.
7. **Dark mode richiede surface hierarchy.** Le shadow perdono efficacia: aumenta la separazione tonale tra piani prima di intensificare le ombre.
8. **Materiale solo quando spiega una relazione.** Traslucenza/blur hanno senso per superfici che lasciano percepire contenuto sottostante o per elementi transient; non sono decorazione di default.
9. **Motion solo se la preview rappresenta uno stato dinamico.** Un elemento può acquisire elevation durante drag/open/hover, ma non inventare stati non richiesti.

## Come costruire Balanced ed Expressive

### Balanced

- L0/L1 leggibili soprattutto tramite surface e spacing.
- Shadow selettiva solo su elementi davvero Raised/Overlay.
- Contrasto tra layer sufficiente ma non teatrale.
- Material/blur raro.

### Expressive

- Stessa mappa semantica di Balanced.
- Maggiore separazione tonale tra piani.
- Raised/Overlay con shadow più percepibile ma sempre coerente con una singola sorgente luminosa.
- Material/blur consentito solo quando rafforza sovrapposizione o transienza.

Se Expressive richiede nuovi livelli semantici che Balanced non aveva, probabilmente non è più una variante: ricontrolla la mappa.

## Fonti primarie

- Fluent 2 — Elevation: https://fluent2.microsoft.design/elevation
  - elevation come distanza percepita lungo Z;
  - shadow + light comunicano distanza;
  - shadow più ampia e morbida per oggetti percepiti più lontani dalla superficie.
- Fluent 2 — Material: https://fluent2.microsoft.design/material
  - materiali solid, occluding e transparent per diverse relazioni tra superfici.
- Fluent 2 — Design: https://fluent2.microsoft.design/get-started/design
  - la maggior parte dei componenti resta vicina alla superficie e il nesting profondo va evitato.
- Atlassian — Elevation: https://atlassian.design/foundations/elevation/
  - surface + shadow per lift/depth; raised e overlay sono i livelli più elevati;
  - in dark theme la differenza di surface aiuta quando le shadow sono meno visibili.
- Carbon — Color / Layering model: https://carbondesignsystem.com/elements/color/overview/
  - neutral surface layers creano depth e associazioni spaziali;
  - la gerarchia cromatica è parte strutturale del layering, non un effetto decorativo.

## Principio finale

La preview è riuscita quando l'utente può indicare **quale elemento sta sopra quale, perché, e cosa accadrebbe visivamente se i due piani si sovrapponessero** senza dover leggere una spiegazione.
