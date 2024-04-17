#!/bin/bash
sudo apt-get update
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
sudo apt-get install -qq collectd
sudo chmod 644 /var/log/syslog 
sudo wget https://amazoncloudwatch-agent-eu-west-2.s3.eu-west-2.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:AmazonCloudWatch-Ubuntu
sudo systemctl restart  amazon-cloudwatch-agent.service
