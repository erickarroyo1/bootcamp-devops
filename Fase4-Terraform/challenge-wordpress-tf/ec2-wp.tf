resource "aws_instance" "wp_server" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.publica.id]
  key_name = aws_key_pair.server_key.key_name
  user_data = <<EOF
#! /bin/bash
yum update -y
yum install -y mysql
yum -y install telnet
yum install -y httpd
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
cd /var/www/html
wget https://wordpress.org/latest.tar.gz 
tar -xzf latest.tar.gz
sudo cp -r wordpress/*  /var/www/html/
chmod -R 755 wp-content
chown -R apache:apache wp-content
service httpd start
chkconfig httpd on
EOF
  tags = {
    Name = "wp-${var.app}-devops"
  }
}