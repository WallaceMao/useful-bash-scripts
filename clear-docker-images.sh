#!/bin/bash
if [ -z $1 ]
  then
    echo input image name
    exit 1
fi

ssh root@172.31.255.170 "docker images | grep '$1 ' | awk '{print $3}' | xargs -r docker rmi -f"
ssh root@172.31.255.169 "docker images | grep '$1 ' | awk '{print $3}' | xargs -r docker rmi -f"
