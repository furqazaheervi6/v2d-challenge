# V2D Challenge 2026

Working repo for NVIDIA's Video-to-Data Challenge.

## Current setup

Current plan and setup notes are in:

- `plans/current-plan-2026-10-16.md`
- `docs/setup-runbook-2026-10-07.md`
- `docs/resource-links.md`
- `submissions.md`

Large local artifacts are intentionally not tracked:

- submission kit unpack
- Hugging Face dataset
- virtualenvs
- cloned NVIDIA runtime
- generated trajectories/checkpoints/submissions

## Official resources

- Challenge site: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/
- Dataset: https://huggingface.co/datasets/nvidia/video_to_data_challenge
- Runtime repo: https://github.com/nvidia-isaac/video_to_data
- Leaderboard: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/#leaderboard


## Current priority

As of 2026-10-16, the priority is not more downloading. It is:

1. Confirm Kaggle token and rule acceptance.
2. Secure a Linux NVIDIA GPU environment within 24 hours if pursuing Track 3.
3. Otherwise pivot to Track 1 or document the compute blocker honestly.
4. Get one valid, reproducible submission before the 2026-11-04 2:00 PM Vancouver deadline.

## Local quickstart

```bash
bash scripts/download_submission_kit.sh
bash scripts/download_dataset.sh
bash scripts/preflight_track3.sh
```

Full FlashCHORD baseline execution needs Linux, Docker, NVIDIA Container Toolkit, Git LFS, and a 48 GB NVIDIA GPU.
