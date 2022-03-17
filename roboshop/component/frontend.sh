#!/bin/bash

source component/common.sh

Print "Install Nginx Webserver -START "
 yum install nginx -y &>>$LOG_FILE
 StatCheck $?

Print "Enable nginx Webserver -START"
 systemctl enable nginx &>>$LOG_FILE
StatCheck $?

Print "Start nginx Webserver -START "
systemctl start nginx &>>$LOG_FILE
StatCheck $?

Print "Start Downloading Frontend Application from git -START "
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print "Deploy in Nginx Default Location. -START"
 rm -rf /usr/share/nginx/html/*\
 StatCheck $?

cd /usr/share/nginx/html/

Print "unzip the package"
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* .
StatCheck $?

Print "configuration of roboshop.config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
StatCheck $?

Print "Restart nginx Server"
systemctl restart nginx && systemctl enable nginx &>>$LOG_FILE
StatCheck $?