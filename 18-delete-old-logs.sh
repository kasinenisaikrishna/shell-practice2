#!/bin/bash

source_dir=/home/ec2-user/logs

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ -d $source_dir ]
then
    echo -e "$source_dir $G exists $N"
else
    echo -e "$source_dir $R does not exists $N"
    exit 1
fi

files=$(find $source_dir -name "*.log" -mtime +14)
echo "files: $files"

while IFS= read -r line #IFS, internal field seperator, empty means it will not ignore while spaces. -r is for not to ignore special characters like /
do
    echo "deleting line: $line"
    rm -rf $line
done <<< $files