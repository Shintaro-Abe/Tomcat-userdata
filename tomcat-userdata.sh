#!/bin/bash

useradd -r -s /sbin/nologin tomcat

yum update
yum install -y httpd
systemctl start httpd
systemctl enable httpd

dnf update
dnf install -y java

sudo -u ec2-user -i wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz
sudo -u ec2-user -i tar -zxvf apache-tomcat-10.0.23.tar.gz
mv /home/ec2-user/apache-tomcat-10.0.23 /usr/local/src/apache-tomcat-10.0.23
chown -R tomcat:tomcat /usr/local/src/apache-tomcat-10.0.23

ln -s /usr/local/src/apache-tomcat-10.0.23 /usr/local/src/tomcat
chown -R tomcat:tomcat /usr/local/src/tomcat

service_content="[Unit]
Description=Tomcat Web Server
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="CATALINA_BASE=/usr/local/src/tomcat"
Environment="CATALINA_HOME=/usr/local/src/tomcat"
Environment="CATALINA_PID=/usr/local/src/tomcat/temp/tomcat.pid"
ExecStart=/usr/local/src/tomcat/bin/startup.sh
ExecStop=/usr/local/src/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target"

echo "$service_content" > /etc/systemd/system/tomcat.service

systemctl daemon-reload
systemctl enable tomcat.service

sudo -u ec2-user -i echo export CATALINA_HOME=/usr/local/src/tomcat >> /home/ec2-user/.bash_profile
sudo -u ec2-user -i source /home/ec2-user/.bash_profile
systemctl start tomcat.service