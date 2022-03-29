#!/bin/bash

source components/common.sh


Print "Install Maven, This will install Java too"
 yum install maven -y
StatCheck $?


Print "add user if user not existing in system"
id ${APP_USER} &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  useradd ${APP_USER} &>>${LOG_FILE}
fi

Print "extract shipping"
 curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print "cleanup old content"
rm -rf /home/${APP_USER}/shipping &>>$LOG_FILE
StatCheck $?


Print "unzip shipping"
cd /home/${APP_USER} &>>$LOG_FILE && unzip /tmp/shipping.zip &>>$LOG_FILE &&  mv shipping-main shipping &>>$LOG_FILE
StatCheck $?

Print "unzip shipping"
cd shipping &>>$LOG_FILE && mvn clean package &>>$LOG_FILE && mv target/shipping-1.0.jar shipping.jar &>>$LOG_FILE
StatCheck $?

Print "app shipping permission"
chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
StatCheck $?

Print "systemd setting"
sed -i -e 's/CARTENDPOINT/cart.ayushyam.internal/'  \
       -e 's/DBHOST/shipping.ayushyam.internal/' \
            /home/roboshop/shipping/systemd.service &>>${LOG_FILE} && mv /home/roboshop/shipping/systemd.service \
            /etc/systemd/system/shipping.service &>>${LOG_FILE}
StatCheck $?

Print "re-start shipping"
systemctl daemon-reload &>>${LOG_FILE} && systemctl start shipping &>>${LOG_FILE} && systemctl enable shipping &>>${LOG_FILE}
StatCheck $?
