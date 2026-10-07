# V2D Challenge 2026

Working repo for NVIDIA's Video-to-Data Challenge.

## Current setup

Local setup notes and resource links are in:

- `docs/setup-runbook-2026-10-07.md`
- `docs/resource-links.md`

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

## Local quickstart

```bash
bash scripts/download_submission_kit.sh
bash scripts/download_dataset.sh
bash scripts/preflight_track3.sh
```

Full FlashCHORD baseline execution needs Linux, Docker, NVIDIA Container Toolkit, Git LFS, and a 48 GB NVIDIA GPU.
