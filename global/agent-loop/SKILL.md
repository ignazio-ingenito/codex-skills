---
name: agent-loop
description: Use when an approved repository mission or bounded implementation task has enough authoritative context to proceed without routine operator decisions.
---

# Agent Loop

Every task follows this sequence:

1. **Explorer**: read-only analysis, inventory, risk, and proposed scope.
2. **Main agent**: accepts or reduces scope and defines allowed files, forbidden files, verification, and stop conditions.
3. **Worker**: performs one atomic change.
4. **Reviewer**: independently checks the task's applicable invariants and verification evidence.
5. **Main agent**: updates the applicable authoritative tracker, if present, and leaves a durable handoff.

Parallel explorers are allowed for independent read-only work. Writers remain serial when touching shared state, overlapping files, or shared contracts.

After three failed loops or evidence of a wrong direction, stop and return to the last read-only checkpoint with a narrower prompt.
