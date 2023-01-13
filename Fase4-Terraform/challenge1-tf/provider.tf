# Definir el provider de AWS

#1era caso: bad practice access_key/secret en el provider
#2caso: guardar las credenciales en .aws/credentials
# [default]
# aws_access_key_id=ASIA2EWXHJWIFQKGIQFL
# aws_secret_access_key=rNV+ZJlm8aA6kCTesjd0fQ4s8hR3lSRCipF66V1r
# aws_session_token=FwoGZXIvYXdzEH8aDEBQ+eQbpKK2CmP6HyK/AZlsNHrGjcL/tjPCLxpWrb5DscVMUjEhw/trtVuXGq+wbpU8o8+fS+Wy88KSvcuBJiWBtbugNeVxkHRikclrtHHo/J54KVbUaHlSysuHo2CKn/+WiaHTbs/TSyoCy6//8LCno3ggWEFMR2mnw9rY+ZZZEhWpGhPMjpAWHJSnm3l89+B1AIb0OsAc9TZc95AAzRcULxtbO9gt7iVZQsPf8qSweKvMOqHOgA3oQogrjR6Jax620zSbYq5FrTvVEtOaKMWGgp4GMi3GQ0IHqzALMuK+dGxo/ivZO8xRyO19HDasxD8tm2T5UpR4b9kLRg8Mc4Yb8mM=
#3er Caso: hacer un script
#!/bin/bash
# export AWS_ACCESS_KEY_ID="anaccesskey"
# export AWS_SECRET_ACCESS_KEY="asecretkey"
# export AWS_SESSION_TOKEN="token"
# export AWS_REGION="us-east-1"
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
}