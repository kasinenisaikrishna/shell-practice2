#!/bin/bash

source_dir=$1
dest_dir=$2
days=${3:-14} # if $3 is empty default is 14 days
time_stamp=$(date +%Y-%m-%d-%H-%M-%S)

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
    exit 1
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
    zip_file="$dest_dir/app-logs-$time_stamp.zip"
    find ${source_dir} -name "*.log" -mtime +14 | zip "$zip_file" -@

    #check if zip file is successfully created or not

    if [ -f $zip_file ]
    then
        echo "successfully zipped files older than $days"

        #remove the files after zipping
        while IFS= read -r file
        do
            echo "deleting file: $file"
            rm -rf $file
        done <<< $files
    else
        echo "Zipping the files is failed"
        exit 1
    fi
else
    echo "no files older than $days"
fi