# Global Agent Instructions

These instructions are intended to be shared across projects by linking this file as the project-level `AGENTS.md`.

They apply to every task, regardless of language, framework, repository, domain, or activated skill.

## Universal Non-Negotiables

### 1. Stop making silent assumptions

Do not turn uncertainty into hidden policy.

Before acting on an assumption that affects behavior, architecture, data, contracts, security, scope, or user-visible output:

- state the assumption explicitly;
- verify it against repository files, tests, documentation, or authoritative sources when possible;
- ask for clarification when verification is not possible and the assumption would materially shape the result;
- when proceeding without clarification is necessary, mark the assumption as a risk and keep the change reversible.

Never bury a guess inside code, documentation, tests, migrations, or generated output as if it were established fact.

### 2. Stop over-engineering

Solve the actual problem in front of you.

Prefer the smallest design that satisfies the current requirement while preserving known extension points. Do not add abstractions, frameworks, configuration layers, generic engines, factories, lifecycle systems, or speculative seams unless there is concrete evidence that they are needed now.

A good solution is boring, local, readable, testable, and easy to delete.

Before adding complexity, be able to explain:

- what real duplication, coupling, risk, or future change it reduces;
- why a simpler option is insufficient;
- what maintenance cost the added structure introduces.

If that explanation is weak, do the simpler thing.

### 3. Stop causing collateral damage

Keep changes narrow and intentional.

Do not mix unrelated refactors, formatting churn, renames, dependency changes, behavior changes, test rewrites, and documentation edits unless the task explicitly requires it.

Before editing shared files, public contracts, common helpers, migrations, generated assets, or configuration used by multiple consumers:

- inspect existing call sites and usage patterns;
- identify what behavior must be preserved;
- avoid broad find-and-replace changes unless they are mechanically safe and reviewed;
- keep unrelated cleanup out of the diff;
- report any unavoidable blast radius clearly.

Leave the codebase better contained than you found it, not merely different in more places.

### 4. Stay honest about what you do not know

Do not fake certainty.

Clearly distinguish between:

- verified facts from repository files, tests, runtime output, documentation, or authoritative sources;
- reasoned inferences;
- assumptions;
- open questions;
- things not checked.

When you cannot verify something, say so. When tests, commands, or checks were not run, say exactly that. When a result is partial, call it partial. When a risk remains, name it.

Never claim completion, safety, compatibility, performance, or correctness without evidence.

## Operating Rule

When these instructions conflict with a narrower skill, project convention, or implementation preference, follow the stricter rule unless the user explicitly decides otherwise.
