#!/bin/bash

logs_folder="/var/log/shell-script"
script_name=$(echo $0 | cut -d "." -f1)
time_stamp=$(date +%Y-%m-%d-%H-%M-%S)
log_file="$logs_folder/$script_name-$time_stamp.log"
mkdir -p $logs_folder

userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root(){
    if [ $userid -ne 0 ]
    then
        echo -e "$R Please run this script with root access $N" &>>$log_file
        exit 1
    fi
}

validate(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R failed $N" &>>$log_file
        exit 1
    else
        echo -e "$2 is...$G success $N" &>>$log_file
    fi
}

check_root

for package in $@ 
do
    dnf list installed $package &>>$log_file
    if [ $? -ne 0 ]
    then
        echo "$package is not installed...going to install it" &>>$log_file
        dnf install $package -y &>>$log_file
        validate $? "installing $package"
    else
        echo -e "$package is already $Y installed...nothing to do $N" &>>$log_file
    fi
done