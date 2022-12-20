### Ejercicio 11 - Parte 1
# Despliegue de la aplicación Guestbook

En este ejemplo vamos a desplegar una aplicación web que requiere de dos servicios (servicio web y servicio de base de datos) para su ejecución. La aplicación se llama GuestBook y necesita los dos siguientes servicios:

La aplicación guestbook es una aplicación web desarrollada en python que es servida por el puerto 5000/tcp. Utilizaremos la imagen roxsross12/guestbook.

Esta aplicación guarda la información en una base de datos no relacional redis, que utiliza el puerto 6379/tcp para conectarnos. Usaremos la imagen redis.

### Volúmenes

Si estudiamos la documentación de la imagen redis en Docker Hub, para que la información de la base de datos se guarde en un directorio /data del contenedor hay que ejecutar el proceso redis-server con los argumentos --appendonly yes.

`docker volume create guestbook_vol`   

### Redes 

La aplicación guestbook por defecto utiliza el nombre redis para conectarse a la base de datos, por lo tanto debemos nombrar al contenedor redis con ese nombre para que tengamos una resolución de nombres adecuada.

Los dos contenedores tienen que estar en la misma red y deben tener acceso por nombres (resolución DNS) ya que de principio no sabemos que ip va a coger cada contenedor. Por lo tanto vamos a crear los contenedores en la misma red:

`docker network create red_guestbook`



Para ejecutar los contenedores:

```

docker run -d --name redis --network red_guestbook -v guestbook_vol:/data redis redis-server --appendonly yes


docker run -d -p 8080:5000 --name guestbook --network red_guestbook roxsross12/guestbook

```


# Algunas observaciones:

1. No es necesario mapear el puerto de redis, ya que no vamos a acceder desde el exterior. Sin embargo la aplicación guestbook va a poder acceder a la base de datos porque están conectado a la misma red.

2. Al nombrar al contenedor de la base de datos con redis se crea una entrada en el DNS que resuelve ese nombre con la ip del contenedor. Como hemos indicado, por defecto, la aplicación guestbook usa ese nombre para acceder.

3. Si eliminamos el contenedor de redis y lo volvemos a crear podemos comprobar la persistencia de la información.

![docker-guestbox](./Doc/11-part1-guestbox-01.png?raw=true " docker-guestbox ")
![docker-guestbox](./Doc/11-part1-guestbox-02.png?raw=true " docker-guestbox ")




### Ejercicio 11 - Parte 2

## Aplicación de workdpress utilizando mariadb

docker network create red_wp
docker volume create vol_wp

docker run -d --name servidor_mysql \
              --network red_wp \
              -v vol_wp:/var/lib/mysql \
              -e "MYSQL_DATABASE=bd_wp" \
              -e "MYSQL_USER=user_wp" \
              -e "MYSQL_PASSWORD=12345678" \
              -e "MYSQL_ROOT_PASSWORD=admin" \
              -p 3306:3306 \
              mariadb

docker run -d --name wp \
              --network red_wp \
              -v vol_wp:/var/www/html/wp-content \
              -e "WORDPRESS_DB_HOST=servidor_mysql" \
              -e "WORDPRESS_DB_USER=user_wp" \
              -e "WORDPRESS_DB_PASSWORD=12345678" \
              -e "WORDPRESS_DB_NAME=bd_wp" \
              -p 80:80 \
              wordpress
  
![docker-wordpress](./Doc/11-part2-wordpress-01.png?raw=true " docker-wordpress ")
![docker-wordpress](./Doc/11-part2-wordpress-02.png?raw=true " docker-wordpress ")

