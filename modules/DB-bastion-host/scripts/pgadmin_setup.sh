#!/bin/bash
# Update the EC2 instance
yum update -y


amazon-linux-extras install docker -y


service docker start


systemctl enable docker

usermod -aG docker ec2-user


newgrp docker


docker run -d \
  --name s8tia \
  -p 3035:80 \
  -e 'PGADMIN_DEFAULT_EMAIL=admin@example.com' \
  -e 'PGADMIN_DEFAULT_PASSWORD=admin123' \
  dpage/pgadmin4

docker ps
