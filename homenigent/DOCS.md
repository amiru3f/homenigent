# Homenigent

The first start runs the Omnigent server. To activate the co-located host,
open an interactive shell in the Homenigent container and run:

```sh
export HOME=/data/host
omni login http://127.0.0.1:8000
omni host --server http://127.0.0.1:8000 --background --no-open --non-interactive
```

Sign in with the existing Omnigent account you created in the web UI. The
resulting token is persisted only in Home Assistant add-on data. On later
restarts, the add-on automatically starts the host with the stored token.
