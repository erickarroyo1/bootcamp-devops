# Ejercicio 10, crear un script en bash de tipo menú que permita ejecutar acciones para docker.


## Comprobamos las imágenes y los contenedores.

```bash
$docker images -a
$docker ps
$docker ps -a
```

## Creación del Dockerfile.

Usen node:16-alpine

```bash
FROM node:16-alpine


## Creación del contenedor.

```bash
$docker build -t "nodeweb:1.0.0" .
$docker images -a
$docker ps -a
$docker ps
```
## Levantamos el contenedor.

```bash
$docker run -d --name node -p 4000:4000 nodeweb:1.0.0
$docker ps -a
$docker ps
```

## Comprobación de la app corriendo.


## Deploy to Registry DockerHub.

```bash
$docker tag nodeweb:1.0.0 username_dockerhub/nodeweb:1.0.0
$docker push username_dockerhub/nodeweb:1.0.0
```

## Script para ejecutar los comandos anteriores.

```bash
#!/bin/bash

docker build -t nodeweb:1.0.0 .
docker run -d --name node -p 4000:4000 nodeweb:1.0.0
docker tag nodeweb:1.0.0 username_dockerhub/nodeweb:1.0.0
docker push username_dockerhub/nodeweb:1.0.0
```

## Salida al ejecutar script.sh. (EVIDENCIAS)

1. ./docker.sh

![docker-help-sript](./Doc/10-docker-help-script-menu.png?raw=true " docker-help-sript ")

2. ./docker.sh build node-script-app

![docker-build](./Doc/10-docker-build.png?raw=true " docker-build ")

3. ./docker.sh push node-script-app

![docker-pushed](./Doc/10-docker-push.png?raw=true " docker-pushed ")

4. ./docker.sh test node-script-app && docker ps && curl localhost:3000

![./docker.sh test node-script-app && docker ps && curl localhost:3000](./Doc/10-docker-test.png?raw=true " ./docker.sh test node-script-app && docker ps && curl localhost:3000 ")