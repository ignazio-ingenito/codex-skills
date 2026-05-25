---
name: homelab-review-and-debt
description: Use when reviewing the homelab repository for technical debt, operational risk, missing verification, GitOps drift, security debt, documentation gaps, or implementation candidates.
---

# Homelab Review And Debt

Use this skill for structured repo review and prioritization.

## Review Axes

Assess each area by risk and reversibility:

- GitOps correctness: Argo Applications, sync policies, waves, stale manual changes.
- Kubernetes quality: probes, resources, securityContext, PVC ownership, service endpoints.
- Secrets: SOPS coverage, Reflector flow, plaintext files, rotation notes.
- Backup/restore: RGW, rclone, offsite copy, restore drills, temporary clusters.
- Observability: dashboards, logs, metrics, alert gaps, runbook freshness.
- IaC: OpenTofu state, tfvars, provider versions, Cloudflare/Proxmox drift.
- Documentation: `doc/`, `CONTEXT.md`, ADR absence, stale TODOs.

## Evidence Collection

Start with:

```bash
git status --short --branch
rg -n "TODO|FIXME|HACK|rollback|manual|temporary|workaround" README.md CONTEXT.md codex-context.md doc gitops infra ansible scripts
git ls-files 'infra/opentofu/**/terraform.tfvars' 'infra/opentofu/**/terraform.tfstate*' 'ansible/secrets/**'
find gitops -name kustomization.yaml -printf '%h\n' | sort
```

Use GitNexus when available and refresh stale indexes before broad conclusions:

```bash
npx gitnexus status
npx gitnexus analyze
npx gitnexus detect-changes
```

## Output Format

Report findings as:

- severity: `Critical`, `High`, `Medium`, `Low`;
- evidence: file path or command output summary;
- why it matters operationally;
- recommended next action;
- whether it is a quick fix, project, or decision.

## Prioritization

Prefer work that:

- removes credential or backup risk;
- improves rollback and verification;
- reduces GitOps drift;
- makes future app onboarding repeatable;
- updates docs only when they reduce future operational ambiguity.
