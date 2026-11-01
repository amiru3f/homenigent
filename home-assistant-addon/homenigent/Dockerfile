ARG BUILD_FROM=ghcr.io/omnigent-ai/omnigent-server:latest
FROM ${BUILD_FROM}

COPY agents/family-chat.yaml /agents/family-chat.yaml
COPY run.sh /run.sh
RUN chmod 755 /run.sh

CMD ["/run.sh"]
