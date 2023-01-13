# Definir grupo de seguridad puerto 80 servidores
resource "aws_security_group" "grupo_seguridad" {
  name   = "${var.app}-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All trafic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

#grupo de seguridad ALB
resource "aws_security_group" "alb" {
  name   = "${var.app}-alb-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "All trafic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}