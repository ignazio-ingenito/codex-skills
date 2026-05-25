---
name: homelab-gateway-routes
description: Use when adding, changing, debugging, or reviewing exposed homelab services that use Kubernetes Gateway API, Traefik, HTTPRoute, Cloudflare DNS, Cloudflare Access, or cloudflared tunnel ingress.
---

# Homelab Gateway Routes

Use this skill for ingress and exposure work in the homelab repository.

## Canonical Model

- The active ingress model is Kubernetes Gateway API with Traefik.
- The shared Gateway is `kube-system/traefik-gateway`.
- The Gateway is programmed on `10.10.20.240`.
- Prefer `HTTPRoute` over `Ingress` for new exposed services.
- Cloudflare DNS, Access, and tunnel rules live under
  `infra/opentofu/cloudflare-zero-trust/` and `gitops/infra/cloudflare/`.
- Grafana talks to Loki through
  `http://monitoring-loki.monitoring.svc:3100`, not through the protected
  public Loki URL.

## HTTPRoute Requirements

Keep defaulted Gateway API fields explicit in Git to avoid Argo drift:

```yaml
parentRefs:
  - group: gateway.networking.k8s.io
    kind: Gateway
    name: traefik-gateway
    namespace: kube-system
backendRefs:
  - group: ""
    kind: Service
    name: service-name
    port: 80
    weight: 1
```

Check hostnames, `sectionName`, service port, namespace, and route ownership
before syncing.

## Preflight

```bash
kubectl -n kube-system get gateway traefik-gateway
kubectl get httproute -A
kubectl -n <namespace> get svc,endpoints <service>
kubectl -n argocd get application <app>
```

For Cloudflare-backed routes, also inspect the OpenTofu and cloudflared
manifests before assuming DNS or Access behavior.

## Debugging Flow

1. Confirm the service has endpoints.
2. Confirm the `HTTPRoute` is accepted and resolved.
3. Confirm the Gateway listener matches the hostname/protocol.
4. Confirm Cloudflare DNS/tunnel routes match the hostname.
5. Confirm Cloudflare Access policy is expected.
6. Test internal service URL before public URL when possible.

Useful commands:

```bash
kubectl describe httproute -n <namespace> <name>
kubectl -n kube-system describe gateway traefik-gateway
kubectl -n <namespace> get endpoints <service>
kubectl -n <namespace> logs deploy/<app> --tail=100
```

## Stop Conditions

Stop before syncing if:

- the route would expose an admin UI without Access or another explicit control;
- service endpoints are empty;
- Cloudflare and Gateway hostnames disagree;
- Argo drift is caused only by omitted Gateway API defaults;
- a public URL is protected by Access but an internal integration should use the
  service DNS name.
