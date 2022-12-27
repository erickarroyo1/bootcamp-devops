## Kodecloud challenge 1

Se debe crear cada componente por separado (role, user, rolebinding, pod, service, PCV volume y asi mismo ekecutar comandos para crear los contextos  necesarios para que "mmartin" pueda obtener acceso con sus credeciales utilizando los roles creados y accediendo a la infraestructura desplegada.)

      Response: "pod/jekyll created"

# TSHOOT
```      
   #ejecución en local 
   minikube start
```


 
```
   #ejecuta el pod
   kubectl apply -f jekyll.manifest.yml
   #muestra la ejecución del pod
   kubectl get po -n development
   #elimina el pod 
   kubectl delete pods jekyll -n development 
   #muestra todos los pods
   kubectl get po -A
```      

# ceating role and role binding

REF: 
a. https://kubernetes.io/docs/reference/access-authn-authz/rbac/
b. https://devopscube.com/create-kubernetes-role/
 
# Client: Se configura el kube/config file ubicado en ~/.kube/config ejecutando solo los siguientes comandos para agregar el contexto del usuario martin como developer y las credenciales de acceso como cliente.

```  

--- #Developer Context && Client

kubectl config set-credentials martin --client-certificate /root/martin.crt --client-key /root/martin.key
kubectl config set-context developer --cluster kubernetes --user martin
kubectl config use-context developer

```  

### Evidencias de funcionalidad.

  ![Challenge-1-completado](./Doc/challenge1-completed.png?raw=true " Challenge-1-completado ")

### Ejecución con script

```  

git clone https://github.com/erickarroyo1/bootcamp-devops.git
cd bootcamp-devops/Desafio-kodekloud/challenge-1 
chmod +x ./challenge1.sh
./challenge1.sh


``` 

  ![Ejecución con script completado](./Doc/Ejeccion_script_challenge01.png?raw=true " Ejecución con script completado ")





     