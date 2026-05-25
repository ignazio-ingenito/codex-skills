---
name: homelab-opentofu-terraform
description: Use when changing, reviewing, planning, or applying Terraform/OpenTofu infrastructure in this homelab, especially Cloudflare Zero Trust, DNS, Access applications, tunnels, and provider-managed state.
---

# Homelab OpenTofu Terraform

Use this skill for Terraform/OpenTofu work in the homelab repository.

## Canonical Areas

- Cloudflare DNS, Access applications, and Zero Trust configuration live under
  `infra/opentofu/cloudflare-zero-trust/`.
- Kubernetes cloudflared workloads and tunnel tokens are managed separately by
  GitOps under `gitops/infra/cloudflare/`.

## Safety Rules

- Run `tofu plan` before any apply.
- Do not apply if the plan includes unexpected deletes or replacement of Access,
  DNS, tunnels, or authentication resources.
- Do not print provider tokens, tunnel secrets, or sensitive state values.
- Keep Terraform/OpenTofu changes separate from Kubernetes manifest changes
  unless the dependency is explicit.
- Prefer exact resource targeting only for incident recovery, not normal drift
  management.

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

4. Compare planned changes against GitOps/cloudflared manifests when tunnels or
   hostnames are involved.
5. Apply only after the plan is understood and approved.

## Cloudflare Cross-Checks

For exposed services, verify all of these line up:

- DNS hostname;
- Cloudflare Access application/policy;
- tunnel ingress rule;
- Kubernetes `HTTPRoute`;
- service endpoints.

## Stop Conditions

Stop before apply if:

- a plan deletes or replaces Access policies unexpectedly;
- DNS records move to a different target without a matching tunnel/Gateway
  change;
- Terraform state appears stale or locked unexpectedly;
- a secret value would be committed or printed;
- Kubernetes routing and Cloudflare routing disagree.
