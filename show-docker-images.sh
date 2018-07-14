#!/bin/bash
if [ -z $1 ]
  then
    echo input image name
    exit 1
fi

echo images in 172.31.255.170
ssh root@172.31.255.170 "docker images | grep '$1 '"
echo images in 172.31.255.169
ssh root@172.31.255.169 "docker images | grep '$1 '"
