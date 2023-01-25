### publica

resource "aws_security_group" "publica" {
  name = "${var.app}-publica-sg"
  vpc_id = module.vpc.vpc_id

   ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso Http"
      from_port = 80
      to_port = 80
      protocol = "TCP"
    } 
    ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso Https"
      from_port = 443
      to_port = 443
      protocol = "TCP"
    } 
    ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso ssh"
      from_port = 22
      to_port = 22
      protocol = "TCP"
    } 
    egress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "All trafic"
      from_port = 0
      to_port = 0
      protocol = "-1"
    }
    tags = local.common_tags
}
### security group privado para bd y ssh
resource "aws_security_group" "privada" {
  name = "${var.app}-privada-sg"
  vpc_id = module.vpc.vpc_id

   ingress {
      security_groups = [aws_security_group.publica.id]
      description = "Acceso BD RDS"
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
    } 
    ingress {
      security_groups = [aws_security_group.publica.id]
      description = "Acceso ssh"
      from_port = 22
      to_port = 22
      protocol = "TCP"
    } 
    egress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "All trafic"
      from_port = 0
      to_port = 0
      protocol = "-1"
    }
    tags = local.common_tags
}

### security group alb 
resource "aws_security_group" "alb" {
  name = "${var.app}-alb-sg"
  vpc_id = module.vpc.vpc_id

   ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso Http"
      from_port = 80
      to_port = 80
      protocol = "TCP"
    } 
    ingress {
      cidr_blocks = ["0.0.0.0/0" ]
      description = "Acceso Https"
      from_port = 443
      to_port = 443
      protocol = "TCP"
    } 
    egress {
      cidr_blocks = ["0.0.0.0/0"]
      description = "All trafic"
      from_port = 0
      to_port = 0
      protocol = "-1"
    }
    tags = local.common_tags
}