## Aplicaciones multicontenedores
- contenedores
- images
- volumenes
- redes 

instalar docker-compose 
`Docker Compose version v2.12.1`

docker-compose.yml --> instrucciones y configuracion servicios

comandos basicos 

docker-compose build --> generar la imagen del servicios (exista el Dockerfile)

docker-compose up --> levantar el servicio "docker run" "primer plano"

docker-compose up -d --> levanta en 2do plano

docker-compose stop nombre_contenedor

docker-compose start nombre_contenedor

docker-compose down 


## Referencia: https://docs.docker.com/compose/compose-file/



The example application is composed of the following parts:

2 services, backed by Docker images: webapp and database
1 secret (HTTPS certificate), injected into the frontend
1 configuration (HTTP), injected into the frontend
1 persistent volume, attached to the backend
2 networks

```

services:
  frontend:
    image: awesome/webapp
    ports:
      - "443:8043"
    networks:
      - front-tier
      - back-tier
    configs:
      - httpd-config
    secrets:
      - server-certificate

  backend:
    image: awesome/database
    volumes:
      - db-data:/etc/data
    networks:
      - back-tier

volumes:
  db-data:
    driver: flocker
    driver_opts:
      size: "10GiB"

configs:
  httpd-config:
    external: true

secrets:
  server-certificate:
    external: true

networks:
  # The presence of these objects is sufficient to define them
  front-tier: {}
  back-tier: {}

```

## Referencia de comandos docker-compose 


https://docs.docker.com/engine/reference/commandline/compose_build/