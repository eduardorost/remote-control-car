#!/bin/bash

set -e
set -x

yum update -y
yum install -y git curl
amazon-linux-extras install ansible2 -y

curl -sL https://rpm.nodesource.com/setup_14.x | bash -
yum install nodejs -y

chmod 400 /home/ec2-user/.ssh/id_rsa

ansible-playbook /home/ec2-user/app.yaml