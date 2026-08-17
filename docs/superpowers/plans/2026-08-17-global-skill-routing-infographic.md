# Global Skill Routing Infographic Implementation Plan

**Stato:** Archived  
**Data:** 2026-08-17

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a precise global-skill routing infographic to the README and align the canonical router and inventory with the repository's actual global skills.

**Architecture:** Keep detailed routing in `global/ask-skills/SKILL.md`, expose a concise visual orientation layer through one deterministic SVG, and keep the README limited to embedding, reading guidance, and the complete inventory. Update all three together so no source becomes stale at commit time.

**Tech Stack:** Markdown, SVG 1.1-compatible markup, Bash/Python validation already present in the repository, GitHub Contents/Git Data APIs.

## Global Constraints

- Follow active RFC-0001.
- Show only skills under `global/` in the infographic.
- Keep project-specific routes out of the global visual.
- Use Conventional Commits in English.
- Do not manually rerun GitHub Actions.
- Do not introduce a new validation framework or dependency.

---

### Task 1: Align the canonical `ask-skills` router

**Files:**
- Modify: `global/ask-skills/SKILL.md`

**Interfaces:**
- Consumes: trigger and sequencing rules from the global `SKILL.md` files.
- Produces: canonical routing prose referenced by README and infographic.

- [ ] **Step 1: Capture the routing failures before editing**

Check the current file for the required relationships:

```text
interview-me before idea-refine when core intent is unclear
brainstorming after intent is clear and before implementation
code-debt-review-loop for assessment
research + domain-modeling + codebase-design for migrations
```

Expected before the change: at least the explicit `brainstorming` handoff and assessment/migration routes are missing or incomplete.

- [ ] **Step 2: Rewrite the main flow and maintenance routes**

Preserve existing installation guidance and provenance. Update only routing sections so they distinguish intent extraction, idea exploration, design, multi-session decomposition, prototype branches, assessment, simplification, architecture work, and migrations.

- [ ] **Step 3: Validate the skill document**

Verify frontmatter remains valid, the directory name matches `name: ask-skills`, and every referenced skill exists under `global/`.

### Task 2: Create the deterministic infographic

**Files:**
- Create: `docs/assets/global-skill-routing.svg`

**Interfaces:**
- Consumes: the routes defined in the approved design and aligned `ask-skills`.
- Produces: a README-safe SVG with exact skill names and accessible textual labels.

- [ ] **Step 1: Build the SVG**

Use a dark neutral canvas, high-contrast scenario cards, solid pills for normal steps, dashed pills for conditional steps, and a shared delivery rail. Include the eight primary scenarios and six additional operational scenarios from the design.

- [ ] **Step 2: Inspect the rendered SVG**

Render or open the local SVG and check clipping, overlaps, text accuracy, arrow order, and legibility at README width.

- [ ] **Step 3: Validate global-only names**

Extract backticked or pill skill labels from the SVG and confirm every label maps to a directory under `global/`. Confirm no `projects/` skill appears.

### Task 3: Update README and repair inventory drift

**Files:**
- Modify: `README.md`

**Interfaces:**
- Consumes: `docs/assets/global-skill-routing.svg` and the canonical skill directories.
- Produces: public orientation section and complete inventory.

- [ ] **Step 1: Add the routing section before the inventory**

Embed the SVG with useful alternative text, explain solid versus dashed steps, distinguish prototype from production MVP, and link to `global/ask-skills/SKILL.md` for detailed routing.

- [ ] **Step 2: Add missing inventory rows**

Add:
- global `code-debt-review-loop`;
- global `scrittura-comica`;
- CAP Aeris `grill-with-screenshots`.

Do not add project-specific skills to the global infographic.

- [ ] **Step 3: Compare inventory and canonical directories**

Verify every `*/SKILL.md` directory has a corresponding README inventory row and that README contains no nonexistent skill.

### Task 4: Validate and publish the change

**Files:**
- Verify: `README.md`
- Verify: `global/ask-skills/SKILL.md`
- Verify: `docs/assets/global-skill-routing.svg`
- Verify: `docs/superpowers/specs/2026-08-17-global-skill-routing-infographic-design.md`

**Interfaces:**
- Consumes: completed branch content.
- Produces: a draft pull request against `main`.

- [ ] **Step 1: Run structural checks**

Use direct source inspection plus the repository's existing validation workflow. Confirm XML parses, frontmatter parses, inventory is complete, references exist, and the approved scenario list is present.

- [ ] **Step 2: Review the full diff against the design**

Reject unrelated edits, duplicated operational prose, project-specific content in the SVG, and any route contradicting a global skill.

- [ ] **Step 3: Open a draft pull request**

Target `main`, summarize the reality-check findings and fixes, and let the normal pull-request validation workflow run once. Do not manually rerun it.
