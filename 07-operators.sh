#!/bin/bash

if [ "abc" = "ABC" ]
then
 echo "true condition"
else
  echo "false condition"
fi

read -p "Enter the String for compair" e
if [ "$e" = "abc" ]
then
  echo "Ok"
  else
    echo "not ok"
fi

read -p "enter the String value for ==" x
if [ "$x" == "abc" ]
then
  echo "ok"
  else
    echo "not ok"
fi