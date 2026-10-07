#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-v2d-challenge}"
mkdir -p "$ROOT/.cache/huggingface" "$ROOT/.cache/xet" "$ROOT/datasets"

HF_HOME="$PWD/$ROOT/.cache/huggingface" \
HF_HUB_CACHE="$PWD/$ROOT/.cache/huggingface/hub" \
XET_CACHE="$PWD/$ROOT/.cache/xet" \
HF_XET_CACHE="$PWD/$ROOT/.cache/xet" \
"$ROOT/.venv/bin/hf" download nvidia/video_to_data_challenge \
  --repo-type dataset \
  --local-dir "$ROOT/datasets/video_to_data_challenge" \
  --max-workers 8
