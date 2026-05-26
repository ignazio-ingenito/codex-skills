---
name: read-vdo-hour-meter
description: Use when the user asks Codex to inspect Kong aircraft hour-meter photos in a local folder, read the VDO tachometer LCD display, transcribe decimal-hour values, or create/update a readings.yml file.
---

# Read VDO Hour Meter

## Overview

Use this skill to inspect a folder of aircraft hour-meter photos and produce a
Kong-compatible manual readings file. The task is visual extraction: read the
black LCD digits on the VDO tachometer and map each source filename to a
decimal-hour value.

## Workflow

1. Confirm the input folder exists. If the user did not give a folder, ask for it.
2. List image files only. Prefer `rg --files <folder>`; include `.jpg`, `.jpeg`,
   `.png`, `.heic`, and `.webp` case-insensitively.
3. Sort photos by EXIF capture time when available; otherwise sort by filename.
   In Kong, EXIF can be checked with `kong.adapters.exif.read_exif_photo_metadata`.
4. Open each image with `view_image` using the absolute path and `detail="original"`
   when precision matters.
5. Read only the LCD display. Ignore all white dial text, white dial numerals,
   aircraft labels, stickers, and instrument labels.
6. Build a proposed table: filename, capture time if known, reading, confidence,
   and notes for unclear cases. Use `????` as the reading placeholder for values
   that are not clear enough to trust.
7. Sanity-check the sequence: readings should be non-decreasing; block-on minus
   block-off should be positive, at most 4 hours, and close to photo elapsed time
   when photos are paired.
8. Write `readings.yml` in the image folder unless the user asked for a different
   output path. Put decimal readings for clear values and the quoted placeholder
   `'????'` for unclear values. Do not guess.
9. If `readings.yml` contains any `????` placeholders, stop. Tell the user to
   complete the YAML file before continuing, list the filenames that still need a
   value, and suggest the continuation command:
   `uv run kong drive-dry-run --env-file .env.development --review --readings-file <path-to-readings.yml> --append-sheet --create-gmail-draft`.
10. If `readings.yml` contains no placeholders, run the command above to continue
     the workflow and prepare the Gmail draft, unless the user explicitly asked not
     to run downstream writes. Do not add `--complete-run` for draft preparation;
     that option also archives Drive photos and requires Drive write scopes.

## Visual Reading Rules

Read [references/vdo-reading-rules.md](references/vdo-reading-rules.md) before
extracting values from real photos.

Essential rules:

- The target display is the small grey-green rectangular LCD inside the VDO
  tachometer, usually near the lower-left/lower portion of the round gauge.
- LCD digits are black seven-segment digits. Surrounding VDO/RPM labels and dial
  numbers are white and must be ignored.
- The last LCD digit is always tenths of an hour. Output exactly one decimal
  digit, such as `2009.1`.
- If the decimal dot is not visible but the LCD digits are otherwise clear and
  contiguous, place the decimal point before the final digit.
- Do not copy extra white digits from the dial into the reading.
- Do not invent hidden digits. If a digit is cropped, blocked by glare, or
  covered by the needle, put `????` in `readings.yml` for that file.

## Output Contract

Working YAML may contain placeholders for values that need human completion:

```yaml
readings:
  BF3AF73B-EE90-4E35-A895-7A5C92C27B42.JPG: 2008.2
  D404D516-8F3C-4A61-B9C3-6A7FD8E9756E.JPG: '????'
```

Final app-ready YAML must contain only valid readings before Kong is run:

```yaml
readings:
  BF3AF73B-EE90-4E35-A895-7A5C92C27B42.JPG: 2008.2
  D404D516-8F3C-4A61-B9C3-6A7FD8E9756E.JPG: 2009.1
```

Do not put `UNREADABLE`, comments, notes, confidence values, or alternate
candidates inside `readings.yml`. Use only decimal values matching `^\d+\.\d$`
or the temporary placeholder `'????'`.

When unresolved values remain, report them after writing the YAML:

```text
filename.JPG  unclear  leftmost LCD digit cut off
```

Then stop and tell the user to replace every `????` before running Kong. Suggest:

```bash
uv run kong drive-dry-run --env-file .env.development --review --readings-file photo/YYYY-MM-DD/readings.yml --append-sheet --create-gmail-draft
```

Add `--complete-run` only when the user explicitly wants Drive archive/state
completion and the Google token has Drive write scopes.

## Common Mistakes

- Reading the white `5` or `6` printed on the dial as part of the LCD value.
- Reading the white aircraft/sticker label, such as `ISP 2059`, instead of the
  LCD hour meter.
- Treating a dim decimal dot as missing and returning an integer. Always output
  decimal hours with one tenth digit.
- Correcting a value only because the duration would be nicer. Use timing as a
  sanity check, not as permission to invent digits.
