# Istruzioni di Posizionamento

## Mantieni tre documenti stabili più un template opzionale di bootstrap

### ChatGPT Project

Inserisci questi file come documenti di riferimento (knowledge files) del progetto:

1. `project-workflow-guardrails.md`
2. `implementation-handoff-template.md`
3. `project-bootstrap-template.md` — opzionale, da utilizzare solo quando si avvia un nuovo progetto o un nuovo repository.

ChatGPT utilizza questi documenti per:

- eseguire Discovery, Product Review, Requirements, Design e Review Gates;
- produrre gli Implementation Handoff specifici per ogni attività;
- evitare architetture premature e scope creep.

### Codex

Inserisci questo file come contesto di istruzioni di Codex (o come documentazione permanente del repository):

1. `codex-implementation-contract.md`

Per ogni attività, fornisci inoltre l'Implementation Handoff specifico generato a partire da:

- `implementation-handoff-template.md`

Codex dovrebbe ricevere soltanto:

- il Codex Implementation Contract;
- l'Implementation Handoff relativo all'attività corrente.

Codex non dovrebbe avere accesso all'intero Project Workflow, a meno che non gli venga richiesto esplicitamente di ragionare sul processo.

## Posizionamento consigliato nel repository

```text
/docs/workflow/project-workflow-guardrails.md
/docs/workflow/implementation-handoff-template.md
/docs/workflow/project-bootstrap-template.md
/docs/codex/codex-implementation-contract.md
```

Gli Implementation Handoff specifici per ogni attività possono essere salvati in:

```text
/docs/handoffs/<nome-attivita>.md
```

oppure essere incollati direttamente nel prompt di Codex.

## Documenti da NON mantenere

Non creare né mantenere documenti separati per:

- Implementation Authorization
- Implementation Readiness
- Codex Execution Guardrails

Sono stati scartati perché duplicano responsabilità oppure mescolano lo stato del workflow con il contenuto dell'handoff.

## Suddivisione delle responsabilità

| Documento | Dove vive | Responsabilità |
|---|---|---|
| Project Workflow Guardrails | ChatGPT Project | Governa il processo decisionale |
| Implementation Handoff Template | ChatGPT Project | Produce il pacchetto di implementazione |
| Project Bootstrap Template | ChatGPT Project | Inizializza il contesto di un nuovo progetto prima della Discovery |
| Codex Implementation Contract | Codex / istruzioni del repository | Governa il comportamento dell'implementazione |
