#!/bin/bash

number=$1

if [ $number -gt 20 ]
then
    echo "given number: $number is greater than 20"
else
    echo "given number: $number is less than 20"
fi