#!/bin/bash

#descargar imagen de docker para nginx en la última versión (laest)
echo -e '\n--Downloading Image--\n'
docker pull nginx

#crear una imàgen con el dockerfile

echo -e '\n--Building Image--\n\n'

docker build -t bootcamp-web:0.0.1 .

#listar las imágenes locales

echo -e '\n--Listing Images-\n\n'

docker images

#correr un contenedor uilizando 

echo -e '\n--running docker--\n\n'


docker run -d -p 9999:80 --name bootcamp-web bootcamp-web:0.0.1


#listar los contenedores en ejecución

echo -e '\n--lising docker containers running--\n\n'

docker ps