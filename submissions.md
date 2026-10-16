# V2D submissions log

## Track 1 target

First accepted submission target: format-valid Track 1 Parquet generated from repo code, then one bounded improvement.

## Submissions

| Date | Track | Commit URL | Artifact | Kaggle receipt | Score/status | Lesson |
|---|---|---|---|---|---|---|
| 2026-10-16 | Track 1, format baseline | https://github.com/furqazaheervi6/v2d-challenge/commit/6b7ca5e5403c4962c0c283eebf4d90898deae1c1 | `v2d-challenge/generated/track1_format_baseline.parquet` | Local receipts: `track1_format_baseline_receipt.json`, `track1_format_baseline_receipt_missing.json` | CD-H `73.64771` (#57263664); CD-O `169.91766` (#57263785); ACC-H `0.14528` (#57263813); ACC-O `0.07429` (#57263859); PEN `0.00000` (#57263863) | Pipeline is end-to-end functional. This was a deterministic placeholder/format baseline, not a real reconstruction. Next work should replace neutral MHR/object placeholders with real Track 1 reconstruction logic. |

Notes:

- The first uploader run accepted CD-H, CD-O, and ACC-H, then was interrupted while ACC-O was uploading.
- A second uploader run submitted only the missing `acc_o_cm` and `interpenetration_cm` metrics to avoid duplicate submissions.
- All five metric leaderboards accepted and scored the Track 1 format baseline.
