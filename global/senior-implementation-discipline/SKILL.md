---
name: senior-implementation-discipline
description: Use when implementing, changing, or refactoring code in an existing codebase, especially when the task touches shared behavior, public contracts, domain logic, persistence, security, architecture, or files with many consumers.
---

# Senior Implementation Discipline

## Purpose

Implement like a maintainer responsible for the next two years of changes, not like an agent trying to finish the current prompt.

The goal is a small, correct, reviewable change that preserves existing contracts, improves locality, and leaves clear verification evidence.

## Use This With

- `systematic-debugging` for unexplained failures.
- `tdd` or `write-tests` for behavior changes.
- `api-and-interface-design` for public contracts.
- `security-and-hardening` for untrusted input, auth, storage, or permissions.
- `code-simplification` when reducing complexity without behavior change.
- `code-review-and-quality` before considering the implementation done.
- `verification-before-completion` before final claims.

## Non-Negotiables

Before editing:

1. Identify the behavior being changed and the behavior being preserved.
2. Identify the owner module: route/controller, application service, domain policy, repository, adapter, UI, or test.
3. Inspect existing patterns before inventing a new one.
4. Check impact for shared symbols, public contracts, and high-consumer files using the project's available code-intelligence tools.
5. When correctness depends on framework, library, SDK, runtime, browser, or external API behavior, verify current official documentation with Context7 when available before coding from memory.
6. State the containment strategy for high-risk edits before changing code.

During editing:

1. Keep the change narrow. Do not mix refactor, behavior change, style cleanup, and migration unless the task explicitly requires it.
2. Keep business/domain rules out of UI components, generic DB clients, auth/session mappers, and transport handlers.
3. Preserve public contracts by default: response shape, status codes, error semantics, DB semantics, permissions, event names, storage paths, and user-visible labels.
4. Add a seam only when it reduces real coupling, improves locality, or gives at least one meaningful second adapter/test surface.
5. Prefer boring code over clever code. Names should carry intent; comments should explain non-obvious decisions only.
6. Prefer behavior tests over implementation-detail tests.
7. Do not hide uncertainty in code. Document open questions or stop for clarification when an assumption would become policy.

Before finishing:

1. Review the diff as if it came from someone else.
2. Verify the smallest relevant command set, broadening for shared or high-risk changes.
3. Update docs, ADRs, plans, or changelogs when behavior, contracts, architecture, or assumptions changed.
4. Report residual risk and verification evidence.

## Decision Checklist

Ask these questions before writing new code:

- **Correct owner:** Is this logic in the deepest responsible module, or am I patching the nearest caller?
- **Contract safety:** What observable behavior could a consumer depend on?
- **Locality:** Will a future change happen in one place, or will this spread knowledge across callers?
- **Leverage:** Does a new helper hide meaningful complexity, or is it a shallow pass-through?
- **Data integrity:** Are persistence, transactions, retention, and audit semantics explicit?
- **Security:** Is any input, file, identity, permission, or external response untrusted?
- **Rollback:** Can this change be reverted locally without data or contract fallout?
- **Tests:** Which test would fail if this behavior regressed?
- **Source freshness:** Did I check Context7 or official docs for any third-party API or pattern whose behavior may have changed?

## Red Flags

Stop and redesign or ask for review when you see:

- A route/controller growing domain rules directly.
- A UI component deciding authoritative permissions or workflow state.
- A generic DB/auth/storage helper gaining domain-specific behavior.
- A response field being renamed, removed, or changing nullability.
- Physical deletion of business data without documented retention semantics.
- A shared helper changed for one caller while many callers depend on it.
- A new abstraction with only one caller and no meaningful complexity hidden.
- A test that only asserts the new implementation shape, not behavior.
- A fix that requires broad unrelated cleanup to look reasonable.
- A framework, library, SDK, runtime, browser, or external API pattern implemented from memory when Context7 or official docs are available.

## Output Discipline

When completing a task, explicitly state:

- What changed.
- What behavior was preserved.
- What contracts were touched or intentionally not touched.
- What tests/checks were run.
- What residual risk remains.
