#!/bin/bash
read -p "enter the String value for ==" z
read -p "enter the String value for ==" y
if [ $z -eq $y ]
then
  echo "ok"
  else
    echo "not ok"
fi

echo "End"