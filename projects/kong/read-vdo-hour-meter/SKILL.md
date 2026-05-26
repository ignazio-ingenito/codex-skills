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
   and notes for unclear cases.
7. Sanity-check the sequence: readings should be non-decreasing; block-on minus
   block-off should be positive, at most 4 hours, and close to photo elapsed time
   when photos are paired.
8. If every value is clear, write `readings.yml` in the image folder unless the
   user asked for a different output path. If any value is unclear, stop and ask
   for human confirmation instead of guessing.

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
  covered by the needle, mark the photo as ambiguous and ask the user.

## Output Contract

Final app-ready YAML must contain only valid readings:

```yaml
readings:
  BF3AF73B-EE90-4E35-A895-7A5C92C27B42.JPG: 2008.2
  D404D516-8F3C-4A61-B9C3-6A7FD8E9756E.JPG: 2009.1
```

Do not put `UNREADABLE`, comments, notes, confidence values, or alternate
candidates inside final `readings.yml`; Kong expects decimal values matching
`^\d+\.\d$`.

When unresolved values remain, report a review table instead:

```text
filename.JPG  unclear  leftmost LCD digit cut off
```

Then ask the user to provide or confirm the missing values.

## Common Mistakes

- Reading the white `5` or `6` printed on the dial as part of the LCD value.
- Reading the white aircraft/sticker label, such as `ISP 2059`, instead of the
  LCD hour meter.
- Treating a dim decimal dot as missing and returning an integer. Always output
  decimal hours with one tenth digit.
- Correcting a value only because the duration would be nicer. Use timing as a
  sanity check, not as permission to invent digits.
