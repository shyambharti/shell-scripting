#!/bin/bash
 #sudo yum install nginx -y
 #sudo systemctl enable nginx
 #sudo systemctl start nginx

 sudo curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
 sudo cd /usr/share/nginx/html
 sudo rm -rf *
 sudo unzip /tmp/frontend.zip
 sudo mv frontend-main/* .
 sudo mv static/* .
 sudo rm -rf frontend-main README.md
 sudo mv localhost.conf /etc/nginx/default.d/roboshop.conf
 sudo systemctl restart nginx