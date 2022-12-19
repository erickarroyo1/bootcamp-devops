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




