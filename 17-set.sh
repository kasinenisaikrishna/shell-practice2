#!/bin/bash

set -e # setting the automatic exit, if we get an error. set -ex is for debug mode 

failure(){
    echo "failed at: $1:$2"
}

trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR # ERR is the error signal

echo "hello world success"
echooo "hello world failure"
echo "hello world after failure"