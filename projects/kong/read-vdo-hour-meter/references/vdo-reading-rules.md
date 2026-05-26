# VDO Hour Meter Reading Rules

## Target Region

The hour meter is the grey-green LCD window embedded in the VDO tachometer. It is
inside the round instrument face, commonly below the `0`/near the `6` area. The
LCD has dark seven-segment digits on a pale background.

Ignore these distractors:

- white tachometer numerals (`0`, `1`, `2`, `3`, `4`, `5`, `6`);
- white tick marks and `RPM x1000` / `VDO` text;
- white aircraft labels or stickers such as `ISP 2059`;
- other instruments visible around the tachometer.

## Decimal Format

The aircraft meter records decimal hours. The final LCD digit is tenths:

- visible `20091` means `2009.1`;
- visible `20122` means `2012.2`;
- visible `20099` means `2009.9`.

Always output one decimal digit with `.` as separator. Never use a comma.

## Confidence

Use high confidence only when every black LCD digit is visible enough to read.
Use low confidence or stop when:

- the first or last digit is cropped;
- glare washes out a digit;
- the tachometer needle or reflection crosses the LCD;
- only a partial segment pattern is visible;
- a surrounding white dial number could be mistaken for an LCD digit.

## Sequence Checks

After reading all images, sort by capture time and pair photos in order:

1. block off;
2. block on.

For each pair:

- block-on reading must be greater than block-off reading;
- duration must be greater than 0 and no more than 4 hours;
- duration in minutes should be close to capture elapsed minutes, allowing about
  6 minutes because the meter advances by tenths.

If a sequence check fails, report the suspected file and ask for confirmation.
