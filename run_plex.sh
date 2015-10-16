#!/bin/bash

# sudo zfs create green/plex  -o mountpoint=/data/plex
# sudo mkdir /data/plex/{config,data}


PLEX_BASE=/data/plex

PLEX_VOL_CONFIG=$PLEX_BASE/config
PLEX_VOL_DATA=$PLEX_BASE/data

DOCKER_HOST=plex
DOCKER_DOMAIN=bring.out.local

PLEX_ALLOWED_NET=${PLEX_ALLOWED_NET:-"127.0.0.1\/255.255.255.255"}

docker rm -f $DOCKER_HOST.$DOCKER_DOMAIN

[ ! -d ${PLEX_BASE} ] && echo "kreirati $PLEX_BASE !" && exit -1

#    -h ${DOCKER_HOST}.${DOCKER_DOMAIN} \
docker run -d \
     --net=host \
    -v ${PLEX_VOL_CONFIG}:/config \
    -v ${PLEX_VOL_DATA}:/data \
    -p 32400:32400  \
    -e PLEX_ALLOWED_NET="$PLEX_ALLOWED_NET" \
    --name $DOCKER_HOST.$DOCKER_DOMAIN \
    plex-media-server:latest
