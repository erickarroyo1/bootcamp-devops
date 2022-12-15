#!/bin/bash

#crear imagen con el docker build utilizando un dockerfile local

echo -e '\n--Construyendo la imágen de Docker Apache--\n\n'

docker build -t apache:erick-0.0.1 .

#correr un contenedor utilizando la imágen creada utilizando el pto 5050 y nombrandolo como "myapache"

echo -e '\n--Ejecutando un docker con apache --\n\n'

docker run -d --name myapache -p 5050:80 apache:erick-0.0.1

# inspeccionar el contenedor creado

echo -e '\n--Inspeccionando el contenedor --\n\n'

docker inspect myapache

#Validar el historico del contenedor

echo -e '\n--Historial del contenedor--\n\n'
docker history myapache


#listar los contenedores en ejecución

echo -e '\n--Listar docker containers en ejecución--\n\n'

docker ps
