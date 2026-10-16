# V2D Challenge current plan: Track 1 only

Updated: 2026-10-16, Vancouver time

## Assumptions

- Pursue **Track 1: 4D human and object reconstruction**.
- Assume **no GPU access / GPU token / GPU credits** for the main path.
- Do **not** pursue Track 2 or Track 3 unless this assumption changes.
- Treat the old Track 3/FlashCHORD plan as historical setup context only.

## Why the plan changed

The Oct 7 plan was about downloading the kit/dataset and testing Track 3/FlashCHORD. That is outdated.

Already done:

- Submission kit downloaded and unpacked.
- Full Hugging Face dataset pulled locally.
- Submission-kit Python environment created.
- NVIDIA `video_to_data` runtime cloned at the kit-pinned commit.
- Public GitHub repo created: https://github.com/furqazaheervi6/v2d-challenge
- Local Track 1 preflight passes when Kaggle checks are skipped.

Current blockers:

- Kaggle API token and Track 1 rule acceptance are not confirmed.
- No actual Track 1 reconstruction outputs exist yet.
- A valid Track 1 submission needs packable per-episode `.npz` files plus object mesh files.

Official deadline:

- Leaderboard freeze: **2026-11-04 at 5:00 PM EST**, which is **2:00 PM Vancouver time**.
- On 2026-10-16, there are 19 calendar days left.

## Track 1 requirements

Track 1 submits **one Parquet file** to five metric competitions:

- CD-H
- CD-O
- ACC-H
- ACC-O
- PEN

The submission kit expects a directory like:

```text
track1_episodes/
  episode_000000.npz
  episode_000000_object.glb
  episode_000001.npz
  episode_000001_object.glb
  ...
```

Each `episode_XXXXXX.npz` must contain:

```text
pose                 [T, 136]
scales               [68]
shape                [45]
object_rotation      [T, 3, 3]
object_translation   [T, 3]
object_scale         scalar > 0
```

The object mesh can be `.glb`, `.obj`, `.ply`, `.stl`, or `.off`.

Packing command:

```bash
cd v2d-challenge/submission-kit/v2d_submission_kit
COMMIT_URL="https://github.com/furqazaheervi6/v2d-challenge/commit/<sha>"
../../.venv/bin/python eval_reconstruction.py \
  --episodes /path/to/track1_episodes \
  --sample data/track_1_sample_submission.parquet \
  --commit "$COMMIT_URL" \
  --out track1.parquet
```

Upload command, after Kaggle is configured and rules are accepted:

```bash
../../.venv/bin/python submit/v2d_submit.py track1.parquet \
  --track track_1 \
  -m "Track 1 reconstruction" \
  --wait
```

## Strategy

Goal:

> Get one honest, reproducible Track 1 submission, even if weak, then improve exactly one thing.

Do not chase Track 3 or full FlashCHORD. Do not split tracks. Do not spend time on a cloud GPU path unless it directly helps Track 1 reconstruction.

### Practical target

1. **First valid submission:** produce packable Track 1 outputs for all scored episodes.
2. **One improvement lane:** choose one of smoothing, object pose stability, object mesh quality, or MHR pose plausibility.
3. **Technical report:** document method, limitations, commands, and exact commit URL.

## Updated schedule

### Oct 16, Thu, today

Goal: remove account and schema uncertainty.

- Confirm/create Kaggle account.
- Generate Kaggle API token.
- Accept rules for all five Track 1 metric competitions.
- Run preflight without `--skip-kaggle`.
- Inspect Track 1 sample rows and scored episode list.
- Create `track1_episodes/` working folder outside Git.

Exit condition:

- Kaggle works locally, and the exact required episodes are listed.

### Oct 17-18

Goal: format-valid baseline artifact.

- Write a generator that creates complete Track 1 `.npz` files and non-degenerate object meshes for all required episodes.
- Use neutral/constant poses only as a format baseline, not as a claimed reconstruction.
- Pack with `eval_reconstruction.py`.
- Fix every local validation/packing error.

Exit condition:

- `track1.parquet` is produced locally from code in the GitHub repo.

### Oct 19-20

Goal: first Kaggle submission.

- Commit the generator code.
- Use the real GitHub `/commit/<sha>` URL in the packed file.
- Upload to Track 1.
- Save receipt, score/status, and any failure message in `submissions.md`.

Exit condition:

- One Track 1 Kaggle submission is accepted, or the exact rejection reason is logged.

### Oct 21-25

Goal: replace dummy/neutral parts with the smallest real reconstruction improvement.

Pick **one** improvement lane:

- extract object motion from video with a simple CV/pose proxy,
- smooth object translation/rotation,
- improve object mesh from primitive to closer geometry,
- improve MHR pose plausibility,
- reduce hand-object penetration.

Do not start a full reconstruction architecture. The aim is one bounded improvement over the first artifact.

Exit condition:

- Improved `track1.parquet` packed and submitted, or blocker documented.

### Oct 26-30

Goal: iterate once, not endlessly.

- Compare leaderboard metrics.
- Improve only the weakest metric if the feedback is clear.
- Update technical report.
- Keep submissions within weekly cap.

Exit condition:

- Best current artifact identified.

### Oct 31-Nov 3

Goal: final polish.

- Use unlimited final-three-days submissions for controlled variants only.
- Freeze the best submission.
- Finish technical report.
- Ensure README explains exactly what was attempted and what is not claimed.

### Nov 4 before 2 PM Vancouver

Goal: final submission.

- Submit final Track 1 artifact.
- Save receipt and score/status.
- Update GitHub repo and local notes.

## Immediate next commands

### Track 1 preflight, with Kaggle skipped

```bash
cd v2d-challenge/submission-kit/v2d_submission_kit
../../.venv/bin/python tools/preflight.py \
  --track track_1 \
  --dataset-root ../../datasets/video_to_data_challenge \
  --skip-kaggle
```

### Track 1 preflight, after Kaggle token/rules

```bash
cd v2d-challenge/submission-kit/v2d_submission_kit
../../.venv/bin/python tools/preflight.py \
  --track track_1 \
  --dataset-root ../../datasets/video_to_data_challenge
```

## What not to do

- Do not spend time on Track 3 unless GPU access suddenly appears.
- Do not use Colab as the main plan.
- Do not claim “reconstruction solved” if the first artifact uses neutral or placeholder geometry.
- Do not upload secrets or Kaggle token to GitHub.
- Do not submit random changes in the final unlimited window.

## Source files checked locally

- `v2d-challenge/submission-kit/v2d_submission_kit/tracks/track_1/README.md`
- `v2d-challenge/submission-kit/v2d_submission_kit/tools/pack_reconstruction.py`
- `v2d-challenge/submission-kit/v2d_submission_kit/eval_reconstruction.py`
- `v2d-challenge/submission-kit/v2d_submission_kit/data/track_1_sample_submission.parquet`
