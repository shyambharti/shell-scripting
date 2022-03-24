#!/bin/bash

source component/common.sh

Print "bash setup for nodes js"
 curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>"${LOG_FILE}"
 StatCheck $?

Print "Installation nodes js"
 yum install nodejs gcc-c++ -y
StatCheck $?


Print "add user if user not existing in system"
id ${APP_USER} &>>"${LOG_FILE}"
if [ $? -ne 0 ]; then
  useradd ${APP_USER} &>>"${LOG_FILE}"
fi

Print "extract user"
 curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip" &>>"${LOG_FILE}"
StatCheck $?

Print "cleanup old content"
rm -rf /home/${APP_USER}/user &>>"${LOG_FILE}"
StatCheck $?

Print "unzip user"
cd /home/${APP_USER} &>>"${LOG_FILE}" && unzip /tmp/user.zip &>>"${LOG_FILE}" &&  mv user-main user &>>"${LOG_FILE}"
StatCheck $?

Print "install npm"
cd /home/roboshop/user &>>"${LOG_FILE}" && npm install &>>"${LOG_FILE}"
StatCheck $?

Print "systemd setting"
sed -i -e 's/REDIS_ENDPOINT/redis.ayushyam.internal/'  \
       -e 's/MONGO_ENDPOINT/mongodb.ayushyam.internal/' \
            /home/roboshop/user/systemd.service &>>${LOG_FILE} && mv /home/roboshop/user/systemd.service \
            /etc/systemd/system/user.service &>>${LOG_FILE}
StatCheck $?

Print "re-start catalogue"
systemctl daemon-reload &>>${LOG_FILE} && systemctl restart user &>>${LOG_FILE} && systemctl enable user &>>${LOG_FILE}
StatCheck $?
