- crear archivo values.tfvars 
- Declarar las variables "clave/valor"

terraform plan -var-file values.tfvars -out plan.out
terraform apply "plan.out"
terraform plan -var-file values.tfvars 
terraform apply 

- Configurar el backend.tf 
- Crear un s3
- crear una dynamodb

wordpress/terraform.tfstate
