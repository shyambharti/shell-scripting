#!/bin/bash

source components/common.sh

Print "Install python36"
 yum install python36 gcc python3-devel -y &>>${LOG_FILE}
StatCheck $?

Print "add user if user not existing in system"
id ${APP_USER} &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  useradd ${APP_USER} &>>${LOG_FILE}
fi


Print "extract payment"
 curl -L -s -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip" &>>$LOG_FILE
StatCheck $?

Print "cleanup old content"
rm -rf /home/${APP_USER}/cart &>>$LOG_FILE
StatCheck $?

Print "unzip payment"
cd /home/${APP_USER} &>>$LOG_FILE && unzip /tmp/payment.zip &>>$LOG_FILE &&  mv payment-main payment &>>$LOG_FILE
StatCheck $?

Print "Install the dependencies"
cd /home/roboshop/payment &>>$LOG_FILE && pip3 install -r requirements.txt &>>$LOG_FILE
StatCheck $?

Print "app cart permission"
chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}
StatCheck $?

Print "systemd setting"
sed -i -e 's/CARTHOST/cart.ayushyam.internal/'  \
       -e 's/USERHOST/user.ayushyam.internal/' \
        -e 's/AMQPHOST /rabbitmq.ayushyam.internal/' \
            /home/roboshop/payment/systemd.service &>>${LOG_FILE} && mv /home/roboshop/payment/systemd.service \
            /etc/systemd/system/payment.service &>>${LOG_FILE}
StatCheck $?


Print "re-start payment"
systemctl daemon-reload &>>${LOG_FILE} && systemctl start payment &>>${LOG_FILE} && systemctl enable payment &>>${LOG_FILE}
StatCheck $?