# Placement Instructions

## Keep three stable documents plus one optional bootstrap template

### ChatGPT Project

Place these as project sources / knowledge files:

1. `project-workflow-guardrails.md`
2. `implementation-handoff-template.md`
3. `project-bootstrap-template.md` — optional, only for starting a new project or repository.

ChatGPT uses these to:

- run Discovery, Product Review, Requirements, Design, and review gates
- produce task-specific implementation handoffs
- avoid premature architecture and scope creep

### Codex

Place this as Codex / repository instruction context:

1. `codex-implementation-contract.md`

For each task, also provide the task-specific handoff generated from:

- `implementation-handoff-template.md`

Codex should receive:

- the Codex Implementation Contract
- the specific Implementation Handoff for the current task

Codex should not need the full Project Workflow unless explicitly asked to reason about process.

## Suggested repository placement

For projects that keep these files in the repo, use:

```text
/docs/workflow/project-workflow-guardrails.md
/docs/workflow/implementation-handoff-template.md
/docs/workflow/project-bootstrap-template.md
/docs/codex/codex-implementation-contract.md
```

Task-specific handoffs may live in:

```text
/docs/handoffs/<task-name>.md
```

or be pasted directly into Codex.

## Do not keep

Do not maintain separate documents for:

- Implementation Authorization
- Implementation Readiness
- Codex Execution Guardrails

These were rejected because they duplicate responsibilities or mix workflow state with the handoff payload.

## Responsibility split

| Document | Lives in | Responsibility |
|---|---|---|
| Project Workflow Guardrails | ChatGPT Project | Governs decision process |
| Implementation Handoff Template | ChatGPT Project | Produces implementation payloads |
| Project Bootstrap Template | ChatGPT Project | Initializes new project context before Discovery |
| Codex Implementation Contract | Codex / repo instructions | Governs implementation behavior |
