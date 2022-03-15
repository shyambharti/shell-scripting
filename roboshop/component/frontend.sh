#!/bin/bash

Print "Install Nginx Webserver -START "
 yum install nginx -y
 StatCheck $?

Print "Enable nginx Webserver -START"
 systemctl enable nginx
StatCheck $?

print "Start nginx Webserver -START "
systemctl start nginx
StatCheck $?

print "Start Downloading Frontend Application from git -START "
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
StatCheck $?


print "Deploy in Nginx Default Location. -START"
 cd /usr/share/nginx/html
 rm -rf *
 unzip /tmp/frontend.zip
 StatCheck $?

 sudo mv frontend-main/* .
 StatCheck $?

mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
StatCheck $?

print "Restart nginx Server"
systemctl restart nginx
StatCheck $?