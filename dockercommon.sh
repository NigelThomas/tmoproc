#!/bin/bash
#
# start a development container, load all slab files from the current project
# expects BASE_IMAGE and CONTAINER_NAME to be supplied by caller 

GIT_ACCOUNT=https://github.com/NigelThomas
GIT_PROJECT_NAME=tmoproc


docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Unless disabled, link the targer volume

docker run -p 80:80 -p 5560:5560 -p 5580:5580 -p 5585:5585 -p 5590:5590 \
           -e GIT_ACCOUNT=$GIT_ACCOUNT -e GIT_PROJECT_NAME=$GIT_PROJECT_NAME \
           -e LOAD_SLAB_FILES="${LOAD_SLAB_FILES:=tmo.slab" \
           -e SQLSTREAM_SLEEP_SECS=${SQLSTREAM_SLEEP_SECS:=10} \
           -d --name $CONTAINER_NAME -it $BASE_IMAGE

docker logs -f $CONTAINER_NAME
