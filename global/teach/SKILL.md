---
name: teach
description: Insegna all'utente una nuova competenza o un concetto usando il workspace corrente come ambiente di apprendimento stateful.
disable-model-invocation: true
argument-hint: "Cosa vuoi imparare?"
---

# Teach

L'utente vuole imparare qualcosa nel corso di più sessioni. Tratta la directory corrente come workspace didattico persistente.

## Workspace didattico

Mantieni lo stato dell'apprendimento in questi file:

- `MISSION.md`: perché l'utente vuole imparare il tema. Usa [MISSION-FORMAT.md](./MISSION-FORMAT.md).
- `reference/*.html`: materiali di riferimento compressi e riutilizzabili.
- `RESOURCES.md`: fonti affidabili e comunità utili. Usa [RESOURCES-FORMAT.md](./RESOURCES-FORMAT.md).
- `learning-records/*.md`: apprendimenti non ovvi e conoscenze pregresse che guidano le sessioni successive. Usa [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md).
- `lessons/*.html`: lezioni brevi e autosufficienti, numerate `0001-<slug>.html`.
- `assets/*`: componenti riutilizzabili condivisi tra le lezioni.
- `NOTES.md`: preferenze didattiche e note operative.

## Filosofia

L'apprendimento profondo richiede:

- **conoscenza**, ricavata da fonti affidabili;
- **abilità**, costruite tramite pratica interattiva e feedback;
- **saggezza**, maturata nel confronto con praticanti e comunità reali.

Non basare le lezioni su conoscenza parametrica quando servono fatti verificabili. Prima popola `RESOURCES.md` con fonti primarie o autorevoli.

Distingui tra:

- **fluency strength**: facilità di richiamo nel momento;
- **storage strength**: ritenzione duratura.

Favorisci retrieval practice, spacing e, quando adatto, interleaving.

## Lezioni

Ogni lezione:

- insegna una sola cosa ben delimitata;
- è breve e completabile rapidamente;
- è legata alla missione;
- rientra nella zona di sviluppo prossimale dell'utente;
- contiene pratica con feedback stretto;
- cita una fonte primaria o autorevole;
- collega lezioni e documenti di riferimento correlati.

Salva ogni lezione in `lessons/NNNN-slug.html`.

Le lezioni devono essere leggibili e riutilizzabili. Prima di aggiungere markup o script duplicati, controlla `assets/` e riusa i componenti esistenti. Il primo asset condiviso dovrebbe essere un foglio di stile comune.

## Missione

Ogni decisione didattica deve derivare da `MISSION.md`.

Se la missione è vaga o assente, chiarisci prima perché l'utente vuole imparare il tema. Una missione concreta descrive un risultato osservabile, non soltanto il desiderio astratto di “capire” qualcosa.

Se la missione cambia, aggiorna `MISSION.md` soltanto dopo conferma dell'utente e registra il cambiamento in un learning record.

## Zona di sviluppo prossimale

Per decidere cosa insegnare dopo:

1. leggi `MISSION.md`;
2. leggi i learning record esistenti;
3. considera ciò che l'utente ha già dimostrato di sapere;
4. scegli il passo più rilevante che sia abbastanza difficile da produrre apprendimento, ma non così difficile da saturare la memoria di lavoro.

## Conoscenza e abilità

Insegna solo la conoscenza necessaria a costruire l'abilità prevista dalla lezione. Poi fai praticare l'utente tramite un feedback loop rapido.

Per quiz e scelte multiple, evita indizi involontari nella lunghezza o formattazione delle risposte.

## Saggezza e comunità

Quando una domanda richiede esperienza reale oltre alla conoscenza teorica, fornisci il miglior orientamento possibile ma suggerisci anche una comunità autorevole, online o locale, dove l'utente possa confrontarsi con praticanti.

Rispetta l'eventuale preferenza dell'utente di non partecipare a comunità.

## Documenti di riferimento

Crea documenti di riferimento quando il contenuto avrà valore oltre la singola lezione: sintassi, algoritmi, procedure, esercizi, glossari o sequenze operative.

Le lezioni sono temporanee; i documenti di riferimento sono la memoria compressa del percorso.

## Provenienza

Adattata da `mattpocock/skills`, path `skills/productivity/teach/SKILL.md`, commit `9603c1cc8118d08bc1b3bf34cf714f62178dea3b`. Adattamenti: lingua italiana e rimozione del suggerimento operativo di aprire automaticamente file tramite CLI; struttura e modello didattico invariati.
