## Lab-02

Ejecutar un contenedor que corre `MongoDB` y con el cual nos conectaremos por medio de `Python`

1. Iniciar el container de `MongoDB` utilizando el comando `docker run -d -p 27017:27017 --name m1 mongo`
   1. Puedes conectarte al contenedor de Mongo con `docker exec -it m1 /bin/bash` y luego conectarte a `MongoDB` por medio del comando `mongosh`
   2. Para salir de la terminal interactiva del contenedor, primero hay que salir de `MongoDB` tecleando el comando `exit`, y una vez fuera podemos tecler la combinación `Ctrl+P` y `Ctrl+Q` para salir
2. Utilizaremos los scripts de `Python` existentes en la carpeta para la colección de mongo, utilizando la librería <https://api.mongodb.com/python/current/tutorial.html>
   1. Instalar la librería de mongo por medio del comando `pip install pymongo`
   2. Ejecuta los scripts con `python populate.py` y `python find.py`
   3. Revisa los registros por medio del CLI de `mongo` o de tu DBMS favorito
3. Una vez que hayas terminado de jugar con `MongoDB` y los scripts de `Python`, asegúrate de detener y remover el contenedor de `MongoDB` en ejecución utilizando `docker stop m1; docker rm m1`

## ENTREGABLE


Ejecutar un contenedor que corre `MongoDB` y con el cual nos conectaremos por medio de `Python`

	#correr un docker con mongo en el puerto 27017 llamado M1

docker run -d -p 27017:27017 --name m1 mongo
#conectarse con una shell al contenedor M1
docker exec -it m1 /bin/bash	

![Docker Running](./Doc/02-docker-en%20-ejecución.png?raw=true " Docker Running ")


Utilizaremos los scripts de `Python` existentes en la carpeta para la colección de mongo, utilizando la librería <https://api.mongodb.com/python/current/tutorial.html>

	

Conectarse a mongo o usar la shell para obtener los registros:

#Utiliza el cliente Mongosh para usar la CLI de mongo
mongosh
#Muestra las bases de datos
show databases
#seleccionar una bd existente 
use mi-db
#mostrar las tablas o colecciones creadas
show collections
#utilizar una tabla existente y visualizar los registros
db.pet.find()

![mongosh connection](./Doc/02-mongosh.png?raw=true " mongosh connection ")


Borrar el contenedor

docker rm -f m1

![docker rm -f ](./Doc/02-rocker-rm.png?raw=true " docker rm -f ")


