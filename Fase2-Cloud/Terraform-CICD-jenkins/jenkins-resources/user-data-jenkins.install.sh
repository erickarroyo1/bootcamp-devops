#!/bin/bash

DOMAIN=$(curl icanhazip.com)
SSLIP="$DOMAIN.sslip.io"
sudo apt update -y
sudo apt install -y wget unzip zip nginx openjdk-11-jdk java-1.8.0-openjdk-devel python
sudo systemctl start nginx
sudo mkdir -p /var/www/jenkins/html
sudo chown -R $USER:$USER /var/www/jenkins/html
sudo chmod -R 755 /var/www/jenkins
cat > jenkins <<EOF
server {
        listen 80;
        listen [::]:80;
        root /var/www/jenkins/html;
        index index.html index.htm index.nginx-debian.html;
        server_name $SSLIP www.$SSLIP;
        location / {
                #try_files $uri $uri/ =404;
                proxy_pass    http://$SSLIP:8080;
                proxy_read_timeout  90s;
        }
}
EOF
sudo mv jenkins /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
sudo systemctl restart nginx
sudo apt install -y certbot python3-certbot-nginx unzip
sudo certbot --nginx --register-unsafely-without-email --agree-tos -d "${SSLIP}" --cert-name jenkins
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install -y default-jre
sudo apt install -y jenkins 
sudo systemctl start jenkins.service


