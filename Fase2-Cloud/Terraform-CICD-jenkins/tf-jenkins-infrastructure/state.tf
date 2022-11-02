terraform {
  required_version = ">= 0.14, < 1.3"
  backend "s3" {
    bucket         = "lulobank-terraform-projects-sec"
    key            = "bootcamp-erick/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "lulobank-terraform-lock-projects-sec"
    encrypt        = true
    profile        = "shared-services"
  }
}