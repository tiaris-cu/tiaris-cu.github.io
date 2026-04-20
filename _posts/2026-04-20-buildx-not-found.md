---
layout: post
title: "Como solucionar error docker CLI plugin buildx not found al intentar ddev start"
date: 2026-03-30
author: "Tiaris Team"
categories: [Docker, DDEV]
tags: [Docker, DDEV, docker-buildx]
image: /assets/images/blog/2026-04-20-buildx-not-found.png
read_time: 2
comments: false
---

Si al intentar `ddev start` usted obtiene el error:

```bash
Docker buildx check failed: compose build requires buildx 0.17.0 or later: docker CLI plugin "buildx" not found.
Please install buildx: https://github.com/docker/buildx#installing
```

Siga los siguientes pasos para solucionarlo:

1.  **Instale docker-buildx de forma manual**

```bash
# Descarga el binario para Linux amd64 (cambia la URL si necesitas arm64)
sudo curl -L "https://github.com/docker/buildx/releases/download/v0.17.0/buildx-v0.17.0.linux-amd64" -o /usr/local/lib/docker/cli-plugins/docker-buildx
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx
```

2. **Luego cierra y vuelve a abrir la terminal, o reinicia Docker:**

```bash
sudo systemctl restart docker   # En Linux con systemd
```
3. **Verificación final**

Ejecuta estos comandos, todos deben funcionar sin errores:
```bash
docker buildx version
docker buildx inspect
ddev start
```

¡Gracias por leernos!

*El equipo de Tiaris*