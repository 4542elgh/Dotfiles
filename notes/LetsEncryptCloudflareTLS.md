# TLS issues
If there is a problem installing Let's Encrypt certificate while enabling Cloudflare Proxies, it is because Let's Encrypt is trying to use ALPN method.
Simply use HTTP-01 or DNS-01 method to resolve this issue.

I am using Traefik inside Docker container.<br/>
I am using HTTP-01 method.

```yaml
services:
  traefik:
    # The official v2.0 Traefik docker image
    image: traefik:v2.1.4
    # Enables the web UI and tells Traefik to listen to docker
    command: 
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false" 
      - "--entrypoints.webinsecure.address=:80"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.tlschallenge.acme.tlschallenge=true"
      - "--certificatesresolvers.tlschallenge.acme.email=youremail@example.com"
      - "--certificatesresolvers.tlschallenge.acme.storage=/letsencrypt/acme.json"
      - "--certificatesresolvers.tlschallenge.acme.httpchallenge.entrypoint=http"
    ports:
      - "80:80"
      # The HTTP port
      - "443:443"
      # The Web UI (enabled by --api.insecure=true)
      - "8080:8080"
    restart: always
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      - "./letsencrypt:/letsencrypt"
    networks:
      - proxy 

  web:
    build: 
      context: ./Dockerfile
      dockerfile: NodeJs_Dockerfile
    labels: 
      - "traefik.enable=true"
      - "traefik.http.routers.web.rule=Host(`yourwebsite.com`,`www.yourwebsite.com`)"
      - "traefik.http.routers.web.entrypoints=websecure"
      - "traefik.http.routers.web.tls.certresolver=tlschallenge"
      - "traefik.docker.network=proxy"
    networks:
      - internal
      - proxy

networks:
  proxy:
    external: true
  internal:
    external: true 
```

Replace `- "--certificatesresolvers.tlschallenge.acme.httpchallenge.entrypoint=http"` with a provider to use DNS
Traefik users can check [this page](https://docs.traefik.io/v1.7/configuration/acme/) on how to set a provider.
