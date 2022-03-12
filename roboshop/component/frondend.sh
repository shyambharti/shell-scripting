#!/bin/bash
 #sudo yum install nginx -y
 #sudo systemctl enable nginx
 #sudo systemctl start nginx

 #sudo curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
 #sudo cd /usr/share/nginx/html
 #sudo rm -rf *
 #sudo unzip /tmp/frontend.zip
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
 sudo mv static/* .
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
 sudo rm -rf frontend-main README.md
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
 sudo mv localhost.conf /etc/nginx/default.d/roboshop.conf
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi
 sudo systemctl restart nginx
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m*Nginx Webserver restarted Successfully.   \e[0m"
  else
    echo -e "\e[31m*install nginx Not Successful.   \e[0m"
 fi