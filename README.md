# 🫥 Stub

Stub domains for redirects.

```bash
htpasswd -c users traefik

docker volume create acme
docker volume create stub
docker run --rm -it \
  -v stub:/runtime \
  -w /runtime \
  alpine:latest
# vi users

docker run -d \
  --name stub \
  -p 80:80 \
  -p 443:443 \
  -v acme:/etc/traefik/acme \
  -v stub:/runtime \
  ghcr.io/octomation/stub:latest
```

<p align="right">made with ❤️ for everyone by <a href="https://www.octolab.org/">OctoLab</a></p>

[social.preview]:   https://cdn.octolab.org/repo/stub.png
[preview.config]:   https://socialify.git.ci/octomation/stub?description=1&font=Raleway&language=1&name=1&owner=1&pattern=Circuit%20Board&theme=Light
[preview.fallback]: https://socialify.git.ci/octomation/stub/image?description=1&font=Raleway&language=1&name=1&owner=1&pattern=Circuit%20Board&theme=Light
