#!/bin/bash
BRANCH=`git symbolic-ref --short HEAD`
if [ "$BRANCH" == "master" ]; then
    DOCKER_TAG=""
else
    DOCKER_TAG=$BRANCH
fi
echo "Building tomcatbase"
docker build --no-cache=true -t craftercms/tomcatbase:$DOCKER_TAG tomcatbase
echo "Building Developer Docker"
docker build --no-cache=true -t craftercms/dev-full:$DOCKER_TAG dev-full
echo "Building Authoring Prd"
docker build --no-cache=true -t craftercms/prod-authoring:$DOCKER_TAG prod-authoring
echo "Building Delivery Prd"
docker build  --no-cache=true -t craftercms/prod-delivery:$DOCKER_TAG prod-delivery
