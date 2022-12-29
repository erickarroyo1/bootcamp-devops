## Construcción del docker 


    #app

docker build -t app-consumer-k8s-app:erick-0.1.1  .

docker images

docker tag app-consumer-k8s-app:erick-0.1.1 191006/app-consumer-k8s-app:erick-0.1.1

docker login

docker push 191006/app-consumer-k8s-app:erick-0.1.1

    #consumer

docker build -t app-consumer-k8s-consumer:erick-0.1.1  .

docker images

docker tag app-consumer-k8s-consumer:erick-0.1.1 191006/app-consumer-k8s-consumer:erick-0.1.1

docker login

docker push 191006/app-consumer-k8s-consumer:erick-0.1.1

    Si se requiere una nueva versión, debemos hacer un nuevo build, etiquetarlo y subirlo al dockerhub. Teoría de inmutabilidad, no se sobreescribe una versión


 # ejecución de kubernetes

kubectl apply -f consumer-k8s.yml
kubectl apply -f app-k8s.yml
kubectl exec --namespace development -it app-k8s-6cdb474b6-68729 -- /bin/sh
kubectl exec --namespace development -it consumer-k8s-7fd8c76fd4-2464n -- /bin/sh

# tshoot con servicios 

kubectl get svc 
kubectl delete svc 
#muestra los servicios activos
kubectl get svc -n development
#luego de haber creado el servicio, el minikube lo disponibiliza a través del puerto definido.
minikube service service-app -n development

|-------------|-------------|-------------|-----------------------------|
|  NAMESPACE  |    NAME     | TARGET PORT |             URL             |
|-------------|-------------|-------------|-----------------------------|
| development | service-app |        8000 | http://192.168.59.100:30000 |
|-------------|-------------|-------------|-----------------------------|


si por el contrario solo queremos hacer testing, podemos hacer un portforward del puerto del contenedor a mi local. Impotante que sean puertos de un rango alto fuera de los definidos como estandar ports

kubectl port-forward pod/<pod-name> local-port:pod-port

kubectl port-forward pod/app-k8s-f85fd7865-ctrn4 30500:8000 -n development  

´´´
Forwarding from 127.0.0.1:30500 -> 8000
Forwarding from [::1]:30500 -> 8000
Handling connection for 30500
´´´

#test
curl localhost:30500

# Tshoot con contenedor utiizando exec para ingresar al container.

kubectl get po -A
kubectl exec --namespace development -it consumer-k8s-7fb9cb5b4c-89dl9 -- /bin/sh

    Estando en el contenedor ejecutamos el comando para colocar la variable LOCAL en tue:

    export LOCAL=tue

    luego ejecutamos el comando python ./consumer.py y debe responder OK en su ejecución cuando alcanza el serviceNodePort a través de Minikube

## Evidencia de funcionamiento:

![kubernetes en ejecución](./response-ok.png?raw=true " kubernetes en ejecución ")



![k get po en ejecución](./k-get-po.png?raw=true " k get po en ejecución")