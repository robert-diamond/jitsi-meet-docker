ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base:${BASE_TAG}

LABEL org.opencontainers.image.title="Jitsi Meet"
LABEL org.opencontainers.image.description="WebRTC compatible JavaScript application that uses Jitsi Videobridge to provide high quality, scalable video conferences."
LABEL org.opencontainers.image.url="https://jitsi.org/jitsi-meet/"
LABEL org.opencontainers.image.source="https://github.com/jitsi/docker-jitsi-meet"
LABEL org.opencontainers.image.documentation="https://jitsi.github.io/handbook/"

ADD https://raw.githubusercontent.com/acmesh-official/acme.sh/3.0.7/acme.sh /opt
COPY rootfs/ /

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y dnsutils cron nginx-extras jitsi-meet-web socat curl jq && \
    mv /usr/share/jitsi-meet/interface_config.js /defaults && \
    rm -f /etc/nginx/conf.d/default.conf && \
    sed -i 's/<title>Jitsi Meet<\/title>/<title>Kanvene<\/title>/g' /usr/share/jitsi-meet/index.html 2>/dev/null || true && \
    sed -i 's/content="Jitsi Meet"/content="Kanvene"/g' /usr/share/jitsi-meet/index.html 2>/dev/null || true && \
    sed -i 's/Jitsi Meet/Kanvene/g' /usr/share/jitsi-meet/title.html 2>/dev/null || true && \
    sed -i 's/Jitsi Meet/Kanvene/g' /usr/share/jitsi-meet/static/*.html 2>/dev/null || true && \
    sed -i 's/https:\/\/jitsi\.org/https:\/\/kanvene.com/g' /usr/share/jitsi-meet/static/*.html 2>/dev/null || true && \
    apt-cleanup

EXPOSE 80 443

VOLUME ["/config", "/usr/share/jitsi-meet/transcripts"]
