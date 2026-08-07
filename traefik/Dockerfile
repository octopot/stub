FROM traefik:3.0

COPY static.yml /etc/traefik/traefik.yml
COPY dynamic /etc/traefik/config
RUN mkdir -p /etc/traefik/acme
