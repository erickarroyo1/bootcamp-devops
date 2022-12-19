## Dockerizar un web server "hello World" en nodeJs.

1. Creamos el dockerfile copiando los archivos necesarios para el webpage.

```
# From Image node
FROM node:alpine3.16
# Working Directory
WORKDIR /app
# Copy index and package json into docker.
COPY ./index.html /app/
COPY ./server.js /app/
COPY ./package.json /app/
COPY ./.eslintrc.js /app/
# Installing dependencies using package.json for node app
RUN npm install
# Expose por 3000
EXPOSE 3000
# Run js into docker when docker run
CMD [ "node", "server.js" ]

```

2. Construimos la imágen de docker "docker build"


```

docker build -t node-app2:excercise-08 . 

```
![08-docker-build](./Doc/08-docker-build.png?raw=true " 08-docker-build ")

3. Inicializamos el docker "docker run", mostramos los contenedores en ejecución "docker ps" y probamos "curl localhost:3500"

```
docker run -d -p 3500:3000 --name nodeapp-excercise-08 node-app2:excercise-08
docker ps  
curl localhost:3500

```

![08-docker-running-and-test](./Doc/08-docker-running-and-test.png?raw=true " 08-docker-running-and-test ")


