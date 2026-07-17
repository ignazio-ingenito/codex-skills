# Formato dei learning record

I learning record vivono in `learning-records/` e usano numerazione sequenziale: `0001-slug.md`, `0002-slug.md`, ecc. Crea la directory solo quando serve il primo record.

Sono l'equivalente didattico degli ADR: registrano apprendimenti non ovvi, conoscenze pregresse e correzioni che influenzano le sessioni successive.

## Template

```md
# {Titolo breve dell'apprendimento}

{1-3 frasi su ciò che è stato realmente appreso o stabilito e perché cambia ciò che va insegnato dopo.}
```

## Regole

- Scrivi un record solo quando esiste evidenza di comprensione, non per semplice esposizione.
- Registra conoscenze pregresse dichiarate dall'utente, indicando il livello quando rilevante.
- Registra le misconcezioni corrette.
- Registra i cambi di missione e collega `MISSION.md`.
- Non usarli come diario delle attività.
- Non duplicare definizioni già raccolte in un glossario.
- Per numerare, trova il numero più alto esistente e incrementalo.
- Se un record successivo corregge il precedente, marca il vecchio come `Status: superseded by LR-NNNN` invece di eliminarlo.

Se utili, aggiungi soltanto le sezioni opzionali `Evidence` e `Implications`.
