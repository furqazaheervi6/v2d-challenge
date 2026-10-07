# V2D Challenge resource links extracted 2026-10-07

Source emails in UBC Outlook from V2DChallenge@nvidia.com:
- "Welcome to the V2D Challenge—get started and join our October 7 webinar" sent Tue 2026-10-06 2:39 PM.
- "Tomorrow! From Human Video to Robot Skills: V2D Challenge webinar" sent Tue 2026-10-06 3:26 PM.

## Exact links

- Challenge website: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/
- Submission kit ZIP: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/assets/v2d_submission_kit.zip
- Hugging Face dataset root: https://huggingface.co/datasets/nvidia/video_to_data_challenge
- Track 1 dataset: https://huggingface.co/datasets/nvidia/video_to_data_challenge/tree/main/track_1
- Track 2 dataset: https://huggingface.co/datasets/nvidia/video_to_data_challenge/tree/main/track_2
- Track 3 dataset: https://huggingface.co/datasets/nvidia/video_to_data_challenge/tree/main/track_3
- Starter toolkit / baseline repository: https://github.com/nvidia-isaac/video_to_data
- Accelerated RL release mentioned in email: https://github.com/nvidia-isaac/video_to_data/releases/tag/v0.4.0
- Public FlashCHORD runtime at submission-kit pinned commit: https://github.com/nvidia-isaac/video_to_data/tree/8c778f905cb35f76f8e6cd6e2ea486da4fb9e0ef/robotic_grounding/flash_chord
- E2E workflow guide: https://github.com/nvidia-isaac/video_to_data/blob/main/docs/e2e_workflow.md
- Challenge FAQ PDF: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/assets/v2d_challenge_2026_faqs.pdf
- Leaderboard: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/#leaderboard
- Discord invite: https://discord.gg/nvidiaomniverse
- Webinar calendar/AddEvent: https://www.addevent.com/event/r53d7v948fl7
- Webinar YouTube: https://www.youtube.com/watch?v=U8GHIxXqHLQ
- Judges/panel: https://nvidia-isaac.github.io/video_to_data/v2d_challenge/#judges
- GitHub org to invite for private code review: https://github.com/Nvidia-V2D-Challenge
- Contact: v2d_challenge@nvidia.com

No Colab link was present in either V2D email, the challenge page, or the nvidia-isaac/video_to_data repository tree inspected.

## Visible setup/submission notes

- Dataset CLI download:
```bash
python -m pip install -U "huggingface_hub"
hf download nvidia/video_to_data_challenge \
  --repo-type dataset \
  --local-dir ./video_to_data_challenge
# If authentication is requested:
hf auth login
```

- Submission kit shared setup:
```bash
pip install -r requirements.txt
```

- Track 3 example evaluate/pack/submit commands from submission kit:
```bash
python3 examples/run_policy_evaluation.py \
  --checkpoints /path/to/checkpoints.json --results results/
python3 tools/pack_submission.py --track track_3 \
  --results results/ --meshes /path/to/reconstructed_meshes \
  --code-commit "$COMMIT_URL" -o track3_submission.parquet
python3 submit/v2d_submit.py track3_submission.parquet --track track_3 \
  -m "Track 3 submission" --wait
```

- E2E baseline/local workflow requirements seen in docs: Docker with GPU support, NVIDIA Container Toolkit, Python 3.10+, NVIDIA driver 580.126.09 / CUDA 13.0 recommended for robotic_grounding, one 48GB NVIDIA GPU; workflow verified on RTX A6000, L40, and L40S GPUs. The E2E workflow is local/GPU-oriented, not Colab-oriented.

## Deadlines and limits

- Webinar: October 7, 2026 at 11:00 a.m. PT.
- Leaderboard closes/freezes: November 4, 2026 at 5:00 p.m. EST.
- Winners announced at CoRL 2026: November 12, 2026.
- Teams may submit up to five times per week, with unlimited submissions during the final three days.

## Access notes

- Hugging Face dataset page is public; README says to run `hf auth login` if authentication is requested.
- Kaggle submission requires a Kaggle account/API token and accepting each competition's rules.
- Discord invite requires joining the NVIDIA Discord and going to `#v2d-challenge`.
- If repository is private, invite `Nvidia-V2D-Challenge` as collaborator and ensure the commit URL is visible.
