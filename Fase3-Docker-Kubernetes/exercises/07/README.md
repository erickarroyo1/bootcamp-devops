### DOCKERIZAR UN APP CON NODEJS

1. Teniendo como insumo un archivo index.js y un package.json procedemos a construir un dockerfile para crear una imágen que nos permita dockerizar el app de nodejs.

```
# From Image node
FROM node:alpine3.16
# Working Directory
WORKDIR /app
# Copy index and package json into docker.
COPY ./index.js /app/
COPY ./package.json /app/
# Installing dependencies using package.json for node app
RUN npm install
# Expose por 8000
EXPOSE 8000
# Run js into docker when docker run
CMD [ "node", "index.js" ]

```

# Docker Build

```
docker build -t nodeapp:excercise-07 .

```

![docker build](./Doc/07-docker-build.png?raw=true " docker build ")


# Docker Images

```
docker images

```

![docker Images](./Doc/07-docker-images-nodeapp.png?raw=true " docker Images ")


# Docker Run

```
docker run -d -p 3000:3000 --name nodeapp-excercise-07 nodeapp:excercise-07

```

![docker Run and test](./Doc/07-docker-running-and-test.png?raw=true " docker Run and test ")


# App Running



![App Running](./Doc/07-nodeapp-web-running.png?raw=true " App Running ")





## Referencia: 

https://nodejs.org/en/docs/guides/nodejs-docker-webapp/

