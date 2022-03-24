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

Print "extract cart"
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print "cleanup old content"
rm -rf /home/${APP_USER}/cart &>>$LOG_FILE
StatCheck $?

Print "unzip cart"
cd /home/${APP_USER} &>>$LOG_FILE && unzip /tmp/cart.zip &>>$LOG_FILE &&  mv cart-main cart &>>$LOG_FILE
StatCheck $?

Print "install npm"
cd /home/roboshop/cart &>>$LOG_FILE && npm install &>>$LOG_FILE
StatCheck $?

Print "app user permission"
chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
StatCheck $?

Print "systemd setting"
sed -i -e 's/REDIS_ENDPOINT/redis.ayushyam.internal/'  \
       -e 's/CATALOGUE_ENDPOINT/catalogue.ayushyam.internal/' \
            /home/roboshop/cart/systemd.service &>>${LOG_FILE} && mv /home/roboshop/cart/systemd.service \
            /etc/systemd/system/cart.service &>>${LOG_FILE}
StatCheck $?

Print "re-start cart"
systemctl daemon-reload &>>${LOG_FILE} && systemctl start cart &>>${LOG_FILE} && systemctl enable cart &>>${LOG_FILE}
StatCheck $?
