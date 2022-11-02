

output "jenkinsPublicIp" {
  value = aws_eip.jenkinsPublicIp.public_ip
}

output "jenkins-instance-id" {
  value = aws_instance.jenkins.id
}

output "SecurityVPC" {
  value = aws_vpc.security-vpc.id
}

