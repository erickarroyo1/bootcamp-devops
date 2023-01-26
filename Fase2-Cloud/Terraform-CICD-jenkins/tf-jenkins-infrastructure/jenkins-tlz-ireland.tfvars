region = "eu-west-1"


profile                     = "Test-LandindZone"
az1                         = "eu-west-1a"
az2                         = "eu-west-1b"
keyname                     = "ssh-security-key"
pathpublickey               = "~/sshjenkins.pub"
size                        = "t3.large"
vpc-security-cidr           = "172.22.0.0/16"
security-vpc-subnet-public1 = "172.22.10.0/24"
security-vpc-subnet-public2 = "172.22.11.0/24"
bootstrap-jenkins           = "../jenkins-resources/user-data-jenkins.install.sh"
bucket-name                 = "bootcamp-s3-testing-2022-erick"
kms-name                    = "bootcamp-kms-testing-2022-erick"



