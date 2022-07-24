FROM traefik:v2.10

COPY static.yml /etc/traefik/traefik.yml
COPY dynamic /etc/traefik/config
RUN mkdir -p /etc/traefik/acme
