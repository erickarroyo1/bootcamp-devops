region  = "eu-west-1"
profile = "Test-LandindZone"


#-------------------Buckets Name-------------
#--------------------------------------------

buckets = [
  { #0 bucket_name erick-csv-loader-bucket
    bucket-name = "erick-csv-loader-bucket"
  },
  { #1 bucket_name erick-code-backend-bucket
    bucket-name = "erick-code-backend-bucket"
}]


tagging = {
  Name      = "S3-Bootcamp-Desafio3-erick-2022"
  Terraform = "True"
  Owner     = "Erick Arroyo - Cybersecurity"
}

dynamodb_table_name = "customer"





