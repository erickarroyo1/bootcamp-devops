#vpc default

data "aws_vpc" "default" {
  default = true
}


data "aws_subnet" "az_a" {
  availability_zone = "us-east-1a"
}

data "aws_subnet" "az_b" {
  availability_zone = "us-east-1b"
}