---
name: homelab-kubernetes-operations
description: Use when operating, debugging, or changing Kubernetes resources in this homelab, including K3s, namespaces, pods, services, endpoints, CRDs, operators, storage classes, rollouts, logs, and kubectl verification.
---

# Homelab Kubernetes Operations

Use this skill for Kubernetes work in the homelab repository and live cluster.

## Scope

- K3s workloads managed by ArgoCD under `gitops/`.
- Operators and CRDs such as CNPG, Gateway API, cert-manager, MetalLB, and Ceph
  CSI.
- Live debugging with `kubectl` when GitOps state is unclear.

## Safety Rules

- Prefer GitOps manifests for durable changes.
- Use live `kubectl` mutations only for diagnostics, drills, or emergency
  recovery, then reconcile back to Git.
- Check writer endpoints before and after touching databases or storage-backed
  workloads.
- Do not delete PVCs unless the user explicitly asks and backup/restore status
  is verified.
- Treat CRD upgrades as cluster-wide changes.

## Core Checks

```bash
kubectl get nodes -o wide
kubectl get crd
kubectl -n argocd get application
kubectl -n <namespace> get deploy,statefulset,daemonset,cronjob,pod,svc,endpoints,pvc
kubectl -n <namespace> describe pod <pod>
kubectl -n <namespace> logs <pod> --tail=100
```

For rollout verification:

```bash
kubectl -n <namespace> rollout status deploy/<name>
kubectl -n <namespace> get pods -o wide
kubectl -n <namespace> get events --sort-by=.lastTimestamp
```

## Debugging Order

1. Confirm the ArgoCD Application revision and health.
2. Confirm Kubernetes desired resources exist.
3. Check pods, init containers, readiness, restarts, and events.
4. Check services and endpoints before testing ingress.
5. Check logs from the exact pod/container involved.
6. Validate CRD conditions for operator-managed resources.

## Stop Conditions

Stop and reassess if:

- a service endpoint unexpectedly becomes empty;
- a pod is crashlooping after a GitOps sync;
- an operator reports a failing condition;
- a PVC or storage attachment is involved and data ownership is unclear;
- a live fix would diverge from Git without a cleanup plan.
