#!/bin/bash

source component/common.sh

Print "bash setup for nodes js"
 curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>$LOG_FILE
 StatCheck $?

Print "Installation nodes js"
 yum install nodejs gcc-c++ -y
StatCheck $?

Print "add user if user not existing in system"
id ${APP_USER} &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  useradd ${APP_USER} &>>${LOG_FILE}
fi

Print "extract catalogue"
 curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print "cleanup old content"
rm -rf /home/${APP_USER}/cataloque &>>$LOG_FILE
StatCheck $?

Print "unzip catalogue"
cd /home/${APP_USER} &>>$LOG_FILE && unzip /tmp/catalogue.zip &>>$LOG_FILE &&  mv catalogue-main catalogue &>>$LOG_FILE
StatCheck $?

Print "install npm"
cd /home/roboshop/catalogue &>>$LOG_FILE && npm install &>>$LOG_FILE
StatCheck $?

Print "app user permission"
chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
StatCheck $?

Print "systemd setting"
sed -i -e 's/MONGO_DNSNAME/mongodb.ayushyam.internal/' \
/home/roboshop/catalogue/systemd.service &>>${LOG_FILE} && mv /home/roboshop/catalogue/systemd.service \
/etc/systemd/system/catalogue.service &>>${LOG_FILE}
StatCheck $?

Print "re-start catalogue"
systemctl daemon-reload &>>${LOG_FILE} && systemctl restart catalogue &>>${LOG_FILE} && systemctl enable catalogue &>>${LOG_FILE}
StatCheck $?
