#!/bin/bash
 sudo yum install nginx -y
 sudo systemctl enable nginx
 sudo systemctl start nginx

 # curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
 # cd /usr/share/nginx/html
 # rm -rf *
 # unzip /tmp/frontend.zip
 # mv frontend-main/* .
 # mv static/* .
 # rm -rf frontend-main README.md
 # mv localhost.conf /etc/nginx/default.d/roboshop.conf
 # systemctl restart nginx