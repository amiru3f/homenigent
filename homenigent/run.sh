#!/usr/bin/env sh
set -eu
read_option(){ python -c "import json; print(json.load(open('/data/options.json'))['$1'])"; }
export OPENROUTER_API_KEY="$(read_option openrouter_api_key)"
export DATABASE_URL="sqlite:////data/artifacts/chat.db" ARTIFACT_DIR=/data/artifacts HOST=0.0.0.0 PORT=8000
export OMNIGENT_AUTH_ENABLED=0 OMNIGENT_BUILTIN_AGENT_DIRS=/agents/family-chat.yaml OMNIGENT_SEEDED_AGENTS=" "
mkdir -p /data/server /data/host
# The server and shared host both write ~/.omnigent/config.yaml, but that file
# has a different schema in each role. Keep their homes separate.
export HOME=/data/server

python /app/entrypoint.py &
server_pid=$!

until python -c "from urllib.request import urlopen; urlopen('http://127.0.0.1:8000/health', timeout=2)"; do
  sleep 2
done

# Home Assistant Ingress is the security boundary for this household add-on.
# With Omnigent's own multi-user auth disabled, this shared local host needs no
# interactive user login and starts automatically after every add-on restart.
export HOME=/data/host
OMNIGENT_RUNNER_ENV_PASSTHROUGH=OPENROUTER_API_KEY \
  omni host --server http://127.0.0.1:8000 --background --no-open --non-interactive

wait "$server_pid"
