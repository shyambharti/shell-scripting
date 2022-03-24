#!/bin/bash

source component/common.sh

Print "bash setup for redis"
 curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo  - &>>"${LOG_FILE}"
StatCheck $?

Print "Installation redis"
 yum install redis -y   &>>"${LOG_FILE}"
StatCheck $?

Print "conf change in redis.conf "
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf &>>"${LOG_FILE}"
StatCheck $?


Print "re-start redis"
systemctl enable redis &>>"${LOG_FILE}" && ystemctl start redis &>>"${LOG_FILE}"
StatCheck $?
