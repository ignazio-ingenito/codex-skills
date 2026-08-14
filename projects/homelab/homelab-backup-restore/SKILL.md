---
name: homelab-backup-restore
description: Use when working on homelab backup, restore, CNPG/Postgres, Barman Cloud Plugin, Ceph RGW, rclone, Google Drive offsite sync, Filestash backup, or recovery drills.
---

# Homelab Backup Restore

Use this skill for backup and recovery work in the homelab repository.

## Canonical Context

Read `doc/18-Backup strategy (Ceph RGW S3 + Google Drive) e Proxmox Backup Server.md` and the current workload-specific runbook before changing backup manifests or running restore drills.

Current model:

- CNPG production clusters store backups in Ceph RGW and use the Barman Cloud Plugin where declared by current manifests;
- offsite copies are mirrored to Google Drive through the existing rclone jobs;
- temporary restore/validation clusters are created only for controlled drills and are not steady-state dependencies;
- `postgres-green` was a migration/validation resource and must not be assumed to exist in current preflight or rollback paths.

## Safety Rules

- Never change a production backup mode without a rollback commit and a verified recovery path.
- Keep backup prefixes separated between source, restore, and temporary drills.
- Do not copy secrets into docs or final answers.
- Treat manual restore clusters as temporary and clean them up when evidence is captured.
- Keep the production writer endpoint under observation during Postgres-related work.

## Preflight

```bash
kubectl -n postgres get cluster postgres
kubectl -n postgres get endpoints postgres-rw
kubectl -n postgres get backups --sort-by=.metadata.creationTimestamp
kubectl -n argocd get application postgres rclone
kubectl -n apps get cronjob rclone-copy-cnpg-rgw-to-gdrive cnpg-backup-healthcheck
```

For another CNPG workload, use its actual namespace, cluster, ArgoCD Application and backup jobs from current GitOps instead of copying the `postgres` names blindly.

GO only if the source cluster is healthy, writer endpoints exist, and the target backup or restore prefix is explicit.

## CNPG And Barman Plugin Checks

```bash
kubectl get crd objectstores.barmancloud.cnpg.io
kubectl -n cnpg-system rollout status deploy/barman-cloud
kubectl -n <namespace> get objectstore
kubectl -n <namespace> get cluster <cluster> -o jsonpath='{range .status.conditions[*]}{.type}{"="}{.status}{" "}{.reason}{"\n"}{end}'
```

Success criteria:

- `Ready=True`;
- `ContinuousArchiving=True` when continuous archiving is expected;
- backup phase is `completed`;
- a restore cluster reaches a healthy state;
- plugin containers are ready when the current plugin contract expects them.

## rclone Checks

Use the current source and destination paths declared by GitOps. For the main Postgres path:

```bash
kubectl -n apps exec deploy/rclone -- rclone lsf rgw:cnpg-backups/postgres --max-depth 4
kubectl -n apps exec deploy/rclone -- rclone lsf GoogleDrive:homelab/backups/postgres --max-depth 4
kubectl -n apps exec deploy/rclone -- rclone check rgw:cnpg-backups/postgres/postgres GoogleDrive:homelab/backups/postgres --one-way --size-only
```

Use `rclone check` evidence before claiming offsite sync is correct.

## Restore Drill Pattern

1. Choose a temporary cluster and unique RGW destination prefix.
2. Restore from the chosen source.
3. Verify pods, endpoints, conditions, logs, and backup catalog.
4. Run a small read-only SQL validation when Postgres is involved.
5. Delete temporary restore clusters and ObjectStores after recording evidence.

For plugin restores to a differently named cluster, set plugin parameter `serverName` to the source cluster name when required by the current Barman contract.

## Stop Conditions

Rollback or stop if:

- the production writer endpoint loses endpoints;
- `ContinuousArchiving=False` appears where archiving is required;
- `wal archive plugin is not available` appears;
- no backup catalog is found where expected;
- manual backup fails and does not recover to `completed`.
