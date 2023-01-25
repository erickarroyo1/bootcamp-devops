output "vpc" {
  description   = "Vpc ID"
  value         = module.vpc.vpc_id
}

output "sg_publica" {
  description = "security group publica"
  value = aws_security_group.publica.id
}

output "sg_privada" {
  description = "security group privada"
  value = aws_security_group.privada.id
}

output "sg_alb" {
  description = "security group alb"
  value = aws_security_group.alb.id
}

output "endpoint_rds" {
  description = "endpoint RDS"
  value = aws_db_instance.wordpressdb.endpoint
}

output "ec2_bastion" {
  description = "Ip Publica bastion"
  value = "ssh -i bootcamp-key.pem ec2-user@${aws_instance.bastion.public_ip}"
}

output "ec2_wp" {
  description = "Ip Publica bastion"
  value = "ssh -i bootcamp-key.pem ec2-user@${aws_instance.wp_server.public_ip}"
}

output "ec2_wp_dns_public" {
  description = "dns publica wordpress"
  value = "http://${aws_instance.wp_server.public_dns}"
}

output "dns_alb" {
  description = "endpoint alb"
  value = "http://${aws_lb.alb.dns_name}"
  
}