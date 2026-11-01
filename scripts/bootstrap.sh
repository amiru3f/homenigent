#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .env ]]; then
  cp .env.example .env
fi

set_value() {
  local key="$1" value="$2"
  if grep -q "^${key}=$" .env; then
    sed -i.bak "s|^${key}=$|${key}=${value}|" .env
    rm .env.bak
  elif ! grep -q "^${key}=" .env; then
    printf '%s=%s\n' "$key" "$value" >> .env
  fi
}

set_value POSTGRES_PASSWORD "$(openssl rand -hex 24)"
set_value OMNIGENT_ACCOUNTS_COOKIE_SECRET "$(openssl rand -hex 32)"

echo "Created/updated .env with generated internal secrets."
echo "Set OPENROUTER_API_KEY and OMNIGENT_ACCOUNTS_INIT_ADMIN_PASSWORD in .env, then run:"
echo "  docker compose up -d"
