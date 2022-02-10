FROM traefik:v2.10

COPY traefik/static.yml /etc/traefik/traefik.yml
COPY traefik/dynamic.yml /etc/traefik/handle.yml
RUN mkdir -p /etc/traefik/acme
