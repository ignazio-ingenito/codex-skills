# Preview fidelity

La fedeltà determina **quanto input vale la pena raccogliere**, non quanta implementazione fare.

## Routing

### Indicativa

Usala quando l'utente vuole capire rapidamente la direzione visiva.

Input minimo:
- screenshot o immagine della UI;
- in assenza, codice o descrizione solo se sufficienti a ricostruire la composizione principale.

Comportamento:
- non chiedere viewport, tema, route o codice se sono già evidenti o non cambiano materialmente la preview;
- privilegia velocità e differenze visive leggibili;
- confidence normalmente media o bassa se mancano stati/interazioni non visibili.

### Fedele

Usala quando la preview deve restare il più possibile aderente alla UI originale.

Input preferito:
- screenshot completo dello stato da rappresentare;
- codice solo per chiarire proprietà non deducibili dall'immagine e visivamente rilevanti;
- eventuale stato/tema/viewport solo se ambiguo e determinante.

Se lo screenshot manca:
1. acquisiscilo solo se l'app è già disponibile o avviabile con il normale flusso esistente, senza modifiche o setup dedicato;
2. altrimenti chiedi all'utente lo screenshot;
3. non costruire o riparare l'app per ottenerlo.

**Fedele non significa pixel-accurate.** Significa conservare composizione, identità, proporzioni e contenuti mentre le modifiche di layering/depth restano l'unica variazione intenzionale significativa.

## Domande ammesse

Se la modalità non è specificata, fai una sola domanda:

> Vuoi una preview **Indicativa** o **Fedele** all'interfaccia originale?

Dopo il routing, chiedi un altro dato solo se puoi completare questa frase in modo concreto:

> “Senza questo dato potrei rappresentare erroneamente ___, che sarebbe visibile nella preview.”

Se non riesci a completarla, non chiedere.

## Uso del codice

Il codice non aumenta automaticamente la fedeltà. Leggilo quando risolve, per esempio:
- se un elemento è sticky/fixed o parte del normale flow;
- se una surface è parent reale o semplice allineamento visivo;
- se un drawer/popover/modal deve occludere il contenuto;
- se theme/token già esistenti limitano il contrasto tra layer.

Non fare audit completi del component tree, di tutti gli `z-index` o dei token se il risultato non può cambiare nell'immagine.

## Generazione visiva

Ordine preferito:
1. modifica/genera a partire dallo screenshot originale con una capacità image-editing/image-generation disponibile;
2. usa visual context aggiuntivo solo per preservare elementi che l'editing rischia di alterare;
3. se non esiste capacità di generazione visuale, dichiara il limite e produci solo il piano di layering: non mascherare una mini-implementazione come preview.

Mantieni per tutte le varianti:
- stesso viewport/aspect ratio quando possibile;
- stessi contenuti e copy;
- stessa struttura e densità;
- stessa palette/typography salvo micro-variazioni necessarie alla surface hierarchy.

## Capacità Codex rilevanti

Codex accetta screenshot e diagrammi come input multimodale. Nel Codex app, quando è disponibile la skill di image generation basata su GPT Image, può creare o modificare immagini per UI mockup. `ui-depth-preview` deve usare queste capacità quando presenti, senza assumerle in ogni runtime.

Fonti OpenAI:
- Codex CLI / multimodal inputs: https://help.openai.com/en/articles/11096431
- Codex app / image generation skill: https://openai.com/index/introducing-the-codex-app/

## Varianti e confidence

Default: **Balanced** + **Expressive**.

Aggiungi **Conservative** solo su richiesta o quando costituisce una terza strategia realmente distinguibile.

Riporta:
- `Confidence: alta` — sorgente visiva completa e nessuna ambiguità rilevante per il layering rappresentato;
- `Confidence: media` — sorgente buona ma almeno una relazione/stato è dedotta;
- `Confidence: bassa` — input parziale o ricostruzione concettuale significativa.

La confidence descrive la rappresentatività della preview, non la qualità estetica.

## Stop condition

Fermati quando un ulteriore input, audit o passaggio non può produrre una differenza osservabile nella preview o ridurre un'ambiguità che l'utente vedrebbe. Questo è il criterio di proporzionalità principale della skill.
