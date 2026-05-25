---
name: baia-publish
description: Publish Baialupo blog content with the established editorial workflow. Use when the user asks to publish a news item, event, safety notice, NOTAM-related update, flyer/locandina, shortlist candidate, or scouting result for baialupo.com; when adding a post to news/sicurezza/guide/baialupo; or when adding an event card to src/pages/events/events.md.
---

# Baia Publish

## Core Context

Work in `/home/iingenito/projects/personal/baialupo.com` unless the user says otherwise.

Always read `AGENTS.md` before publishing or editing a Baialupo article. Read `CONTEXT.md` when terminology, tone, or category choice is unclear. `AGENTS.md` is authoritative for article format, editorial voice, frontmatter, image handling, emoji, source checking, and validation.

Write in Italian for pilots, VDS/AG users, airfield managers, students, and aviation-light enthusiasts. Keep the tone practical, direct, and operationally cautious.

Tone and language must feel like a Baialupo blog article, not a school summary or an event data sheet. Open with a useful, human angle; make the reader understand why the item is worth their attention; then fold dates, places, contacts, and caveats into the piece naturally. Use headings and bullets for scanability, but avoid turning the article into a list of explained facts unless the content is explicitly a guide, bulletin, or checklist.

For events and raduni, treat flyers, posters, social posts, and organizer blurbs as sources to absorb, not objects to explain. The article body should read like an editorial invitation to the community, almost as if Baialupo or the organizer were inviting pilots to take part. Avoid repeated source-framing such as "la locandina indica", "secondo il post", "il flyer riporta", or "la fonte dice" in the main narrative; reserve source provenance for the final sources section or for a real operational caveat.

## Decision Tree

- If the user provides a locandina/image: extract title, date, location, organizer, program, contacts, and any operational caveats from the image; use it as the article cover and, for events, as the event card image.
- If the user asks for the next item from a shortlist: choose the most relevant candidate for VDS/AG, raduni, aviosuperfici, safety, NOTAM, or light aircraft operations; verify unstable facts online.
- If the item is a raduno/event/fly-in: publish a `news` post and add it to `src/pages/events/events.md` unless the user explicitly says not to. For raduni, always try to recover the official locandina before drafting or publishing.
- If the item is safety, maintenance, airspace, NOTAM, ENAC/ENAV/AeCI/ANSV/ROTAX/Lycoming: usually publish under `sicurezza`.
- If the item is reusable evergreen advice: use `guide`, unless there is a timely news hook.

## Publishing Workflow

1. Check `EDITORIAL_BACKLOG.md` when scouting, planning, or looking for new candidates. If it contains open items, evaluate those before proposing unrelated content, and update or clear the item when the user approves publication.
2. Inspect existing posts and assets with `rg`/`rg --files` to avoid duplicate slugs and image names.
3. Verify dates, location, official source, and operational details. Browse for unstable facts or when the source is not already available locally.
4. Choose category and filename:
   `src/content/posts/<category>/YYYY-MM-DD-slug.md`
5. Use today's editorial publication date for `created` and `updated` on new articles unless the user explicitly asks for another metadata date. Do not use a future event date as `created` or `updated`; keep event dates in the title, body, filename when appropriate, and event card.
6. Use frontmatter with `featured: 1` for new articles unless the user explicitly asks otherwise.
7. Add a cover:
   - first reuse a fitting local image from `public/img/covers/` or `public/img/stories/`;
   - if the user provides a locandina, copy it to `public/img/stories/` with a descriptive filename;
   - for raduni and events, search first for the official locandina/flyer from the organizer, aeroclub, aviosuperficie, event page, or social announcement;
   - if no suitable image exists, search for a usable official image or generate an original cover.
8. Insert the cover in the article body immediately after the intro/practical info block:
   `[![Alt text](/web/img/stories/name.jpg)](/web/img/stories/name.jpg)`
9. Use emoji in section headings/practical blocks when helpful: `📍`, `📅`, `✈️`, `🛩️`, `📌`, `🛠`, `🧑‍✈️`, `🎟️`, `🔗`.
10. Cite sources at the end. Do not copy long external text; summarize and link.
11. Run the editorial naturalness pass below before validation.
12. Run `pnpm check`; run `pnpm build` for new posts, events, image changes, or anything affecting generated pages.

## Article Pattern

For `news` events, include:

- opening paragraph with what, when, where, organizer, and why it matters;
- cover image in body;
- `## 📅 Quando e dove`;
- `## ✈️ Perché interessa...`;
- `## 📌 Arrivo in volo` or practical checks when relevant;
- `## 🔗 Fonti e aggiornamenti`.

For event articles, prefer a warm but concise blog voice: describe the atmosphere, the reason a pilot or enthusiast might care, and the practical value of the trip. Keep operational caution precise, but do not let it dominate the whole article unless safety or procedures are the main news.

Use careful language for operational information:

- say "verificare", "conviene controllare", "non sostituisce NOTAM/briefing/istruzioni ufficiali";
- distinguish flyer/social-post information from official operational planning data in your fact-checking and sources section, without turning the article body into a commentary about the flyer;
- include PPR/PNR, frequency, circuit, parking, NOTAM, weather, airspace, and organizer contact checks when relevant.

## Editorial Naturalness Pass

Before final validation, revise the article so it sounds like a Baialupo post
written by a knowledgeable human editor, not like generic AI copy.

Remove or rewrite:

- formulaic AI structure, repeated paragraph shapes, and tidy generic endings;
- inflated significance language such as "momento cruciale", "evento imperdibile",
  "scenario unico", or other promotional filler unless it is a direct source
  claim worth quoting;
- repeated source framing in the main body, such as "la locandina indica",
  "secondo il post", "il flyer riporta", when the information can be folded
  naturally into the article;
- generic conclusions that do not add practical value to pilots, VDS/AG readers,
  airfield managers, students, or aviation-light enthusiasts.

Preserve:

- verified dates, places, contacts, prices, program details, and source links;
- operational caveats about PPR/PNR, frequencies, circuits, parking, NOTAM,
  weather, airspace, and organizer instructions;
- the cautious Baialupo voice: practical, direct, warm, and operationally precise;
- source provenance in the final sources section or when a caveat genuinely
  depends on the type of source.

Use the global `humanize-writing` skill as a general editing lens when the draft
sounds robotic, but Baialupo editorial rules and aviation safety language take
priority over generic humanization.

## Event Card Workflow

When adding an event:

1. Update `src/pages/events/events.md`.
2. Add one YAML item:
   ```yaml
   - link: "/web/news/<public-slug>"
     image: "/web/img/stories/<image>.jpg"
     title: "YYYY-MM-DD"
   ```
3. Use the first day of a multi-day event for `title`.
4. Use only the local event locandina/flyer as the `image` in `events.md`. Do not use generic covers, scenic photos, generated covers, logos, or unrelated article images for event cards.
5. If the event is a raduno and no locandina is available locally, search for it before creating the event card. If no locandina can be found, ask the user for confirmation before publishing the event without an event card.
6. The article cover should also prefer the locandina for raduni/events unless there is a clear reason to use a separate official image in the article.
7. Verify `/events/` in the build output or with a direct grep for the slug/image.

## File And Image Conventions

- Article filenames start with the source/event date: `YYYY-MM-DD-...md`.
- Public slugs omit the date prefix automatically.
- Image filenames should be descriptive and sequential when the repo pattern suggests it, e.g. `2026-266-avioraduno-centenario-aeroclub-milano.jpg`.
- Use public paths with `/web/img/...` in frontmatter and Markdown.
- Avoid remote images in final articles when a local copy can be added.

## Validation

Minimum:

```bash
pnpm check
```

For new articles/events/images:

```bash
pnpm build
```

After build, confirm the generated route contains the expected slug and image, for example:

```bash
rg -n "<slug>|<image-file>" dist/news/<slug>/index.html dist/events/index.html
```

Report what was created, the public route, and validation results. Mention if a fact could not be verified or if the article relies only on a locandina supplied by the user.
