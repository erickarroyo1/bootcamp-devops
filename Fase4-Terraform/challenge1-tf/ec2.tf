resource "aws_instance" "bootcamp-servers" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.az_a.id
  vpc_security_group_ids = [aws_security_group.grupo_seguridad.id]
  tags                   = local.common_tags
  user_data              = file("${var.bootstrap-bootcamp-server}")
}
