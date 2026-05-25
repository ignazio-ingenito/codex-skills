---
name: homelab-app-onboarding
description: Use when adding, exposing, or standardizing a new homelab application with Kubernetes manifests, ArgoCD Application, SOPS secrets, CNPG database, HTTPRoute, Cloudflare, Homepage, PVCs, or backups.
---

# Homelab App Onboarding

Use this skill when introducing or normalizing an app under `gitops/apps/`.

## Required Decisions

Before editing, determine:

- namespace and owning ArgoCD Application;
- whether the app needs Postgres, PVCs, object storage, or backups;
- exposure mode: internal only, private Cloudflare tunnel, public Cloudflare tunnel, or LAN-only;
- Homepage visibility and health signal;
- secret source of truth and reflection needs.

## Standard Files

Typical app layout:

```text
gitops/apps/<app>/
  deployment.yaml
  service.yaml
  httproute.yaml
  pvc.yaml
  secrets.enc.yaml
  kustomization.yaml
gitops/apps/applications/<app>.yaml
```

If the app needs Postgres, add database resources under `gitops/apps/postgres/`
and use Reflector annotations on source secrets in namespace `postgres`.

## Rules

- Prefer `HTTPRoute` over `Ingress`.
- Keep Gateway defaulted fields explicit: `parentRefs.group`, `parentRefs.kind`, `backendRefs.group`, `backendRefs.kind`, `backendRefs.weight`.
- Set `revisionHistoryLimit: 0` on Deployments unless there is a documented reason not to.
- Use SOPS for secrets; do not commit plaintext Kubernetes Secret manifests.
- For Cloudflare-exposed apps, update OpenTofu inputs and tunnel routing together.
- Add Homepage annotations to the HTTPRoute when the app should appear on Homepage.

## Verification

```bash
kubectl apply --dry-run=server -k gitops/apps/<app>
kubectl -n argocd get application <app>
kubectl -n <namespace> get deploy,pod,svc,endpoints
kubectl -n <namespace> logs deploy/<app> --tail=100
```

For Cloudflare exposure, also use `homelab-cloudflare-operations`.

## Stop Conditions

Stop and reassess if:

- the app requires a manual live resource that is not represented in Git;
- route, DNS, Access policy, and tunnel ingress do not agree;
- database role or reflected secret ordering is unclear;
- PVC retention or backup ownership is not decided.
