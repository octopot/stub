FROM traefik:v2.10

COPY static.yml /etc/traefik/traefik.yml
COPY dynamic.yml /etc/traefik/handle.yml
RUN mkdir -p /etc/traefik/acme
