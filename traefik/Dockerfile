FROM traefik:2.11

COPY static.yml /etc/traefik/traefik.yml
COPY dynamic /etc/traefik/config
RUN mkdir -p /etc/traefik/acme
