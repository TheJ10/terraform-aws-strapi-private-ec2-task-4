#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
docker run -d -p 1337:1337 --name strapi strapi/strapi
