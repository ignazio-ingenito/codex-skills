---
name: homelab-observability-operations
description: Use when changing, debugging, or reviewing homelab observability with Grafana, Loki, Prometheus, Alloy, dashboards, alerting, ServiceMonitors, log labels, or metrics ingestion.
---

# Homelab Observability Operations

Use this skill for monitoring and logging work in `/home/iingenito/projects/personal/homelab`.

## Canonical Files

- `doc/15-Monitoring (Prometheus + Grafana + Loki + Tempo) via Helm + ArgoCD.md`
- `gitops/infra/monitoring/`
- `gitops/infra/monitoring/values/kube-prom-stack-values.yaml`
- `gitops/infra/monitoring/values/loki-values.yaml`
- `gitops/infra/monitoring/alloy.yaml`
- `gitops/infra/monitoring/app-routes/`

## Rules

- Grafana must use Loki through `http://monitoring-loki.monitoring.svc:3100`.
- Do not configure Grafana to use `https://loki.skunklabs.uk`; it is Cloudflare Access protected.
- Keep Alloy Kubernetes labels `namespace`, `pod`, `container`, and `node` in `discovery.relabel` before `loki.source.kubernetes`.
- After Alloy ConfigMap changes, verify pods reload the new config or restart the DaemonSet.
- Treat dashboards as GitOps resources; avoid manual-only Grafana changes unless they are being explored before codifying.

## Preflight

```bash
kubectl -n argocd get application kube-prometheus-stack loki
kubectl -n monitoring get pods,svc,servicemonitor,podmonitor
kubectl -n monitoring get daemonset alloy
kubectl -n monitoring logs daemonset/alloy --tail=100
```

## Verification

For Grafana/Loki work:

```bash
kubectl -n monitoring get svc monitoring-loki
kubectl -n monitoring logs deploy/monitoring-grafana --tail=100
kubectl -n monitoring logs daemonset/alloy --tail=100
```

For Prometheus scrape work:

```bash
kubectl -n monitoring get servicemonitor,podmonitor
kubectl -n monitoring logs statefulset/prometheus-kube-prometheus-stack-prometheus --tail=100
```

## Stop Conditions

Stop and reassess if:

- dashboard queries return empty data after label changes;
- Alloy runs but Loki lacks `namespace`;
- Prometheus targets disappear after a values change;
- Argo reports chart value or CRD validation errors;
- monitoring changes require live-only edits to keep visibility working.
