#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-v2d-challenge}"
KIT_URL="https://nvidia-isaac.github.io/video_to_data/v2d_challenge/assets/v2d_submission_kit.zip"

mkdir -p "$ROOT/downloads" "$ROOT/submission-kit"
curl -L --fail --show-error --progress-bar -o "$ROOT/downloads/v2d_submission_kit.zip" "$KIT_URL"
unzip -q -o "$ROOT/downloads/v2d_submission_kit.zip" -d "$ROOT/submission-kit"
python3 -m venv "$ROOT/.venv"
"$ROOT/.venv/bin/python" -m pip install --upgrade pip
"$ROOT/.venv/bin/pip" install -r "$ROOT/submission-kit/v2d_submission_kit/requirements.txt"
"$ROOT/.venv/bin/pip" install -U huggingface_hub
