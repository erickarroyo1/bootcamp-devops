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
  depends_on        = [aws_instance.jenkins]
  vpc               = true
  network_interface = aws_network_interface.fgt1-eth0.id
  #define provider
  provider = aws.bootcamp-tlz-account
  tags = {
    Name      = "aws_eip-jenkins"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
}
