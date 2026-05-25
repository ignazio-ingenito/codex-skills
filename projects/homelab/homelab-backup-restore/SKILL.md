---
name: homelab-backup-restore
description: Use when working on homelab backup, restore, CNPG/Postgres, Barman Cloud Plugin, Ceph RGW, rclone, Google Drive offsite sync, Filestash backup, or recovery drills.
---

# Homelab Backup Restore

Use this skill for backup and recovery work in the homelab repository.

## Canonical Context

Read `doc/18-Backup strategy (Ceph RGW S3 + Google Drive) e Proxmox Backup Server.md`
before changing backup manifests or running restore drills.

Current model:

- CNPG `postgres` stores backups in Ceph RGW bucket `cnpg-backups`.
- Legacy CNPG backup path is `s3://cnpg-backups/postgres`.
- Offsite copy goes to Google Drive under `homelab/backups/postgres`.
- `postgres-green` is the blue/green Barman Cloud Plugin validation cluster.
- Do not retry direct in-place Barman plugin migration on `postgres`.

## Safety Rules

- Never change `postgres/postgres` backup mode without a rollback commit or a
  verified blue/green path.
- Keep backup prefixes separated between source, green, restore, and temporary
  drills.
- Do not copy secrets into docs or final answers.
- Treat manual restore clusters as temporary and clean them up when evidence is
  captured.
- Keep `postgres-rw` under observation during any Postgres-related work.

## Preflight

```bash
kubectl -n postgres get cluster postgres postgres-green
kubectl -n postgres get endpoints postgres-rw postgres-green-rw
kubectl -n postgres get backups --sort-by=.metadata.creationTimestamp
kubectl -n argocd get application postgres postgres-green rclone
kubectl -n apps get cronjob rclone-copy-cnpg-rgw-to-gdrive cnpg-backup-healthcheck
```

GO only if the source cluster is healthy, writer endpoints exist, and the target
backup or restore prefix is explicit.

## CNPG And Barman Plugin Checks

```bash
kubectl get crd objectstores.barmancloud.cnpg.io
kubectl -n cnpg-system rollout status deploy/barman-cloud
kubectl -n postgres get objectstore
kubectl -n postgres get cluster <cluster> -o jsonpath='{range .status.conditions[*]}{.type}{"="}{.status}{" "}{.reason}{"\n"}{end}'
```

Success criteria:

- `Ready=True`
- `ContinuousArchiving=True`
- backup phase is `completed`
- restore cluster reaches `Cluster in healthy state`
- plugin pods are `2/2` when the plugin sidecar is expected

## rclone Checks

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

For plugin restores to a differently named cluster, set plugin parameter
`serverName` to the source cluster name.

## Stop Conditions

Rollback or stop if:

- `postgres-rw` loses endpoints;
- `ContinuousArchiving=False`;
- `wal archive plugin is not available` appears;
- no backup catalog is found where expected;
- manual backup fails and does not recover to `completed`.
