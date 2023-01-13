variable "access_key" {
  type    = string
  default = ""
}

variable "secret_key" {
  type    = string
  default = ""
}

variable "token" {
  type    = string
  default = ""
}

variable "app" {
  type    = string
  default = "nginx"
}

variable "ami" {
  type    = string
  default = "ami-0fe472d8a85bc7b0e"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "owner" {
  type        = string
  description = "owner of deployer's devops"
  default     = "Erick Arroyo"
}

variable "project" {
  type        = string
  description = "project name"
  default     = "challenge-1-tf"
}

variable "bootcamp" {
  type        = string
  description = "bootcamp for devops engineer"
  default     = "bootcamp-devops"
}

variable "instance_count" {
  type        = number
  description = "the number of instances"
  default     = 2
}


variable "bootstrap-bootcamp-server" {
  type        = string
  description = "path to bootstrap script - user-data"
  default     = "./bootstrap/bootstrap-server.sh"
}
