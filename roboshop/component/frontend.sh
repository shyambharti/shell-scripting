#!/bin/bash
 yum install nginx -y
 systemctl enable nginx
 systemctl start nginx

 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
 cd /usr/share/nginx/html
 rm -rf *
 unzip /tmp/frontend.zip
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
 sudo mv frontend-main/* .
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
mv static/* .
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
rm -rf frontend-main README.md
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
mv localhost.conf /etc/nginx/default.d/roboshop.conf
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
systemctl restart nginx
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi