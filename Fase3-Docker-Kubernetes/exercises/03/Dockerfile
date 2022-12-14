#Imagen que voy a utilizar como base
FROM nginx

#Etiquetado
LABEL project="bootcamp-web"

#Como metadato, indicamos que el contenedor utiliza el puerto 80
EXPOSE 80

#Modificaciones sobre la imagen que he utilizado como base. 
#copiamos el contenido de WEB en la ruta especificada.
COPY web/ /usr/share/nginx/html/