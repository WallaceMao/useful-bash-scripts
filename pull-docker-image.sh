#!/bin/bash
if [ -z $1 ]
  then
    echo input image name
    exit 1
fi
if [ -z $2 ]
  then
    echo input target image name
    exit 1
fi

echo images in 172.31.255.159
ssh root@172.31.255.159 "docker pull $1 && docker tag $1 $2"
echo images in 172.31.255.160
ssh root@172.31.255.160 "docker pull $1 && docker tag $1 $2"
echo images in 172.31.255.161
ssh root@172.31.255.161 "docker pull $1 && docker tag $1 $2"
echo images in 172.31.255.170
ssh root@172.31.255.170 "docker pull $1 && docker tag $1 $2"
echo images in 172.31.255.169
ssh root@172.31.255.169 "docker pull $1 && docker tag $1 $2"
