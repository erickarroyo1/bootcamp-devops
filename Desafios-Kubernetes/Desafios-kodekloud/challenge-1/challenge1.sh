#!/bin/bash
#Editamos el manifiesto de kubernetes
cat <<EOF >  jekyll-manifest.yml
--- #POD
apiVersion: v1 
kind: Pod
metadata:
  name: jekyll
  namespace: development
  labels:
    run: jekyll
spec:
  containers:
    - name: jekyll
      image: kodekloud/jekyll-serve
      volumeMounts:
        - mountPath: /site
          name: site
  initContainers:
    - name: copy-jekyll-site
      image: kodekloud/jekyll
      command: [ "jekyll", "new", "/site" ]
      volumeMounts:
        - mountPath: /site
          name: site
  volumes:
    - name: site
      persistentVolumeClaim:
        claimName: jekyll-site
  
--- #Role

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer-role
  namespace: development
rules:
  - apiGroups:
        - ""
        - apps
        - autoscaling
        - batch
        - extensions
        - policy
        - rbac.authorization.k8s.io
    resources:
      - namespaces
      - pods
      - persistentvolumeclaims
      - services
    verbs: ["*"]

--- #Role Binding

apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
# You need to already have a Role named "pod-reader" in that namespace.
kind: RoleBinding
metadata:
  name: developer-rolebinding
  namespace: development
subjects:
# You can specify more than one "subject"
- kind: User
  name: martin # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: developer-role # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io

--- #Node Service


apiVersion: v1
kind: Service
metadata:
  name: jekyll
  namespace: development
spec:
  selector:
    run: jekyll
  ports:
    - protocol: TCP
      nodePort: 30097
      port: 8080
      targetPort: 4000
  type: NodePort


--- #Jekyll PVC


apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jekyll-site
  namespace: development
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: local-storage
  resources:
    requests:
      storage: 1Gi



--- #Developer Context && Client

# kubectl config set-credentials martin --client-certificate /root/martin.crt --client-key /root/martin.key
# kubectl config set-context developer --cluster kubernetes --user martin
# kubectl config use-context developer

EOF

sleep 1
kubectl apply -f jekyll-manifest.yml
sleep 1
kubectl config set-credentials martin --client-certificate /root/martin.crt --client-key /root/martin.key
kubectl config set-context developer --cluster kubernetes --user martin
kubectl config use-context developer
sleep 1
kubectl get po -n development
