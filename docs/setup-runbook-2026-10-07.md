# V2D Challenge setup runbook

Created: 2026-10-07 04:35 PT

## Status

Completed locally in this workspace:

- Downloaded the submission kit.
- Unpacked the submission kit.
- Created a Python virtualenv for the kit.
- Installed submission-kit dependencies plus `huggingface_hub`.
- Pulled the full Hugging Face dataset locally.
- Cloned the NVIDIA `video_to_data` runtime at the submission-kit-pinned commit.
- Ran local Track 3 preflight with Kaggle checks skipped.

Could not run full baseline end-to-end locally because this Mac has no `docker` command and no `nvidia-smi`; the official runtime requires Linux, Docker with NVIDIA Container Toolkit, and a 48 GB NVIDIA GPU for full FlashCHORD training.

## Local paths

Workspace root:

```bash
/Users/furqanzaheer/Library/Application Support/Energy/agents/the-keeper-of-the-big-3-019fe40a-ed37-7138-945e-ec3adca96e1c
```

Key artifacts:

```bash
v2d-challenge/downloads/v2d_submission_kit.zip
v2d-challenge/submission-kit/v2d_submission_kit/
v2d-challenge/.venv/
v2d-challenge/datasets/video_to_data_challenge/
v2d-challenge/repos/video_to_data/
v2d_resource_links.md
```

Sizes verified:

- Hugging Face dataset: 3.9 GB
- Submission kit unpacked: 17 MB
- Virtualenv: 303 MB
- Dataset file count: 1,656 files

## Source links

- Challenge website: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/
- Submission kit ZIP: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/assets/v2d_submission_kit.zip
- Hugging Face dataset: https://huggingface.co/datasets/nvidia/video_to_data_challenge
- Baseline/runtime repo: https://github.com/nvidia-isaac/video_to_data
- Pinned FlashCHORD runtime commit: https://github.com/nvidia-isaac/video_to_data/tree/8c778f905cb35f76f8e6cd6e2ea486da4fb9e0ef/robotic_grounding/flash_chord
- E2E workflow guide: https://github.com/nvidia-isaac/video_to_data/blob/main/docs/e2e_workflow.md
- FAQ PDF: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/assets/v2d_challenge_2026_faqs.pdf
- Leaderboard: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/#leaderboard
- Discord: https://discord.gg/nvidiaomniverse
- Webinar YouTube: https://www.youtube.com/watch?v=U8GHIxXqHLQ

## Reproduce local setup

From workspace root:

```bash
mkdir -p v2d-challenge/{downloads,datasets,repos,notes}

curl -L --fail --show-error --progress-bar \
  -o v2d-challenge/downloads/v2d_submission_kit.zip \
  https://nvidia-isaac.github.io/video_to_data/v2d_challenge/assets/v2d_submission_kit.zip

unzip -q -o v2d-challenge/downloads/v2d_submission_kit.zip \
  -d v2d-challenge/submission-kit

python3 -m venv v2d-challenge/.venv
v2d-challenge/.venv/bin/python -m pip install --upgrade pip
v2d-challenge/.venv/bin/pip install \
  -r v2d-challenge/submission-kit/v2d_submission_kit/requirements.txt
v2d-challenge/.venv/bin/pip install -U huggingface_hub
```

Download dataset with cache redirected into the workspace:

```bash
mkdir -p v2d-challenge/.cache/{huggingface,xet}
HF_HOME="$PWD/v2d-challenge/.cache/huggingface" \
HF_HUB_CACHE="$PWD/v2d-challenge/.cache/huggingface/hub" \
XET_CACHE="$PWD/v2d-challenge/.cache/xet" \
HF_XET_CACHE="$PWD/v2d-challenge/.cache/xet" \
v2d-challenge/.venv/bin/hf download nvidia/video_to_data_challenge \
  --repo-type dataset \
  --local-dir v2d-challenge/datasets/video_to_data_challenge \
  --max-workers 8
```

Clone source code without needing local Git LFS:

```bash
git -c filter.lfs.smudge= \
    -c filter.lfs.process= \
    -c filter.lfs.required=false \
    clone https://github.com/nvidia-isaac/video_to_data.git \
    v2d-challenge/repos/video_to_data

cd v2d-challenge/repos/video_to_data
git -c filter.lfs.smudge= \
    -c filter.lfs.process= \
    -c filter.lfs.required=false \
    checkout 8c778f905cb35f76f8e6cd6e2ea486da4fb9e0ef
```

## Local validation commands

```bash
cd v2d-challenge/submission-kit/v2d_submission_kit
../../.venv/bin/python tools/preflight.py --help
../../.venv/bin/python tools/preflight.py \
  --track track_3 \
  --dataset-root ../../datasets/video_to_data_challenge \
  --skip-kaggle
```

Observed result: dependencies and public Track 3 templates were OK. Warnings remained because no generated policy trajectories/results were supplied and Kaggle checks were skipped.

## Full baseline path on a GPU machine

Use a Linux machine with:

- NVIDIA driver 580+
- Docker
- NVIDIA Container Toolkit
- Git LFS
- 48 GB NVIDIA GPU recommended for full training

On that machine:

```bash
git clone https://github.com/nvidia-isaac/video_to_data.git
cd video_to_data
git checkout 8c778f905cb35f76f8e6cd6e2ea486da4fb9e0ef
git lfs install
git lfs pull
cd robotic_grounding/flash_chord
docker/run.sh build
nvidia-smi --query-gpu=index,name,memory.total,memory.free --format=csv
docker/run.sh start latest 0
```

Inside the container, follow `robotic_grounding/flash_chord/README.md`. The example workflow uses bundled Sharpa/G1 data first:

```bash
SHARPA_PARQUET=/v2d/assets/human_motion_data/ego_recon/processed/sequence_id=tissue_box_simple/robot_name=sharpa_wave
G1_PARQUET=/v2d/assets/human_motion_data/whole_body/soma/sequence_id=2026-03-06_10-24-18_snack_box_pick_and_place_01/robot_name=g1/data.parquet

python scripts/train_flash_sac.py experiment=sharpa_flash_sac \
  "task.parquet='${SHARPA_PARQUET}'" reset.seed=42 logging.mode=disabled \
  output_dir=outputs/sharpa_full

CHECKPOINT=outputs/sharpa_full/policy_250003456.safetensors
python scripts/evaluate_policy.py "evaluation.checkpoint=${CHECKPOINT}" \
  evaluation.world_count=4096 "evaluation.metrics_output=${CHECKPOINT}.metrics.json"
```

Then use submission-kit packing once trajectories/checkpoints and meshes exist:

```bash
cd /path/to/v2d_submission_kit
python3 examples/run_policy_evaluation.py \
  --checkpoints /path/to/checkpoints.json --results results/

COMMIT_URL="https://github.com/<user>/<repo>/commit/<sha>"
python3 tools/pack_submission.py --track track_3 \
  --results results/ \
  --meshes /path/to/reconstructed_meshes \
  --code-commit "$COMMIT_URL" \
  -o track3_submission.parquet
```

Upload requires Kaggle API credentials and accepted competition rules:

```bash
python3 submit/v2d_submit.py track3_submission.parquet --track track_3 \
  -m "Track 3 submission" --wait
```

## Immediate next actions

1. Watch or replay the webinar and capture any challenge-specific baseline tips.
2. Decide target track. Recommended initial route: Track 3 for NVIDIA signal, but run Track 2 Tier 1 if you want a faster first leaderboard attempt.
3. Provision a GPU environment. Best fit: cloud Linux box with A6000/L40/L40S-class GPU. Colab is not ideal because the docs expect Docker + NVIDIA Container Toolkit and 48 GB GPU.
4. Create a public GitHub repo for your challenge code so every submission can include a valid `/commit/<sha>` URL.
5. Set up Kaggle API token and accept the metric competition rules before first upload.

## Deadlines

- Leaderboard closes: 2026-11-04 5:00 PM EST.
- Winners announced: 2026-11-12 at CoRL 2026.
- Submission limit: 5 per week, unlimited during final 3 days.
