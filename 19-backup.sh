#!/bin/bash

source_dir=$1
dest_dir=$2
days=${3:-14} # if $3 is empty default is 14 days

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

usage(){
    echo -e "$R usage:: $N sh 19-backup.sh <source> <destination> <days(optional)>"
    exit 1
}

#check whether the source and destinations folders are provided 
if [ $# -lt 2 ]
then
    usage
fi

if [ ! -d $source_dir ]
then
    echo "$source_dir does not exist...please check"
fi

if [ ! -d $dest_dir ]
then
    echo "$dest_dir does not exist...please check"
fi

files=$(find ${source_dir} -name "*.log" -mtime +14)

echo "files: $files"

if [ ! -z $files ] # true if files is empty, ! makes it expression false
then
    echo "files are found"
else
    echo "no files older than $days"
fi