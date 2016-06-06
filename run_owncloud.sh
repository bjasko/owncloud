#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
VOLUME_BASE=/data/owncloud
IMAGE=ownloud-apache:9.0.2
S_HOST=owncloud
S_DEV=wlan0
S_DOMAIN=bring.out.ba
S_HOST_IP=192.168.46.23
S_DNS_HOST_IP=192.168.46.254


sudo ip addr show | grep $S_HOST_IP || 
sudo ip addr add $S_HOST_IP/24 dev $S_DEV

docker rm -f $S_HOST.$S_DOMAIN

docker run -d \
     -v $VOLUME_BASE/$S_HOST.$S_DOMAIN/apps:/var/www/html/apps  \
     -v $VOLUME_BASE/$S_HOST.$S_DOMAIN/config:/var/www/html/config \
     -v $VOLUME_BASE/$S_HOST.$S_DOMAIN/data:/var/www/html/data \
     -p $S_HOST_IP:80:80  \
     -p $S_HOST_IP:443:443  \
     --name $S_HOST.$S_DOMAIN \
     --hostname $S_HOST.$S_DOMAIN  \
     --dns $S_DNS_HOST_IP \
     $IMAGE

