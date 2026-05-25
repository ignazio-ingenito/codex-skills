---
name: homelab-secret-management
description: Use when creating, rotating, reviewing, or debugging homelab secrets with SOPS, Age, Reflector, ArgoCD repository secrets, tunnel tokens, database credentials, OAuth tokens, or plaintext leak checks.
---

# Homelab Secret Management

Use this skill for secret lifecycle work in the homelab repo and cluster.

## Canonical Files

- `.sops.yaml`
- `doc/14-GitOps Baseline.md`
- `doc/21-Flusso operativo quotidiano (GitOps).md`
- `gitops/**/**/*.enc.yaml`
- `gitops/infra/reflector/`
- `ansible/secrets/`

## Rules

- Never print secret values in final answers.
- New Kubernetes `Secret` manifests in GitOps must be SOPS-encrypted.
- Bootstrap secrets intentionally outside GitOps include `argocd/sops-age` and ArgoCD repo credentials; document them, do not casually import them.
- DB user secrets live in namespace `postgres` and are reflected into app namespaces when needed.
- Token rotation must include both Git state and live rollout/sync verification.
- Treat tracked plaintext secret files as security debt unless there is a documented reason.

## Checks

Plaintext and encryption checks:

```bash
git ls-files '*secret*.yaml' '*secrets*.yaml' '*.enc.yaml' '*.enc.yml'
git diff --cached --name-only
```

SOPS validation:

```bash
sops -d <path-to-secret.enc.yaml> >/dev/null
```

Reflector check:

```bash
kubectl -n postgres get secret <secret> -o yaml
kubectl -n <app-namespace> get secret <secret>
kubectl -n postgres annotate secret <secret> reflector-force="$(date +%s)" --overwrite
```

## Stop Conditions

Stop and reassess if:

- a plaintext secret is staged;
- SOPS decrypt fails for a changed secret;
- an app depends on a reflected secret before the source secret exists;
- rotating a token requires changing an external provider but no rollback is possible;
- logs or docs contain credential material.
