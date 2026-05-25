---
name: homelab-ceph-storage-operations
description: Use when changing, debugging, or reviewing homelab Ceph, Ceph CSI, RGW, RBD StorageClasses, PVCs, S3 buckets, object storage credentials, or storage-related backup paths.
---

# Homelab Ceph Storage Operations

Use this skill for Ceph, RGW, CSI, PVC, and storage lifecycle work.

## Canonical Files

- `doc/08-Installazione e configurazione Ceph.md`
- `doc/09-Integrazione Ceph RBD in Proxmox.md`
- `doc/13-Integrazione Ceph CSI (Storage).md`
- `doc/23-Ceph RGW (S3 locale) - Esposizione via MetalLB.md`
- `gitops/infra/ceph-csi/`
- `gitops/infra/ceph-rgw-internal/`
- `ansible/playbooks/21-ceph-csi.yml`
- `ansible/playbooks/23-ceph-rgw.yml`
- `ansible/playbooks/24-ceph-rgw-users.yml`

## Rules

- Do not manually alter Ceph OSD disks outside documented recovery work.
- Keep Kubernetes persistent storage on the intended Ceph RBD StorageClass.
- Keep RGW S3 credentials out of plain text docs and final answers.
- Treat bucket prefixes as contracts for backup and restore workflows.
- Verify both Kubernetes PVC state and storage backend state before claiming storage work is complete.

## Preflight

```bash
kubectl get storageclass
kubectl get pv,pvc -A
kubectl -n ceph-csi get pods
kubectl -n infra get svc ceph-rgw-internal 2>/dev/null || true
```

When touching RGW-backed backups, also use `homelab-backup-restore`.

## Verification

For CSI changes:

```bash
kubectl -n ceph-csi get pods
kubectl get storageclass
kubectl get events -A --sort-by=.lastTimestamp | tail -50
```

For RGW paths:

```bash
kubectl -n apps exec deploy/rclone -- rclone lsf rgw:cnpg-backups --max-depth 3
```

## Stop Conditions

Stop and reassess if:

- PVCs are pending after a StorageClass or CSI change;
- `VolumeAttachment` or mount errors appear;
- RGW listing fails from the in-cluster rclone workload;
- a backup prefix would be reused by test and production workflows;
- a plain credential file appears in tracked Git changes.
