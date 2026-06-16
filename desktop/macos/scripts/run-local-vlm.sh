#!/usr/bin/env bash
set -euo pipefail

MODEL="${LOCAL_VLM_MODEL:-Qwen/Qwen2.5-VL-3B-Instruct-AWQ}"
HOST="${LOCAL_VLM_HOST:-127.0.0.1}"
PORT="${LOCAL_VLM_PORT:-8000}"
MAX_MODEL_LEN="${LOCAL_VLM_MAX_MODEL_LEN:-4096}"
LIMIT_MM="${LOCAL_VLM_LIMIT_MM:-image=2,video=0}"

if ! command -v vllm >/dev/null 2>&1; then
  echo "vLLM is not installed in this shell."
  echo "Install it in your preferred Python environment, then rerun:"
  echo "  pip install vllm"
  exit 1
fi

exec vllm serve "$MODEL" \
  --host "$HOST" \
  --port "$PORT" \
  --max-model-len "$MAX_MODEL_LEN" \
  --limit-mm-per-prompt "$LIMIT_MM"
