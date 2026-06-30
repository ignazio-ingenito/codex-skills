---
name: code-debt-review-loop
description: >-
  Review a repository with Context7 and CodeGraphContext to identify technical
  debt, deprecated patterns, architectural hotspots, dead code, coupling, and
  safe refactoring plans. Use when asked for codebase review, debt reduction,
  migration planning, or controlled implementation with tests.
---

# Code Debt Review Loop

## Purpose

Use this skill to turn requests like "review this repo", "find technical debt", "what should we refactor", or "can we remove old code" into an evidence-driven review and a safe execution plan.

Keep it practical: find the real hotspots, rank them, plan small improvements, and only implement after the user approves the plan.

## Default Rules

- Start read-only.
- Separate analysis from implementation.
- Prefer small, reversible changes.
- Use CodeGraphContext for repository structure and relationships.
- Use Context7 for current framework and library documentation.
- Tie recommendations to repository evidence, official docs, tests, or clear engineering risk.
- Never claim completion without verification output.
- Do not remove code based on a single signal.

## Tools

Use these when available:

- CodeGraphContext: indexed repositories, complexity, dependencies, callers, callees, dead code, coupling, and graph queries.
- Context7: current official documentation for frameworks, SDKs, libraries, migrations, and deprecations.
- Local inspection: `git`, `rg`, package metadata, test runner, lint/typecheck commands.

If CodeGraphContext is not indexed and agent indexing is blocked, ask the user to run:

```bash
cd <repo-root>
cgc index .
cgc list
cgc report
```

Then continue using read-only graph queries.

## Activation Signals

Use this skill when the user asks to:

- review a codebase for technical debt;
- find deprecated APIs or obsolete patterns;
- plan refactoring work;
- identify dead code or safe removals;
- replace an old module, dependency, workflow, or tool;
- reduce complexity or coupling;
- create a risk-controlled implementation plan;
- execute a debt-reduction task with tests.

## Analysis Output

For analysis-only requests, return:

```markdown
## Code Debt Review

### Scope
- Repository/path reviewed:
- Tools used:
- Limitations:

### Executive Summary
- Top risks:
- Quick wins:
- Do not touch yet:

### Findings
| Priority | Area | Evidence | Risk | Suggested action | Verification |
|---|---|---|---|---|---|

### Recommended Plan
1. Smallest safe step
2. Next safe step
3. Larger refactor only after tests/coverage

### Removal Candidates
| Candidate | Evidence for removal | Remaining uncertainty | Safe removal plan |
|---|---|---|---|

### Verification Plan
- Static checks:
- Unit/integration tests:
- Browser/manual checks:
- Rollback notes:
```

## Execution Output

For implementation requests, produce a plan first unless the user already approved execution:

```markdown
## Execution Plan

### Goal

### Non-goals

### Safety Rails
- No behavior changes without tests.
- No deletion without graph + grep + test evidence.
- Keep commits small and reviewable.

### Agent Loop
1. Baseline checks
2. Add or adjust tests
3. Make the smallest change
4. Run focused tests
5. Run broader checks
6. Review the diff
7. Repeat or stop

### Stop Conditions
- Tests fail for unexplained reasons.
- Graph evidence contradicts local search/runtime evidence.
- Business behavior is ambiguous.
- Removal candidate has dynamic references.
```

## Workflow

### 1. Baseline

Start with:

```bash
pwd
git status --short
```

Identify the package manager and test commands from the repository. Respect the existing toolchain.

### 2. Graph Availability

Ask:

```text
Use CodeGraphContext to list indexed repositories. Do not index anything.
```

If needed, ask the user to index locally with `cgc index .`.

### 3. Core Review Passes

Run these passes internally and combine the results.

#### A. Hotspot Review

```text
Use CodeGraphContext.
Find architectural hotspots in this repository.
Consider cyclomatic complexity, fan-in, fan-out, dependency chains, and business criticality inferred from paths/docs.
Rank the top 10 files or functions that should be improved.
Do not suggest stylistic changes. Do not modify code.
```

#### B. Change Risk Analysis

```text
Use CodeGraphContext.
If I modify <target>, show everything that depends on it, everything it depends on, possible regression points, files that should be tested, and whether the graph might undercount framework-discovered usage.
Do not modify code.
```

#### C. Dead Code Review

```text
Use CodeGraphContext.
Find code that is probably dead. Explain why.
Cross-check with local search for dynamic references, route conventions, config references, and string-based usages.
Do not delete anything.
```

#### D. Coupling Review

```text
Use CodeGraphContext.
Find modules that are too tightly coupled.
Suggest where boundaries could be improved.
Prioritize improvements that reduce risk or make tests easier.
Do not rewrite code.
```

#### E. Architecture / Data Flow Review

```text
Use CodeGraphContext.
Explain the architecture of this project.
Start from the entry points and describe how data flows through the system.
Identify the modules a new developer or agent must understand first.
Do not modify code.
```

#### F. Current Docs / Deprecation Review

```text
Use CodeGraphContext to understand the implementation.
Then use Context7 to compare it with the latest official documentation for the relevant frameworks and libraries.
Only report improvements supported by official documentation.
Ignore stylistic opinions.
Identify deprecated APIs, obsolete patterns, newer alternatives, migration risks, and tests needed before migration.
Do not modify code.
```

## Extra Review Passes

### Dependency Hygiene

```text
Review dependencies and identify unused packages, duplicated capability already covered by the stack, packages that should not be upgraded casually, and packages likely involved in deprecations or migrations.
Use Context7 where current documentation matters.
Do not modify package files.
```

### Test Surface Review

```text
Use CodeGraphContext and local test files.
Map top-risk modules to existing tests.
Identify hotspots with weak coverage and the safest first tests to add before refactoring.
Do not modify code.
```

### Removal Readiness Review

```text
Use CodeGraphContext and local search.
For each proposed removal candidate, produce graph evidence, grep evidence, dynamic usage risks, config/route/build references, tests that should fail if it is still used, and rollback notes.
Do not delete anything yet.
```

### Migration Slice Planning

```text
Use CodeGraphContext and Context7.
Turn the migration/refactor into small reviewable slices.
For each slice include purpose, likely files touched, expected behavior change, tests to add or run, rollback strategy, and why this slice is safe before the next one.
```

## Risk Model

Classify findings:

| Risk | Meaning | Typical action |
|---|---|---|
| Critical | Data loss, broken auth, destructive migration risk, or severe production breakage | Stop and isolate first |
| High | Shared business logic, high fan-in, complex untested module | Add tests and refactor in small slices |
| Medium | Local complexity or moderate coupling | Schedule small refactor when touching area |
| Low | Cleanup, comments, isolated duplication | Bundle only with nearby work or delete if proven safe |

Use priority as `Impact x Confidence x Ease`, not just complexity.

High complexity with no callers can still matter in file-routed frameworks, where usage is discovered by convention rather than normal call edges.

## Implementation Loop

When implementation is approved:

1. Record baseline with `git status --short`.
2. Identify existing dirty files and do not overwrite them.
3. Run the smallest relevant existing check.
4. Add characterization tests where feasible.
5. Make the smallest behavior-preserving change.
6. Run focused verification.
7. Run broader checks only after focused checks pass.
8. Review `git diff --stat` and the relevant file diffs.
9. Stop if risk increases or behavior is ambiguous.

Use actual project commands. Examples only:

```bash
pnpm test -- <specific-test>
pnpm lint
pnpm typecheck
pnpm test
pnpm exec playwright test <target>
```

## Removal Rules

Do not remove code based on one signal.

Require multiple signals such as:

- CodeGraph reports no callers/references;
- `rg` finds no usage beyond definitions/tests/docs;
- package/build config has no reference;
- route/framework convention check confirms it is not discovered dynamically;
- focused tests still pass after removal.

Before deletion, state:

```markdown
Removal candidate: <name>
Evidence:
- Graph:
- Search:
- Config/routes:
- Tests:
Remaining uncertainty:
Safe rollback:
```

If uncertainty is meaningful, ask first.

## Final Checklist

Before finishing:

- [ ] Scope is explicit.
- [ ] CodeGraph or local structural evidence was used.
- [ ] Context7 was used for current docs where relevant.
- [ ] Findings are ranked by risk and confidence.
- [ ] Removal candidates include evidence and uncertainty.
- [ ] Implementation plan is sliced into reversible steps.
- [ ] Tests/checks are named.
- [ ] Existing dirty files are reported and protected.
- [ ] Final answer includes files changed, tests run, and remaining risks.

## User-Facing Prompts

### Full Review

```text
Use the code-debt-review-loop skill.
Review this repository for technical debt and modernization opportunities.
Use CodeGraphContext for structure and Context7 for current framework docs.
Do not modify code.
```

### Hotspot Plan

```text
Use the code-debt-review-loop skill.
Analyze <file-or-function> as a refactoring candidate.
Show dependencies, callers, tests needed, safe slices, and stop conditions.
Do not modify code.
```

### Safe Removal

```text
Use the code-debt-review-loop skill.
Evaluate whether <module/function/dependency> can be removed safely.
Use graph evidence, grep evidence, config/route checks, and tests.
Do not delete anything yet.
```

### Execute One Slice

```text
Use the code-debt-review-loop skill.
Execute the first safe slice of the approved refactoring plan using the agent loop.
Protect existing user changes, add or update tests first, run focused verification, and stop if risk increases.
```
