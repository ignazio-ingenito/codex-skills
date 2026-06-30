---
name: homelab-implementation-planning
description: Use when planning non-trivial homelab implementations, migrations, remediation, blue/green changes, GitOps rollouts, backup changes, infrastructure changes, or multi-step operational work.
---

# Homelab Implementation Planning

Use this skill before executing multi-step homelab work.

## Planning Inputs

Always identify:

- target Application or infrastructure area;
- Git files to change;
- live resources to observe;
- expected ArgoCD sync path;
- rollback path;
- verification commands;
- docs that must change if the behavior or operating model changes.

Use Context7 when planning depends on current Kubernetes, Helm, Argo CD,
operator, SDK, CLI, or service documentation. Do not use it as a substitute for
live cluster evidence, GitOps manifests, runbooks, or repository policy.

Use `grill-with-docs` for non-trivial design choices and `writing-plans` when the work needs a saved task plan.

## Plan Shape

Write plans in small, commit-sized steps:

1. preflight and current-state evidence;
2. Git change;
3. local validation;
4. commit and push;
5. Argo sync or wait;
6. live verification;
7. rollback or cleanup;
8. documentation update;
9. suggested Conventional Commit message.

## Required Sections

Every plan should include:

- **Goal**: exact operational outcome.
- **Scope**: files and Applications involved.
- **Non-goals**: what is intentionally left alone.
- **Risk**: data, availability, credential, and rollback risk.
- **Preflight**: commands that must pass before editing or syncing.
- **Implementation**: ordered changes.
- **Verification**: commands and expected states.
- **Rollback**: Git and cluster steps.
- **Commit Strategy**: one or more Conventional Commit messages.

## Stop Conditions

Stop and ask or reassess if:

- rollback depends on undocumented manual state;
- production Postgres, backup, Cloudflare, or Proxmox changes lack verification;
- the plan mixes unrelated refactor and behavior changes;
- a temporary resource has no cleanup criterion;
- a decision is hard to reverse but no ADR has been considered.
