---
name: gemini-presentation-handoff
description: Prepara un handoff completo di contenuti, struttura e asset per far realizzare o rifinire una presentazione a Gemini senza trasferire art direction o decisioni grafiche.
argument-hint: "Presentazione o progetto da trasferire a Gemini"
disable-model-invocation: true
---

# Gemini Presentation Handoff

Usa questa skill quando una presentazione è stata pensata, discussa o parzialmente costruita in una sessione e l'utente vuole affidare a Gemini la realizzazione visuale delle slide senza perdere il lavoro già svolto.

L'obiettivo è trasferire **informazione e intenzione**, non il design.

## Principio fondamentale

Prepara per Gemini tutto ciò che serve a ricostruire correttamente la presentazione a livello di contenuto e narrativa, ma **non impartire istruzioni grafiche o di art direction**.

Non specificare layout, colori, font, stile visuale, composizione, iconografia, tipo di diagramma, stile delle immagini, gerarchie grafiche, animazioni o altre scelte estetiche, salvo che siano requisiti espliciti e già vincolanti forniti dall'utente o da una fonte autorevole.

Gemini deve restare libero di decidere come rappresentare visualmente il materiale.

## Raccolta del contesto

Recupera dalla conversazione, dal workspace e dagli artefatti disponibili tutto ciò che è già stato deciso sulla presentazione. Non chiedere all'utente di ripetere informazioni che sono recuperabili.

Distingui chiaramente:

- fatti e contenuti confermati;
- decisioni narrative già prese;
- elementi ancora aperti o incompleti;
- materiali sorgente disponibili;
- materiali necessari ma non accessibili.

Non inventare contenuti mancanti per rendere l'handoff apparentemente completo.

## Contenuto obbligatorio dell'handoff

L'handoff deve includere almeno:

### 1. Obiettivo e audience

- scopo della presentazione;
- audience;
- contesto in cui verrà usata;
- risultato che la presentazione deve ottenere;
- eventuali vincoli di durata, numero di slide o formato già definiti.

### 2. Storyline

Descrivi la logica narrativa complessiva e il percorso che deve compiere l'audience.

Preserva le decisioni già approvate: non riscrivere la storia solo per renderla più elegante.

### 3. Sequenza delle slide

Per ogni slide indica:

- numero o posizione;
- ruolo nella storyline;
- messaggio principale che deve lasciare;
- contenuti obbligatori;
- dati, numeri, citazioni o fonti pertinenti;
- eventuali relazioni con slide precedenti o successive;
- eventuali elementi ancora da decidere.

Non descrivere come la slide deve essere disegnata.

### 4. Asset e screenshot

Tratta screenshot, immagini dell'applicazione, diagrammi esistenti, loghi, documenti, grafici sorgente e altri asset originali come parte del contenuto da trasferire.

Per ciascun asset disponibile indica:

- nome o identificatore;
- che cosa mostra;
- perché è rilevante;
- a quale slide o sezione appartiene;
- eventuale rapporto con altri asset.

Quando l'utente ha richiesto l'uso di screenshot reali dell'applicazione, includi gli **originali** nell'handoff o rendili disponibili insieme al pacchetto destinato a Gemini. Non sostituirli con descrizioni se il file è accessibile.

Non ritagliare, ridisegnare, reinterpretare o rigenerare gli screenshot per suggerire una soluzione visuale. La loro funzione è fornire a Gemini la sorgente reale.

Se un asset citato nella conversazione non è accessibile, dichiaralo esplicitamente tra i materiali mancanti invece di inventarlo.

### 5. Fonti e materiale di supporto

Includi o collega le fonti necessarie a sostenere i contenuti della presentazione, mantenendo la distinzione tra:

- materiale da mostrare nella presentazione;
- materiale di riferimento utile a Gemini per comprenderla.

Non duplicare documenti autorevoli quando è sufficiente referenziarli.

### 6. Decisioni da preservare

Elenca soltanto le decisioni già stabilite che Gemini non deve reinterpretare, per esempio:

- ordine narrativo;
- messaggi chiave;
- terminologia;
- dati da usare;
- contenuti da includere o escludere;
- tono comunicativo quando già deciso.

Non trasformare questa sezione in un brief grafico.

### 7. Libertà lasciata a Gemini

Chiudi l'handoff chiarendo che Gemini è responsabile della traduzione visuale della struttura ricevuta e può scegliere autonomamente la soluzione grafica più efficace, purché non alteri contenuti, significato, ordine narrativo e vincoli esplicitamente indicati.

## Formato consigliato

Produci un pacchetto ordinato con questa struttura:

```markdown
# Gemini Presentation Handoff — <titolo/progetto>

## Objective and audience
...

## Narrative
...

## Slide sequence

### Slide 1 — <ruolo o titolo di lavoro>
- Purpose:
- Key message:
- Required content:
- Evidence / sources:
- Assets:
- Open points:

...

## Asset map
| Asset | Description | Intended slide/section | Notes |
|---|---|---|---|

## Sources and supporting material
...

## Decisions to preserve
...

## Missing material / unresolved points
...

## Instruction to Gemini
Use the structure, content, sources and original assets in this handoff as the authoritative presentation brief. Preserve the narrative and required information. You are free to determine the visual design and slide composition. Do not change factual content or omit required material without flagging it.
```

Il testo finale può essere adattato alla lingua della presentazione o a quella richiesta dall'utente.

## Verifica finale

Prima di consegnare controlla che:

1. una persona o un modello senza accesso alla sessione originale possa capire obiettivo, audience e storyline;
2. ogni slide abbia un messaggio e contenuti sufficienti per essere realizzata;
3. le decisioni già prese siano state preservate;
4. gli screenshot e gli asset originali disponibili siano stati mappati e trasferiti;
5. i materiali mancanti siano dichiarati, non inventati;
6. non siano state introdotte istruzioni grafiche non richieste;
7. Gemini mantenga piena libertà sulla realizzazione visuale.
