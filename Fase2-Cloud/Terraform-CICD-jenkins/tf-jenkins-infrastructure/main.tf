// Creating Internet Gateway for Security VPC

resource "aws_internet_gateway" "security-vpc-igw" {
  vpc_id = aws_vpc.security-vpc.id
  tags = {
    Name      = "secuity-vpc-igw"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}


// Security VPC Public and Private Route Tables

resource "aws_route_table" "security-vpc-public-rtb" {
  vpc_id = aws_vpc.security-vpc.id

  tags = {
    Name      = "security-vpc-public-rtb"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}



# Security VPC Routes

resource "aws_route" "security-vpc-default-route" {
  route_table_id         = aws_route_table.security-vpc-public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.security-vpc-igw.id
  #define provider
  provider = aws.bootcamp-tlz-account
}

// Security VPC Route Table Associations



resource "aws_route_table_association" "securityPublicVpcAssociateAz1" {
  subnet_id      = aws_subnet.security-vpc-subnet-public1-az1.id
  route_table_id = aws_route_table.security-vpc-public-rtb.id
  #define provider
  provider = aws.bootcamp-tlz-account
}


resource "aws_route_table_association" "securityPublicVpcAssociateAz2" {
  subnet_id      = aws_subnet.security-vpc-subnet-public2-az2.id
  route_table_id = aws_route_table.security-vpc-public-rtb.id
  #define provider
  provider = aws.bootcamp-tlz-account
}

