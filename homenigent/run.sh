#!/usr/bin/env sh
set -eu
read_option(){ python -c "import json; print(json.load(open('/data/options.json'))['$1'])"; }
export OPENROUTER_API_KEY="$(read_option openrouter_api_key)"
export OMNIGENT_ACCOUNTS_COOKIE_SECRET="$(read_option accounts_cookie_secret)"
export OMNIGENT_ACCOUNTS_INIT_ADMIN_PASSWORD="$(read_option init_admin_password)"
export DATABASE_URL="sqlite:////data/artifacts/chat.db" ARTIFACT_DIR=/data/artifacts HOST=0.0.0.0 PORT=8000
export OMNIGENT_AUTH_ENABLED=1 OMNIGENT_AUTH_PROVIDER=accounts OMNIGENT_BUILTIN_AGENT_DIRS=/agents/family-chat.yaml OMNIGENT_SEEDED_AGENTS=" "
mkdir -p /data/host
export HOME=/data/host

python /app/entrypoint.py &
server_pid=$!

until python -c "from urllib.request import urlopen; urlopen('http://127.0.0.1:8000/health', timeout=2)"; do
  sleep 2
done

# The account and password exist only in Home Assistant's protected add-on
# options. The login token is persisted under /data/host for later restarts.
printf 'admin\n%s\n' "$OMNIGENT_ACCOUNTS_INIT_ADMIN_PASSWORD" | omni login http://127.0.0.1:8000
OMNIGENT_RUNNER_ENV_PASSTHROUGH=OPENROUTER_API_KEY \
  omni host --server http://127.0.0.1:8000 --background --no-open --non-interactive

wait "$server_pid"
