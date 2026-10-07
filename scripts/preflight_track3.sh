#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-v2d-challenge}"
cd "$ROOT/submission-kit/v2d_submission_kit"
../../.venv/bin/python tools/preflight.py \
  --track track_3 \
  --dataset-root ../../datasets/video_to_data_challenge \
  --skip-kaggle
