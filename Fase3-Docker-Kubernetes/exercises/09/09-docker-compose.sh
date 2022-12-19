#!/bin/bash

echo -e '\n\nConstruyendo la imàgen PokeApi basada en kas definiciones del dockerfile usando Python Base\n\n'

docker-compose build --tag=pokeapi:0.0.1 .


echo -e '\n\nPush de la imágen a dockerhub\n\n'

docker login
docker tag pokeapi:0.0.1 191006/pokeapi:0.0.1
docker push 191006/pokeapi:0.0.1

echo -e '\n\nDocker Run para inicializar el contenedor\n\n'

docker-compose up 


echo -e '\n\nTesting app pokeapi, pto tcp 5000, en 10 segundos \n\n'

sleep 10

curl localhost:5000




