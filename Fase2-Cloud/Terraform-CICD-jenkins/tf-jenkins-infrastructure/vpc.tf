// AWS VPC - Security Centralized inpection  VPC
resource "aws_vpc" "security-vpc" {
  cidr_block           = var.vpc-security-cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  #enable_classiclink   = false
  instance_tenancy = "default"
  tags = {
    Name      = "Bootcamp VPC"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}

resource "aws_subnet" "security-vpc-subnet-public1-az1" {
  vpc_id            = aws_vpc.security-vpc.id
  cidr_block        = var.security-vpc-subnet-public1
  availability_zone = var.az1
  tags = {
    Name      = "security-vpc-subnet-public1-az1"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}
//
resource "aws_subnet" "security-vpc-subnet-public2-az2" {
  vpc_id            = aws_vpc.security-vpc.id
  cidr_block        = var.security-vpc-subnet-public2
  availability_zone = var.az2
  tags = {
    Name      = "security-vpc-subnet-public2-az2"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}
