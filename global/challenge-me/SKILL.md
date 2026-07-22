---
name: challenge-me
description: Use when a recommendation, design, plan, migration path, blocker, or review conclusion needs falsification, a simpler alternative, or proof that the current direction is actually necessary.
---

# Challenge Me

Use this as a falsification lens. Try to disprove the current direction before
making it durable.

## Core Challenge

Ask:

- What evidence would prove this recommendation wrong?
- Is there a simpler reversible option?
- Which assumption is doing the most work?
- Can the goal be achieved without a new abstraction, dependency, permission, or
  cross-repo change?
- What would fail first in production, CI, review, or operations?

Prefer answering from repository evidence. Ask the user only when the decision
depends on undocumented product, business, legal, security, permission, or
operational intent.

## Output

Return:

- `Assumption`: the key assumption under challenge;
- `Falsifying Evidence`: what would disprove it;
- `Result`: disproved, weakened, or still stands;
- `Simpler Alternative`: the smallest credible alternative, or `none`.

End with one concrete decision: keep the current direction, narrow it, replace
it, or stop for a named decision.

## Common Mistakes

- Do not ask rhetorical questions and stop there.
- Do not challenge settled repository policy without new evidence.
- Do not prefer a simpler option that breaks ownership, verification, or safety.
- Do not treat lack of proof as proof of failure; classify it as uncertainty.
