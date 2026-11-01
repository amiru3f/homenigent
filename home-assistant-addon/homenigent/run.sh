#!/usr/bin/env sh
set -eu

options=/data/options.json
if [ ! -f "$options" ]; then
  echo "Home Assistant options are unavailable." >&2
  exit 1
fi

read_option() {
  python -c "import json; print(json.load(open('/data/options.json'))['$1'])"
}

export OPENROUTER_API_KEY="$(read_option openrouter_api_key)"
export OMNIGENT_ACCOUNTS_COOKIE_SECRET="$(read_option accounts_cookie_secret)"
export OMNIGENT_ACCOUNTS_INIT_ADMIN_PASSWORD="$(read_option init_admin_password)"
export DATABASE_URL="sqlite:////data/artifacts/chat.db"
export ARTIFACT_DIR="/data/artifacts"
export HOST="0.0.0.0"
export PORT="8000"
export OMNIGENT_AUTH_ENABLED="1"
export OMNIGENT_AUTH_PROVIDER="accounts"
export OMNIGENT_ACCOUNTS_BASE_URL=""
export OMNIGENT_BUILTIN_AGENT_DIRS="/agents/family-chat.yaml"
export OMNIGENT_SEEDED_AGENTS=" "

exec python /app/entrypoint.py
