## Lab-04

# 1. Crear una imagen con un servidor web Apache y el mismo contenido que en la carpeta content (fijate en el Dockerfile con el que cree simple-nginx)
docker build . -t apache:erick-0.0.1

# 2. Ejecutar un contenedor con mi nueva imagen
docker run -d --name myapache -p 5050:80 apache:erick-0.0.1

# 3. Averiguar cuántas capas tiene mi nueva imagen
docker inspect myapache #En el apartado "Layers" pueden contarse cuántas capas hay

docker history myapache #Todas las acciones que son < 0B son capas

docker image inspect apache:erick-0.0.1 -f '{{.RootFS.Layers}}'