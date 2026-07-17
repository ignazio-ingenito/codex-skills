---
name: grill-with-screenshots
description: >-
  Reviews real application screenshots to assess UX, UI, responsiveness,
  accessibility risks, and product-task alignment without redesigning or
  modifying code.
---

# GRILL_WITH_SCREENSHOTS

## Purpose

Use this skill to perform a UX/UI assessment from real application screenshots.

This skill is intended for workflows where an application already exists, screenshots have been generated through Playwright or an equivalent browser automation tool, and the next step is to evaluate the product experience before planning any UI refactor.

The goal is assessment only.

Do not modify code.
Do not redesign.
Do not implement UI changes.
Do not change product behavior.

---

## When To Use

Use this skill when you need to review:

- an existing web application
- a completed product milestone
- a UI before a refactor
- a dashboard, admin panel or internal tool
- responsive behavior across desktop, tablet and mobile
- the gap between product intent and actual visible interface

Typical trigger phrases:

- `grill-with-screenshots`
- `review these screenshots`
- `assess this UI from screenshots`
- `run UX/UI visual assessment`
- `evaluate the Playwright visual inventory`

---

## Inputs

Expected inputs:

- screenshot files
- `inventory.md`
- `gaps.md`
- optional `grill-with-docs` report
- optional product documentation
- optional UX/product brief

Typical paths:

```text
artifacts/ux-ui-inventory/inventory.md
artifacts/ux-ui-inventory/gaps.md
artifacts/ux-ui-inventory/screenshots/**/*.png
docs/analysis/grill-with-docs-*.md
```

---

## Core Questions

For each screenshot, answer:

1. What does the user see first?
2. What should the user see first?
3. What is the primary task of this screen?
4. Is the primary task visually dominant?
5. Are secondary actions clearly separated from primary actions?
6. Is the information hierarchy clear?
7. Is the screen too dense?
8. Are there responsive issues?
9. Are there overflow or table readability issues?
10. Are there inconsistent components, spacing, colors or labels?

---

## Assessment Dimensions

Evaluate:

- information architecture
- task-first UX
- visual hierarchy
- cognitive load
- navigation clarity
- form usability
- table usability
- drawer usability
- sheet usability
- empty states
- loading states
- error states
- responsive desktop/tablet/mobile
- accessibility risks
- consistency with the design system
- candidate screens for Figma redesign

---

## Severity Scale

Use this severity scale:

### Critical

Blocks task completion or creates operational risk.

### High

Core workflow is confusing, slow or error-prone.

### Medium

Creates friction, inconsistency or avoidable cognitive load.

### Low

Polish issue.

---

## Output File

Create a markdown report, usually under the same artifact folder:

```text
artifacts/ux-ui-inventory/grill-with-screenshots.md
```

If the project uses another artifact convention, follow the project convention.

---

## Output Structure

The report must use this structure:

```markdown
# Grill With Screenshots - UX/UI Assessment

## Executive Summary

## Scope

## Inputs Reviewed

## Overall Findings

## Information Architecture Findings

## UX Findings

## UI Findings

## Responsive Findings

## Accessibility Risks

## Screen-by-Screen Review

### [Screen Name] - Desktop

- First thing the user sees:
- What should be seen first:
- Primary task:
- UX issues:
- UI issues:
- Responsive notes:
- Accessibility notes:
- Severity:
- Quick wins:
- Refactor candidates:

### [Screen Name] - Tablet

...

### [Screen Name] - Mobile

...

## Top 10 UX/UI Problems

## Top 10 Quick Wins

## Candidate Screens for Figma

## Candidate Refactor Streams

## Gaps

## Questions for Product Owner

## Recommended Next Step
```

---

## Rules

- Do not propose implementation before the assessment is complete.
- Do not invent missing screens.
- If screenshots are missing, mark them as gaps.
- If drawer, sheet, empty, loading or error states are not captured, mark them as gaps.
- Prefer evidence from screenshots over assumptions from code.
- Use `grill-with-docs` only as supporting context, not as visual evidence.
- Be explicit when a finding is inferred.
- Separate UX issues from UI issues.
- Separate information architecture issues from visual design issues.
- Do not confuse code complexity with UX complexity unless both are visible in the screenshots.
- Do not recommend a redesign just because a screen is visually dense.
- Always identify the operator's primary task before judging the screen.

---

## Review Method

For each screen:

1. Identify the user role or likely operator.
2. Identify the primary task.
3. Identify the first visible element that attracts attention.
4. Compare visible priority with task priority.
5. Evaluate whether the screen answers: `What do I need to do now?`
6. Check whether secondary information is visually separated.
7. Check whether actions are grouped by intent.
8. Check desktop/tablet/mobile differences.
9. Mark gaps where screenshots do not provide enough evidence.
10. Recommend assessment-level next steps, not implementation.

---

## CAP-AERIS Focus

When used on CAP-AERIS, focus especially on:

- dashboard operational value
- dashboard informational value
- P07 detail page
- task-first workflow
- document requirements visibility
- blockers visibility
- next action visibility
- socio detail page
- velivolo detail page
- tables on tablet/mobile
- sidebar navigation
- drawer/sheet workflows
- empty/loading/error state coverage

---

## Anti-Patterns

Avoid these mistakes:

- turning the assessment into a redesign
- proposing component extraction before identifying UX problems
- judging only visual beauty
- treating screenshots as complete evidence when key states are missing
- ignoring mobile/tablet because the app is desktop-first
- recommending Figma for every screen
- mixing quick wins with structural refactor
- hiding uncertainty

---

## Recommended Follow-Up

After this skill produces the assessment, continue with:

1. `challenge` to test whether the findings are actually worth acting on
2. `plan` to turn accepted findings into phased work
3. `handoff` to create a Codex implementation brief
4. Figma only for selected screens where visual redesign is justified

---

## Final Principle

The goal is not a prettier UI.

The goal is determining whether the interface helps the operator answer:

```text
What do I need to do now?
```
