---
name: homelab-gitops-operations
description: Use when changing, syncing, or debugging this homelab GitOps repository with ArgoCD, SOPS plugin Applications, Kustomize manifests, Kubernetes resources, or cluster rollout checks.
---

# Homelab GitOps Operations

Use this skill for operational work in `/home/iingenito/projects/personal/homelab`
that changes GitOps manifests or coordinates ArgoCD syncs.

## Operating Model

- Treat Git as the source of truth for durable changes.
- Prefer adding or changing manifests under `gitops/` instead of applying live
  resources by hand.
- Use manual `kubectl apply` only for temporary drills, emergency recovery, or
  creating an ArgoCD `Application` before app-of-apps catches up.
- Keep `postgres`, `apps`, `infra`, and backup-related Applications observable
  during every sync.
- Do not hide Argo drift by changing live resources without a follow-up GitOps
  patch or documented cleanup.

## Standard Workflow

1. Read `AGENTS.md` and the relevant `doc/*.md` runbook before editing.
2. Inspect the target Application and manifests:

   ```bash
   kubectl -n argocd get application <app>
   kubectl -n argocd get application <app> -o yaml
   kubectl apply --dry-run=server -k <manifest-dir>
   ```

3. For SOPS-managed Applications, remember that direct `kubectl apply -k` may
   fail on encrypted secrets. Validate changed non-secret manifests individually
   when needed.
4. Commit and push GitOps changes before relying on Argo for reconciliation.
5. Hard-refresh the affected Application when Argo is stale:

   ```bash
   kubectl -n argocd annotate application <app> argocd.argoproj.io/refresh=hard --overwrite
   ```

6. Watch Argo and live resources until the outcome is clear.

## ArgoCD Checks

Use these commands as a minimum evidence set:

```bash
kubectl -n argocd get application <app>
kubectl -n argocd get application <app> -o jsonpath='{.status.sync.status}{"\n"}{.status.health.status}{"\n"}{.status.operationState.phase}{"\n"}{.status.operationState.message}{"\n"}'
kubectl -n argocd get application <app> -o jsonpath='{.status.sync.revision}{"\n"}'
```

If Argo is stuck on an old operation, use the documented stale-sync runbook
before forcing further changes.

## Kubernetes Verification

For each changed workload, verify:

- desired resources exist;
- pods are ready;
- services/endpoints are present;
- logs do not show fresh fatal errors;
- owner Application is `Synced/Healthy`.

Examples:

```bash
kubectl -n <namespace> get deploy,statefulset,cronjob,pod,svc
kubectl -n <namespace> get endpoints <service>
kubectl -n <namespace> logs deploy/<name> --tail=100
```

## Stop Conditions

Stop and reassess if:

- a write service loses all endpoints;
- Argo is syncing an older revision than expected;
- an Application remains `Progressing` without resource-level progress;
- a CRD validation error appears after a push;
- a manual live change is required to keep the service alive.

Record surprising outcomes in the relevant `doc/*.md` runbook.
