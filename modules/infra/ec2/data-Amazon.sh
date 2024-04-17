#!/bin/bash
#yum update doestnt do anything, as system is already up to date.
sudo yum -y install collectd
#collectd in stopped status. its ok.
sudo chmod 644 /var/log/cloud-init.log
sudo wget https://amazoncloudwatch-agent-eu-west-2.s3.eu-west-2.amazonaws.com/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:AmazonCloudWatch-Amazon
#above command also restarts cw agent service