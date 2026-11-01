# Homenigent

Private, family-oriented Omnigent configuration. Git contains configuration only; `.env` contains credentials and is never committed.

## Local test

1. Create an OpenRouter key at <https://openrouter.ai/keys>. Free-model availability and limits are controlled by OpenRouter.
2. Run `./scripts/bootstrap.sh`.
3. Edit `.env`: set `OPENROUTER_API_KEY`. For an unattended or network-visible deployment, also set `OMNIGENT_ACCOUNTS_INIT_ADMIN_PASSWORD`.
4. Run `docker compose up -d` and open <http://localhost:8000>.
5. On the local first run, create the initial admin account in the browser; then use the `family-chat` agent.

The server stores sessions in Postgres and uploaded artifacts in the Docker volume. The agent uses Omnigent's `openai-agents` SDK harness with OpenRouter's OpenAI-compatible endpoint, so neither Claude Code nor Codex is required.

## Security boundary

This starter exposes **no Home Assistant, shell, browser, filesystem, or calendar tools**. The next deployment step will keep the service private and add authentication before it is exposed to family devices.

## Deployment

The exact same Compose configuration will be adapted for Home Assistant after the local test succeeds. Before deployment, pin `OMNIGENT_IMAGE_TAG` to a tested release instead of `latest`.
