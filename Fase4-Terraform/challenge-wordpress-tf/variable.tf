locals {
  common_tags = {
    Terraform = "true"
    Environment = var.env
    Owner = "DevOps Team"
    Project = "${var.app}-devops"
  }
}

variable "app" {}

variable "env" {}
### variables base de datos

variable "db_user" {}

variable "db_pass" {}

variable "db_name" {}

variable "instance_class" {}

### variables instancias ec2

variable "ami" {}

variable "instance_type" {}