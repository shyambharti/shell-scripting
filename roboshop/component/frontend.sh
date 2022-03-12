#!/bin/bash

echo -e "\e[32mInstall Nginx Webserver -START  \e[0m"
 yum install nginx -y
 if [ "$?" -eq 0 ]
   then
     echo -e "\e[32mInstall Nginx Webserver Successful   \e[0m"
   else
     echo -e "\e[31mInstall Nginx Webserver NOT Successful  \e[0m"
     exit 1
  fi

echo -e "\e[32mEnable nginx Webserver -START  \e[0m"
 systemctl enable nginx
if [ "$?" -eq 0 ]
   then
     echo -e "\e[32mEnable nginx Webserver Successful   \e[0m"
   else
     echo -e "\e[31mEnable nginx Webserver NOT Successful  \e[0m"
     exit 2
  fi

echo -e "\e[32mStart nginx Webserver -START  \e[0m"
systemctl start nginx
if [ "$?" -eq 0 ]
    then
      echo -e "\e[32mStart nginx Webserver Successful   \e[0m"
    else
      echo -e "\e[31mStart nginx Webserver NOT Successful  \e[0m"
      exit 3
fi

echo -e "\e[32mStart Downloading Frontend Application from git -START  \e[0m"
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if [ "$?" -eq 0 ]
    then
      echo -e "\e[32mDownloading Frontend Application from git Successful   \e[0m"
    else
      echo -e "\e[31mDownloading Frontend Application from git NOT Successful  \e[0m"
      exit 4
fi


echo -e "\e[32mDeploy in Nginx Default Location. -START  \e[0m"
 cd /usr/share/nginx/html
 rm -rf *
 unzip /tmp/frontend.zip
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32mUnzip frontend.zip Successfully.   \e[0m"
  else
    echo -e "\e[31mUnzip frontend.zip NOT Successfully.  \e[0m"
    exit 5
 fi
 sudo mv frontend-main/* .
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32mMove frontend-main Successful.\e[0m"
  else
    echo -e "\e[31m*Move frontend-main NOT Successful.\e[0m"
    exit 6
 fi

mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ "$?" -eq 0 ]
  then
    echo -e "\e[32mDeploy in Nginx Default Location. -SUCCESSFUL  \e[0m"
  else
    echo -e "\e[31mDeploy in Nginx Default Location. -NOT SUCCESSFUL\e[0m"
    exit 6
 fi


echo -e "\e[32mRestart nginx Server\e[0m"
systemctl restart nginx
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32mRestart nginx Server -SUCCESSFUL   \e[0m"
  else
    echo -e "\e[31mRestart nginx Server -NOT SUCCESSFUL  \e[0m"
    exit 7
 fi