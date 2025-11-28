#!/bin/bash

disk_usage=$(df -hT | grep xfs)
disk_threshold=5 # real projects, it is usually 75 

while IFS= read -r line
do
    usage=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    partition=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $usage -ge $disk_threshold ]
    then
        echo "$partition is more than $disk_threshold, current value: $usage.please check"
    fi
done <<< $disk_usage