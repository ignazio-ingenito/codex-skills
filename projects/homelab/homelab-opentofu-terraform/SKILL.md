---
name: homelab-opentofu-terraform
description: Use when changing, reviewing, planning, or applying Terraform/OpenTofu infrastructure in this homelab, especially Cloudflare Zero Trust, Harbor internal configuration, DNS, Access applications, tunnels, and provider-managed state.
---

# Homelab OpenTofu Terraform

Use this skill for Terraform/OpenTofu work in the homelab repository.

## Canonical Areas

- Cloudflare DNS, Access applications, and Zero Trust configuration live under
  `infra/opentofu/cloudflare-zero-trust/`.
- Harbor internal configuration owned by OpenTofu lives under
  `infra/opentofu/harbor/` and includes steady-state project/proxy-cache,
  retention, immutability, scan scheduling, GC and related provider-managed
  resources.
- Kubernetes workloads for Cloudflare and Harbor are managed separately by
  GitOps under `gitops/infra/`.

## Safety Rules

- Run `tofu plan` before any apply.
- Do not apply if the plan includes unexpected deletes or replacements of
  Access, DNS, tunnels, Harbor projects, registry configuration, retention,
  immutability or authentication resources.
- Do not print provider tokens, Harbor credentials, tunnel secrets, or sensitive state values.
- Keep Terraform/OpenTofu changes separate from Kubernetes manifest changes unless the dependency is explicit.
- Prefer exact resource targeting only for incident recovery, not normal drift management.

## Workflow

1. Read the relevant README/docs and current `.tf` files.
2. Check formatting and validation:

   ```bash
   tofu fmt -check -recursive
   tofu validate
   ```

3. Run a plan and inspect resource actions:

   ```bash
   tofu plan
   ```

4. For Cloudflare changes, compare the plan with GitOps routing and exposed services.
5. For Harbor changes, compare the plan with `doc/27-Harbor registry mirror.md`, `doc/24-Trivy remediation backlog.md` and current Harbor GitOps values; do not reintroduce the retired REST reconciler ownership.
6. Apply only after the plan is understood and approved.

## Cross-Checks

For exposed services, verify DNS hostname, Access policy, tunnel ingress, Kubernetes `HTTPRoute` and service endpoints agree.

For Harbor, verify that OpenTofu remains the owner of internal configuration while ArgoCD/GitOps remains the owner of the Harbor workload itself.

## Stop Conditions

Stop before apply if:

- a plan deletes or replaces Access policies or Harbor resources unexpectedly;
- DNS records move to a different target without a matching tunnel/Gateway change;
- Harbor provider state disagrees with the documented steady-state ownership;
- Terraform state appears stale or locked unexpectedly;
- a secret value would be committed or printed;
- Kubernetes routing and Cloudflare routing disagree.
