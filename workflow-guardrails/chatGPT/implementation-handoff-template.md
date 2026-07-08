# Implementation Handoff Template

Use this document as the only implementation package passed from ChatGPT to Codex for a specific task.

The handoff transports approved decisions. It does not approve itself. Readiness belongs to the Project Workflow exit criteria.

## Objective

Describe exactly what the implementation agent must deliver.

## Scope

What must be implemented?

Be specific.

## Requirements

List only the requirements needed for this implementation.

Reference requirement IDs when available.

## Design Decisions

Only the design decisions relevant to this implementation.

Do not repeat the full design document.

## Constraints

Implementation constraints.

Examples:

- compatibility
- performance
- security
- coding standards
- dependencies
- repository conventions

## Files / Components

Expected files, modules, packages, or components involved.

If unknown, leave empty rather than guessing.

## Non-goals

Explicitly state what must not be implemented.

Anything not listed in Scope is considered out of scope.

## Acceptance Criteria

Describe observable outcomes that determine completion.

Implementation is complete only when these criteria are satisfied.

## Tests

State expected test work.

Examples:

- add tests for the new behavior
- update affected existing tests
- no test changes expected because...
- do not introduce new testing infrastructure

## Development Artifacts

State any expected development artifacts.

Examples:

- commit message
- PR/MR title
- PR/MR summary
- changelog entry

Use project conventions, including Conventional Commits when required.

## Deferred Items

Ideas intentionally postponed.

They must not be implemented in this handoff.

## Known Risks

Known limitations, assumptions, or unresolved issues that do not block implementation.

## Escalation Triggers

List anything that should cause Codex to stop and return control.

Examples:

- missing requirement
- design conflict
- required architecture change
- scope expansion needed
- product decision needed
