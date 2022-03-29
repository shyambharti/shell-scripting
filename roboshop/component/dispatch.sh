#!/bin/bash

source components/common.sh


Print "Installation golang"
 yum install golang -y
StatCheck $?

Print "add user if user not existing in system"
id ${APP_USER} &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  useradd ${APP_USER} &>>${LOG_FILE}
fi

Print "extract dispatch"
 curl -L -s -o /tmp/dispatch.zip "https://github.com/roboshop-devops-project/dispatch/archive/refs/heads/main.zip" &>>$LOG_FILE
StatCheck $?

Print "cleanup old content"
rm -rf /home/${APP_USER}/dispatch &>>$LOG_FILE
StatCheck $?

Print "unzip dispatch"
cd /home/${APP_USER} &>>$LOG_FILE && unzip /tmp/dispatch.zip &>>$LOG_FILE &&  mv dispatch-main dispatch &>>$LOG_FILE
StatCheck $?

Print "install npm"
cd /home/roboshop/dispatch &>>$LOG_FILE && go mod init dispatch && go get  && go build &>>$LOG_FILE
StatCheck $?

Print "app dispatch permission"
chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
StatCheck $?

Print "re-start dispatch"
systemctl daemon-reload &>>${LOG_FILE} && systemctl start dispatch &>>${LOG_FILE} && systemctl enable dispatch &>>${LOG_FILE}
StatCheck $?