// jenkins instance

//Interfaces

resource "aws_network_interface" "fgt1-eth0" {
  description = "jenkins_port1"
  subnet_id   = aws_subnet.security-vpc-subnet-public1-az1.id
  #define provider
  provider = aws.bootcamp-tlz-account
}

// Security Groups attached to each Interface

resource "aws_network_interface_sg_attachment" "publicattachment" {
  depends_on           = [aws_network_interface.fgt1-eth0]
  security_group_id    = aws_security_group.public_allow.id
  network_interface_id = aws_network_interface.fgt1-eth0.id
  #define provider
  provider = aws.bootcamp-tlz-account
}


// Instance Jenkins-Bootcamp


resource "aws_instance" "jenkins" {
  ami               = var.ubuntu[var.region]
  instance_type     = var.size
  availability_zone = var.az1
  key_name          = var.keyname
  user_data         = file("${var.bootstrap-jenkins}")

  root_block_device {
    volume_type = "standard"
    volume_size = "30"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.fgt1-eth0.id
    device_index         = 0
  }


  tags = {
    Name      = "jenkins-bootcamp"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}

// EIP to jenkins 

resource "aws_eip" "jenkinsPublicIp" {
  depends_on = [aws_instance.jenkins]
  vpc        = true
  instance   = aws_instance.jenkins.id
  #define provider
  provider = aws.bootcamp-tlz-account
  tags = {
    Name      = "aws_eip-jenkins"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
}

#Resource Provision Exec to insert final configuration to jenkins

# resource "null_resource" "provisioner" {
#   count = "1"
#   depends_on        = [aws_instance.jenkins]

#   connection {
#     host        = aws_eip.jenkinsPublicIp.public_ip
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = "${file("/mnt/c/Users/ErickArroyo/Bootcamp-DevOps/Fase2-Cloud/Terraform-CICD-jenkins/tf-jenkins-infrastructure/ssh-security-keys")}"
#   }


#   provisioner "file" {
#     source      = "../jenkins-resources/create-jenkins-admin-user.sh"
#     destination = "/tmp/create-jenkins-admin-user.sh"
#   }

#   provisioner "file" {
#     source      = "../jenkins-resources/install-additional-plugins-jenkins.sh"
#     destination = "/tmp/install-additional-plugins-jenkins.sh"
#   }

#   # change permissions and execute the scripts

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/create-jenkins-admin-user.sh",
#       "chmod +x /tmp/install-additional-plugins-jenkins.sh",
#       "/tmp/create-jenkins-admin-user.sh",
#       "/tmp/install-additional-plugins-jenkins.sh"

#     ]
#   }



#   provider = null
# }