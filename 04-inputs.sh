#!/bin/bash

read -p "Enter your Name: " name
echo "Your Name = $name"

echo "Hello : welcome to intellij"

# Special Variables
# $0-$n , $* / $@, $#
echo Scipt Name = $0
echo First Argument = $1
echo All Arguments = $*
echo Number of Arguments = $#