---
name: homelab-cloudflare-operations
description: Use when working on Cloudflare DNS, Access, Zero Trust, cloudflared tunnel ingress, public hostnames, protected services, or debugging external reachability for this homelab.
---

# Homelab Cloudflare Operations

Use this skill for Cloudflare-facing work in the homelab.

## Canonical Model

- Cloudflare DNS, Access applications, and Zero Trust resources are managed from
  `infra/opentofu/cloudflare-zero-trust/`.
- `cloudflared` workloads and tunnel tokens are managed by GitOps under
  `gitops/infra/cloudflare/`.
- Public URLs may be Cloudflare Access protected; internal integrations should
  prefer Kubernetes service DNS.
- Loki public URL is Access protected; Grafana must use
  `http://monitoring-loki.monitoring.svc:3100`.

## Safety Rules

- Do not expose admin or data services publicly without Access or an explicit
  alternative control.
- Do not change DNS/Access/tunnel rules without checking the matching
  Kubernetes route and service endpoints.
- Do not print tunnel tokens or Cloudflare API credentials.
- Keep OpenTofu state and GitOps manifests conceptually separate.

## Debugging Flow

1. Check Kubernetes service/endpoints first.
2. Check `HTTPRoute` and Gateway status.
3. Check cloudflared pod health and tunnel ingress config.
4. Check Cloudflare DNS record and Access application/policy.
5. Test internal service DNS before testing public URL.

Commands:

```bash
kubectl -n <namespace> get svc,endpoints <service>
kubectl get httproute -A
kubectl -n cloudflare get pods
kubectl -n cloudflare logs deploy/cloudflared --tail=100
```

For IaC-managed resources:

```bash
cd infra/opentofu/cloudflare-zero-trust
tofu plan
```

## Stop Conditions

Stop if:

- Access policy would be removed from a sensitive public hostname;
- public DNS points at a hostname without a matching tunnel ingress rule;
- an app should use internal service DNS but is configured to use a protected
  public URL;
- tunnel token or credentials appear in command output, diffs, or docs.
