#!/bin/bash

source component/common.sh

Print "Setup MongoDB repos. -START"
curl -s -o /etc/yum.repos.d/mongodb.repo "https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo" &>>$LOG_FILE
StatCheck $?

Print "Install mongodb "
 yum install -y mongodb-org &>>$LOG_FILE
StatCheck $?

Print "conf change in mongod.conf "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$LOG_FILE
StatCheck $?

Print "Enable mongodb "
 systemctl enable mongod && systemctl start mongod &>>$LOG_FILE
StatCheck $?


Print "Downloading mongodb schema from git"
 curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
StatCheck $?


Print "archive mongodb"
 cd /tmp && unzip -o mongodb.zip &>>$LOG_FILE
 StatCheck $?

Print "login in mongodb"
cd mongodb-main && mongo < catalogue.js && mongo < users.js &>>$LOG_FILE
StatCheck $?