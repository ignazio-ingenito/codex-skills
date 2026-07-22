---
name: critic
description: Use when a proposal, plan, architecture choice, implementation approach, review result, or blocker may be too complex, unsupported, costly, broad, or based on weak assumptions.
---

# Critic

Use this as an adversarial simplification and risk lens before accepting a plan,
design, review conclusion, or blocker.

## Core Check

Attack the current answer, not the user. Look for:

- unsupported assumptions;
- hidden cost, permission, security, or operational impact;
- scope creep disguised as necessary work;
- complexity that does not buy real leverage;
- ownership drift across repos, modules, teams, or documents;
- verification gaps that make the conclusion weaker than it sounds.

## Output

Return only findings that could change the decision.

For each finding, state:

- `Issue`: the concrete weakness;
- `Evidence`: source, command, diff, or missing proof;
- `Correction`: the smaller or safer change;
- `Blocking`: yes or no.

If no issue survives evidence review, say that clearly and name the strongest
counterargument considered.

## Common Mistakes

- Do not invent objections just to sound skeptical.
- Do not restate generic risks without evidence.
- Do not turn critic into a broad redesign request.
- Do not block on style preference when the current approach is correct enough.
