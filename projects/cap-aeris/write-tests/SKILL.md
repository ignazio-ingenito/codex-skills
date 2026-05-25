---
name: write-tests
description: Use this skill when adding or updating tests.
---

# Write Tests

Use this skill when adding or updating tests.

## Read First

- `AGENTS.md`
- relevant files in `docs/cap/`
- relevant syntheses in `docs/wiki/`
- existing tests in the repository

## Steps

1. Identify expected behavior from documentation.
2. Locate existing test patterns.
3. Keep test names, helper functions, fixtures, and comments in English.
4. Add tests close to the affected code.
5. Cover the happy path.
6. Cover important validation or failure cases.
7. For CAP practices, cover workflow transition gates, required document checks, role/action permissions, and negative paths.
8. For forms/modules, cover template identity, revision/effective-date metadata, and generated artifact behavior.
9. For documents, cover ownership, metadata, revision/immutability expectations, and critical upload/delete/update behavior.
10. Avoid brittle implementation-specific tests.
11. Run the test suite or the relevant subset.

## Definition of Done

- Tests reflect documented behavior.
- Regression cases are covered where relevant.
- Tests are readable and maintainable.
- Critical API and domain policy behavior is tested at the appropriate layer.
- Final response states which tests were run.
