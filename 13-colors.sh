#!/bin/bash

userid=$(id -u) # id -u gives the id of the user if id -u is o then it is root user
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

dnf list installed git

if [ $? -ne 0 ]
then
    echo "git is not installed, going to install it.."
    dnf install git -y
    validate $? "Installing git"
else
    echo "git is already installed, nothing to do.."
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed, going to install it.."
    dnf install mysql -y
    validate $? "Installing mysql"
else
    echo "mysql is already installed, nothing to do.."
fi