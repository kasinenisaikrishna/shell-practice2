#!/bin/bash

echo "all variables passed to the script: $@"
echo "no.of vars passed to the script: $#"
echo "script name: $0"
echo "cwd: $PWD"
echo "home dir of current user: $HOME"
echo "pid of current shell script: $$"
sleep 100 &
echo "pid of last background command: $!"