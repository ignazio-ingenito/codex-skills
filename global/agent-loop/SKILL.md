---
name: agent-loop
description: Use when an approved repository mission or bounded implementation task has enough authoritative context to proceed without routine operator decisions.
---

# Agent Loop

`agent-loop` controls the complete approved mission or bounded task. A loop is
an internal recovery unit, not a handoff boundary to the operator.

Every loop follows this sequence:

1. **Explorer**: read-only analysis, inventory, risk, evidence, and proposed scope.
2. **Main agent**: accepts or reduces scope and defines allowed files, forbidden files, verification, rollback, and real stop conditions.
3. **Worker**: performs one atomic change or discriminating technical experiment.
4. **Reviewer**: independently checks the applicable invariants and verification evidence.
5. **Main agent**: consumes the verdict, reconciles the checkpoint, and decides the next internal action.

Parallel explorers are allowed for independent read-only work. Writers remain
serial when touching shared state, overlapping files, or shared contracts.
Explorer, Worker, and Reviewer completion is a join barrier: the Main agent must
consume their output and continue in the same assignment.

## Autonomous continuation

For `REVISE`, `REJECT`, a disproved hypothesis, or a local technical failure,
the Main agent must preserve useful evidence, roll back failed experiments,
return to the last read-only checkpoint, narrow the internal prompt, and start
the next loop without asking the operator to choose commands, tools, runtimes,
mounts, libraries, downloads, cleanup, or the next hypothesis.

After three failed loops on the same direction, stop that direction—not the
mission. Return internally to the last read-only checkpoint, reduce the
problem boundary, and continue the same assignment when another local,
reversible, already-authorized path exists. Do not create a new repository
assignment, generation, issue, branch, or pull request merely to change a
technical hypothesis or prerequisite.

A missing command, tool, library, browser, process, container, runtime, cache,
mount, network path, temporary space, or expired lease is not by itself a
mission stop. Resolve it within the task using the simplest local and reversible
path already authorized by the repository sources.

## Return control only for terminal outcomes

Return control to the operator only when the task is complete or a real stop
condition applies, such as:

- an undocumented product or architecture decision with materially different alternatives;
- scope expansion or a durable consequence not already authorized;
- production access, secrets, permission changes, or a paid external action;
- an intentional deviation from an active authoritative source or accepted ADR;
- an authoritative or concurrent-writer conflict that cannot be reconciled safely;
- a mandatory verification that remains impossible after reasonable local and user-space remediation paths have been exhausted.

A terminal blocker must state the observed fact, the exhausted paths, and the
specific external decision, authorization, permission, or resource required.
Do not report intermediate progress, individual subagent results, or ordinary
technical failures as top-level completion.

At terminal completion, the Main agent updates the applicable authoritative
tracker, if present, and leaves the durable handoff required by the repository.
