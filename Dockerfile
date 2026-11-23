FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl unzip ca-certificates python3 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN curl -fsSL -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip -o xray.zip xray geoip.dat geosite.dat && rm xray.zip && chmod +x xray
RUN curl -fsSL -o cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x cloudflared
COPY health.py start.sh /app/
EXPOSE 8080
CMD ["sh", "/app/start.sh"]
