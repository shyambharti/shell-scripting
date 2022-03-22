#!/bin/bash

if [ $1 -eq 0 ]; then
   instanceType=${1};
    exit 1
  fi


security_id=$(aws ec2 describe-security-groups --filters Name=group-name,Values=allow-all | jq '.SecurityGroups[].GroupId' | sed -e 's/"/ /g')


aws ec2 run-instances \
    --image-id ami-0bb6af715826253bf \
    --instance-type t2.micro \
    --security-group-ids ${security_id} \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=frontend}]'