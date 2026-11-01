#!/usr/bin/env sh
set -eu
read_option(){ python -c "import json; print(json.load(open('/data/options.json'))['$1'])"; }
export OPENROUTER_API_KEY="$(read_option openrouter_api_key)"
export OMNIGENT_ACCOUNTS_COOKIE_SECRET="$(read_option accounts_cookie_secret)"
export OMNIGENT_ACCOUNTS_INIT_ADMIN_PASSWORD="$(read_option init_admin_password)"
export DATABASE_URL="sqlite:////data/artifacts/chat.db" ARTIFACT_DIR=/data/artifacts HOST=0.0.0.0 PORT=8000
export OMNIGENT_AUTH_ENABLED=1 OMNIGENT_AUTH_PROVIDER=accounts OMNIGENT_BUILTIN_AGENT_DIRS=/agents/family-chat.yaml OMNIGENT_SEEDED_AGENTS=" "
exec python /app/entrypoint.py
