---
name: homelab-proxmox-operations
description: Use when planning, documenting, or debugging Proxmox, PBS, Ceph, VM/LXC, node, storage, or backup operations in this homelab.
---

# Homelab Proxmox Operations

Use this skill for Proxmox, PBS, Ceph, VM/LXC, and node-level work.

## Canonical Docs

Read the relevant runbook before acting:

- `doc/03-Installazione Proxmox sui nodi.md`
- `doc/04-Configurazione rete Proxmox.md`
- `doc/07-Creazione cluster Proxmox.md`
- `doc/08-Installazione e configurazione Ceph.md`
- `doc/09-Integrazione Ceph RBD in Proxmox.md`
- `doc/10-Creazione VM per K3s.md`
- `doc/20-Proxmox Backup Server (PBS) - Best practices e offsite con rclone.md`

## Safety Rules

- Do not suggest destructive storage, Ceph, VM, or cluster commands without a
  rollback path and confirmed target node/resource.
- Treat quorum, Ceph health, and PBS restore capability as preflight checks.
- Prefer read-only diagnostics before remediation.
- Do not change Proxmox networking remotely without a console/rollback path.
- Do not delete VM disks, Ceph pools, or PBS snapshots unless explicitly asked.

## Read-Only Preflight

Use available Proxmox tooling when the user can run it or when SSH access is
configured:

```bash
pvecm status
pvesm status
qm list
pct list
ceph status
ceph osd tree
```

For PBS/offsite:

```bash
proxmox-backup-manager datastore list
```

## Operational Checks

- Cluster quorum healthy.
- Ceph health is `HEALTH_OK` or known warnings are explained.
- Storage has enough free space.
- Target VM/LXC ID and node are unambiguous.
- A recent backup exists before destructive maintenance.
- K3s VM dependencies are understood before rebooting nodes.

## Stop Conditions

Stop if:

- quorum is degraded;
- Ceph health is unknown or unhealthy;
- the target VM/LXC/disk cannot be uniquely identified;
- networking changes could lock out management access;
- backup or restore evidence is missing for a destructive action.
