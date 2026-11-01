#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
env_file="$repo_dir/.env"

if [[ ! -f "$env_file" ]]; then
  echo "Missing $env_file. Run scripts/bootstrap.sh and set OPENROUTER_API_KEY." >&2
  exit 1
fi

set -a
source "$env_file"
set +a

if [[ -z "${OPENROUTER_API_KEY:-}" ]]; then
  echo "OPENROUTER_API_KEY is not set in $env_file." >&2
  exit 1
fi

export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_API_KEY"
export ANTHROPIC_API_KEY=""
model="${OPENROUTER_CLAUDE_MODEL:-~anthropic/claude-haiku-latest}"
export ANTHROPIC_DEFAULT_OPUS_MODEL="$model"
export ANTHROPIC_DEFAULT_SONNET_MODEL="$model"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="$model"

exec claude "$@"
