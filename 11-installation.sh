#!/bin/bash

userid=$(id -u) # id -u gives the id of the user if id -u is o then it is root user

if [ $userid -ne 0 ]
then
    echo ("Please run this script with root access")
    exit 1
fi

dnf install git -y