### Poke Python utilizando comandos de docker y también utilizando un docker-compose. Ambos casos con script.


# Crear Dockerfile

```
FROM python:3.10.8-alpine
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD [ "python", "./app.py" ]
```

# La Aplicación expone en el puerto 5000

# Construir la imagen tomar en cuenta version 1.0.0

```
docker build -t pokeapi:0.0.1 .
```

# Push de la Imagen en el Registry DockerHub

```
docker login
docker tag pokeapi:0.0.1 191006/pokeapi:0.0.1
docker push 191006/pokeapi:0.0.1
```

# Crear docker-compose para facilitar la ejecución del contenedor.

```
# Cada servicio declarado corresponde a un contenedor
# docker run -d -p 5000:5000 --name 09-pokeapi pokeapi:0.0.1 
version: '3'
services:
  pokeapi:
    container_name: 09-poke-api
    ports:
      - "5000:5000"
    image: 191006/pokeapi:0.0.1

```

# Correr el docker y realizar pruebas utilizando docker cli

```
docker run -d -p 5000:5000 --name 09-pokeapi pokeapi:0.0.1 
```

# Ejecutar un script que realice los pasos anteriores y corra el docker 

```
#!/bin/bash

echo -e '\n\nConstruyendo la imàgen PokeApi basada en kas definiciones del dockerfile usando Python Base\n\n'
docker build -t pokeapi:0.0.1 .
echo -e '\n\nPush de la imágen a dockerhub\n\n'
docker login
docker tag pokeapi:0.0.1 191006/pokeapi:0.0.1
docker push 191006/pokeapi:0.0.1
echo -e '\n\nDocker Run para inicializar el contenedor\n\n'
docker run -d -p 5000:5000 --name 09-pokeapi pokeapi:0.0.1 
echo -e '\n\nTesting app pokeapi, pto tcp 5000, en 10 segundos \n\n'
sleep 10
curl localhost:5000
```


![docker-run](./Doc/09-docker-run.png?raw=true " docker-run ")

# Instalar Docker compose
  
```
sudo apt install docker-compose

```

# Ejecutar un script que permita utilizar el docker-compose para inicializar el contenedor


```
#!/bin/bash

echo -e '\n\nConstruyendo la imàgen PokeApi basada en kas definiciones del dockerfile usando Python Base\n\n'
docker build -t pokeapi:0.0.1 .
echo -e '\n\nPush de la imágen a dockerhub\n\n'
docker login
docker tag pokeapi:0.0.1 191006/pokeapi:0.0.1
docker push 191006/pokeapi:0.0.1
echo -e '\n\ndocker-compose up para inicializar el contenedor\n\n'
docker-compose up -d
echo -e '\n\nTesting app pokeapi, pto tcp 5000, en 10 segundos \n\n'
sleep 10
curl localhost:5000
```


![docker-compose](./Doc/09-docker-compose.png?raw=true " docker-compose ")




# Mostrar Contenedor ejecutandose.

![docker-ps](./Doc/09-docker-ps.png?raw=true " docker-ps ")
