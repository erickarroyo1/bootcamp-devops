### Se construye la app

`docker build -t app-python:1.0.0 . `

`docker build -t app:python:1.0.0 -f `

docker run -d -p 8000:8000 app-python:1.0.0

# Probando conexión

curl localhost:8000
```
> curl localhost:8001
<!DOCTYPE html>
<html lang="en">
<body>

<h2>Hotname: e8a97746772c</h2>
<p>IP Address: 172.17.0.7</p>

</body>
</html>%  
```
### Se construye el Consumer

# Modificar IP Linea 11 consumer.py como cliente ya que la IP está configurada en el código y es la ip del servivicio que corre en el app.

docker build -t consumer-python:1.0.0 .

# Probando el app con el cliente consumer.py


docker run -it -e LOCAL=true consumer-python:1.0.0

```
> docker run -e LOCAL=true -it consumer-python:1.0.1
Run container on local
Response OK!!!
Response OK!!!
Response OK!!!
Response OK!!!
Response OK!!!
```


 ### ENTREGABLES
 
 
![docker build app](./Doc/06-docker-build-app.png?raw=true " docker build app ")

![docker build consumer](./Doc/06-docker-build-consumer.png?raw=true " docker build consumer ")

![docker images](./Doc/06-docker-images.png?raw=true " docker images ")



```
docker run -d -p  8000:8000 --name app-python app-python:erick-0.0.1
docker run -it -e LOCAL=true consumer-python:erick-0.0.1
```



![docker app running](./Doc/06-dockerApp-running.png?raw=true " docker app running ")

![06-dockerConsumer-running-consuming-dockerApp](./Doc/06-dockerConsumer-running-consuming-dockerApp.png?raw=true " 06-dockerConsumer-running-consuming-dockerApp ")



