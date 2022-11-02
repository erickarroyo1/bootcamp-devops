

output "jenkinsPublicIp" {
  value = aws_eip.jenkinsPublicIp.public_ip
}

output "jenkins-instance-id" {
  value = aws_instance.jenkins.id
}

output "SecurityVPC" {
  value = aws_vpc.security-vpc.id
}

# to get the Cloud front URL if doamin/alias is not configured
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
