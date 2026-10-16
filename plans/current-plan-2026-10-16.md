# V2D Challenge current plan

Updated: 2026-10-16, Vancouver time

## What changed since the old plan

The previous plan is outdated. It assumed the first work was downloading, watching the kickoff, and trying the baseline locally or in Colab. That is no longer the right framing.

Already done:

- Submission kit downloaded and unpacked.
- Full Hugging Face dataset pulled locally.
- Submission-kit Python environment created.
- NVIDIA `video_to_data` runtime cloned at the kit-pinned commit.
- Track 3 local preflight ran with Kaggle checks skipped.
- Public GitHub repo created: https://github.com/furqazaheervi6/v2d-challenge

Current blockers:

- Kaggle API token and competition rule acceptance are not confirmed.
- No working NVIDIA GPU environment is confirmed.
- Local Mac cannot run the official full baseline because it has no `docker` and no `nvidia-smi`.
- Colab should no longer be treated as the default plan. Official docs expect Linux, Docker, NVIDIA Container Toolkit, Git LFS, and a large NVIDIA GPU for FlashCHORD/full training.

Official deadline:

- Leaderboard freeze: 2026-11-04 at 5:00 PM EST, which is 2:00 PM Vancouver time on 2026-11-04.
- Today, 2026-10-16, leaves 19 calendar days.

## Current strategic decision

The goal is no longer “explore V2D.” The goal is:

> Get one honest, reproducible, valid V2D submission or, if compute prevents that, a public technical reproduction/report that clearly documents setup, blockers, and a bounded attempted baseline.

Recommended route:

1. **Primary route for signal:** Track 3 only if a 48 GB NVIDIA GPU environment is secured within 24 hours.
2. **Fallback route for feasibility:** Track 1 if Track 3 compute is not available quickly.
3. **Do not split effort across tracks** unless a first valid submission already exists.

Why:

- Track 3 is the strongest NVIDIA Isaac signal, but official FlashCHORD training wants Linux + Docker + NVIDIA Container Toolkit + a 48 GiB GPU with at least 46,000 MiB free.
- Track 2 is too heavy because it has three tiers and policy learning requirements.
- Track 1 is the least policy-training-heavy fallback, but it still needs real reconstruction outputs. Treat it as a fallback, not a guaranteed easy path.

## Non-negotiable first gate: Oct 16-17

By the end of 2026-10-17, decide whether Track 3 is alive.

### Gate A: Kaggle readiness

- Create or confirm Kaggle account.
- Generate `kaggle.json` API token.
- Store it securely, not in Git.
- Accept rules for the chosen track's metric competitions.
- Run submission-kit preflight without `--skip-kaggle`.

### Gate B: compute readiness

Track 3 continues only if one of these is true:

- A cloud machine with A6000/L40/L40S-class GPU is ready, or
- Another Linux NVIDIA GPU box with Docker + NVIDIA Container Toolkit is ready.

If this is not ready by Oct 17 night, pivot to Track 1 or reduce the deliverable to a reproducible setup/report.

## Updated schedule

### Oct 16, Thu, today

Goal: remove account and planning uncertainty.

- Confirm Kaggle account and API token.
- Accept competition rules for the chosen track.
- Watch/replay the V2D webinar only for missing practical details, not as a research rabbit hole.
- Update GitHub README with the current plan.
- Pick the compute route.

Exit condition:

- Kaggle token exists, competitions accepted, and compute decision made.

### Oct 17-18

Goal: first executable baseline smoke test.

If Track 3 compute is available:

- Start cloud GPU box.
- Clone `nvidia-isaac/video_to_data`.
- Checkout the submission-kit-pinned commit.
- Install Git LFS and pull assets.
- Build/start FlashCHORD container.
- Run one minimal replay or one-world evaluation before any training.

If Track 3 compute is not available:

- Pivot to Track 1.
- Inspect Track 1 sample rows and expected reconstruction file schema.
- Identify the smallest method that can produce packable outputs.
- Document exactly what is and is not feasible on local Mac.

Exit condition:

- A command has run in the target runtime, or the pivot decision is recorded.

### Oct 19-21

Goal: first packable artifact.

- Produce one complete set of outputs for the chosen track, even if weak.
- Run local packing/preflight.
- Fix format/schema errors before model-quality errors.
- Commit code that generated the artifact.

Exit condition:

- A packed artifact exists locally, or a written blocker states exactly which required output is missing.

### Oct 22-24

Goal: first Kaggle submission.

- Upload the first valid artifact.
- Save Kaggle receipt and scores.
- Update `submissions.md` with method, commit SHA, timestamp, score, and lesson.
- If invalid, fix only the validation error first.

Exit condition:

- One valid submission, or a precise invalid-submission error with a fix plan.

### Oct 25-30

Goal: one bounded improvement.

Do exactly one improvement lane:

- smoothing / temporal consistency,
- contact/penetration cleanup,
- pose/trajectory filtering,
- object mesh quality cleanup,
- or input preprocessing.

Do not start a new architecture unless the baseline is already valid.

Exit condition:

- Submit improved artifact or decide the baseline is the final artifact.

### Oct 31-Nov 3

Goal: finalization.

- Use unlimited final-three-days submissions for controlled variants only.
- Freeze best artifact.
- Write short technical report.
- Make sure GitHub repo has clean reproduction instructions and the exact commit URL used.

### Nov 4 before 2 PM Vancouver

Goal: final submission.

- Submit final artifact.
- Confirm score/receipt.
- Save all evidence.
- Update README and technical report.

## Repo structure to add next

In `furqazaheervi6/v2d-challenge`, add:

```text
plans/current-plan-2026-10-16.md
submissions.md
reports/technical-report.md
scripts/preflight_track1.sh
scripts/preflight_track3.sh
```

Keep out of Git:

- datasets,
- submission artifacts,
- Kaggle token,
- checkpoints,
- videos,
- generated meshes,
- cloud credentials.

## Current source links checked

- Official challenge page: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/
- Official dataset: https://huggingface.co/datasets/nvidia/video_to_data_challenge
- Official runtime repo: https://github.com/nvidia-isaac/video_to_data
- FlashCHORD README: https://github.com/nvidia-isaac/video_to_data/blob/main/robotic_grounding/flash_chord/README.md
- Existing public repo: https://github.com/furqazaheervi6/v2d-challenge
