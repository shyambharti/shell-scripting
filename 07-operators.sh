#!/bin/bash

if [ "abc" = "ABC" ]
then
 echo "true condition"
else
  echo "false condition"
fi

echo -p "Enter the String for compair" e
if [ "$e" = "abc" ]
then
  echo "Ok"
  else
    echo "not ok"
fi