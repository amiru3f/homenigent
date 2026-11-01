# Homenigent

Shared household Omnigent family chat.

Set the OpenRouter API key in the Home Assistant add-on configuration, start
the add-on, then open its Ingress page. Home Assistant authenticates access to
the add-on. Omnigent runs with its own multi-user login disabled, so the
add-on starts one shared local host automatically and never needs `omni login`.

Conversations belong to the shared household Omnigent workspace. Do not use
this mode for untrusted users or for separate private Omnigent accounts.
