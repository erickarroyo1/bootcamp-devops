## Lab-04

# 1. Crear una imagen con un servidor web Apache y el mismo contenido que en la carpeta content (fijate en el Dockerfile con el que cree simple-nginx)
docker build . -t apache:erick-0.0.1

![docker build](./04-docker-build-apache.png?raw=true "imagen docker en construcción ")

# 2. Ejecutar un contenedor con mi nueva imagen
docker run -d --name myapache -p 5050:80 apache:erick-0.0.1

![docker en ejecución](./04-docker-running.png?raw=true"docker en ejecución")

# 3. Averiguar cuántas capas tiene mi nueva imagen
docker inspect myapache #En el apartado "Layers" pueden contarse cuántas capas hay

![docker Inspect](./04-docker-inspect.png?raw=true"Inspección/descripción del contenedor")

docker history apache:erick-0.0.1 #Todas las acciones que son < 0B son capas #muestra las modificaciones que se han realizado a la imágen

![docker history](./04-docker-history.png?raw=true"Historial de modificaciones de la imágen del contenedor")

docker image inspect apache:erick-0.0.1 -f '{{.RootFS.Layers}}' #muestra las capas de la imágen

![docker image inspect](./04-docker-image-inspect.png?raw=true"inspección de la imágen del contenedor")

ss -lnpt #visualizar el puerto en escucha.

![ss -lnpt](./04-puerto-5050-en-20escucha.png?raw=true""inspección de la imágen del contenedor")
# 4. Evidencias:

![web running](./04-web-apache-running.png?raw=true" "web running")