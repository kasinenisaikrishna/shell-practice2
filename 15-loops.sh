#!/bin/bash

userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root(){
    if [ $userid -ne 0 ]
    then
        echo "Please run this script with root access"
        exit 1
    fi
}

validate(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R failed $N"
        exit 1
    else
        echo -e "$2 is...$G success $N"
    fi
}

check_root

# sh 15-loops.sh git mysql postfix nginx
for package in $@ # $@ special variable refers to all arguments passed to it 
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo "$package is not installed...going to install it"
        dnf install $package -y
        validate $? "installing $package"
    else
        echo "$package is already installed...nothing to do"
    fi
done