#!/bin/bash
read -p "enter the String value for ==" z
read -p "enter the String value for ==" y
if [ "$z" = "2" ] || [ "$y" = "3" ]
then
  echo "ok"
  else
    echo "not ok"
fi

echo "End"

read -p "enter the String value for ==" file1
read -p "enter the String value for ==" file2
if [ -f "$file1" ]
then
  echo "ok"
  else
    echo "not ok"
fi

echo "End"