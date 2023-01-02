1. editar el archivo ~/.kube/config en la línea 5 por el puerto 6443
2. cat ~/.kube/config | grep certificate-authority-data
3. echo 'cert-step-2' | base64 -d > /etc/kubernetes/pki/ca-authority.crt
4. # Restart dockers with 'exited' error after apply a 'docker ps -a | grep Exited' command:
5. 'docker restart containerIDs' with exited errors to fix api-server and then execute 'kubectl get po -n kube-system' to see container in execution.
6. # Solve CoreDNS Deployment: 
   1. Podemos editar los deployments, pods, configmaps y lo que necesitemos una vez el kubectl esté funcional por el api-server de kubernetes y podamos editar los deploys del namespace kube-system. Ejemplos:
    ```
    kubectl edit configmap coredns -n kube-system
    kubectl edit configmap coredns -n kube-system -o yaml
    kubectl set image --namespace kube-system deployment.apps/coredns \
    coredns=602401143452.dkr.ecr.region-code.amazonaws.com/eks/coredns:v1.8.7-eksbuild.2
    ```
   2. Con el siguiente comando vamos a modificar la línea 44 con la imágen correspondiente "k8s.gcr.io/coredns/coredns:v1.8.6" para solventar el problema del CoreDns:

    ```
    kubectl edit deployment coredns -n kube-system
    ```

   3. Para validar que se esté ejecutando:
   
    ```
     kubectl get pods -o wide -n kube-system
    ```

7. # Nodo 1 con problemas:
   1. kubectl get nodes
   
    ```
   NAME           STATUS                     ROLES                  AGE   VERSION
   controlplane   Ready                      control-plane,master   13m   v1.23.0
   node01         Ready,SchedulingDisabled   <none>                 13m   v1.23.
    ```
   2. para dejar el nodo en estatus ready, debemos ejecutar el comando '' dado a su estado actual:'SchedulingDisabled'
    ```
    kubectl uncordon node01
    ```

8. desplegar el manifest.

9. copiar los archivos con scp:
    ```
    scp /media/* node01:/web

    ```

## Evidencia: 

  ![Ejecución challenge-2 completado](./Doc/challenge02-ok.png?raw=true " Ejecución challenge-2 completado ")
