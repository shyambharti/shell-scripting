#!/bin/bash

echo -e "\e[32m Setup MongoDB repos. -START  \e[0m"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
if [ "$?" -eq 0 ]
   then
     echo -e "\e[32mSetup MongoDB repos. Successful   \e[0m"
   else
     echo -e "\e[31mSetup MongoDB repos. NOT Successful  \e[0m"
     exit 1
  fi

echo -e "\e[32mInstall mongodb  -START  \e[0m"
 yum install -y mongodb-org
 if [ "$?" -eq 0 ]
   then
     echo -e "\e[32mInstall mongodb Successful   \e[0m"
   else
     echo -e "\e[31mInstall mongodb NOT Successful  \e[0m"
     exit 1
  fi

echo -e "\e[32mEnable nginx Webserver -START  \e[0m"
 systemctl enable mongod
if [ "$?" -eq 0 ]
   then
     echo -e "\e[32mEnable mongod Successful   \e[0m"
   else
     echo -e "\e[31mEnable mongod NOT Successful  \e[0m"
     exit 2
  fi

echo -e "\e[32mStart mongod -START  \e[0m"
systemctl start mongod
if [ "$?" -eq 0 ]
    then
      echo -e "\e[32mStart mongod Successful   \e[0m"
    else
      echo -e "\e[31mStart mongod NOT Successful  \e[0m"
      exit 3
fi

echo -e "\e[32mStart Downloading schema from git -START  \e[0m"
 curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
if [ "$?" -eq 0 ]
    then
      echo -e "\e[32mDownloading mongod schema from git Successful   \e[0m"
    else
      echo -e "\e[31mDownloading mongod schema from git NOT Successful  \e[0m"
      exit 4
fi


echo -e "\e[32mDeploy in unzip Default Location. -START  \e[0m"
 cd /tmp
 unzip mongodb.zip
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32mUnzip mongod schema Successfully.   \e[0m"
  else
    echo -e "\e[31mUnzip nongod schema NOT Successfully.  \e[0m"
    exit 5
 fi

echo -e "\e[32m loaded for the application 1 \e[0m"
 cd mongodb-main
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m cd mongodb-main Successful.\e[0m"
  else
    echo -e "\e[31m*Move cd mongodb-main NOT Successful.\e[0m"
    exit 6
 fi

echo -e "\e[32m loaded for the application 1 \e[0m"
mongo < catalogue.js
if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m loaded for application 1. -SUCCESSFUL  \e[0m"
  else
    echo -e "\e[31m loaded for application 1. -NOT SUCCESSFUL\e[0m"
    exit 6
 fi

echo -e "\e[32m loaded for the application 2 \e[0m"
mongo < users.js
 if [ "$?" -eq 0 ]
  then
    echo -e "\e[32m Loaded for application 2 -SUCCESSFUL   \e[0m"
  else
    echo -e "\e[31m Loaded for application 2 -NOT SUCCESSFUL  \e[0m"
    exit 7
 fi