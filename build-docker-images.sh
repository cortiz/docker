#!/bin/bash
BRANCH=`git symbolic-ref --short HEAD`
if [ "$BRANCH" == "master" ]; then
    DOCKER_TAG=""
else
    DOCKER_TAG=$BRANCH
fi
echo "Building tomcatbase"
docker build -t craftercms/tomcatbase:$DOCKER_TAG tomcatbase
echo "Building Studio"
docker build -t craftercms/studio:$DOCKER_TAG studio
