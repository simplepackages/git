#!/bin/sh

RESULT=$(docker run --rm --entrypoint /bin/sh alpine:3.17 -c 'apk add git >/dev/null 2>&1; git --version')
GIT_VERSION=$(echo $RESULT | cut -d ' ' -f 3)
echo 'GIT_VERSION = '$GIT_VERSION

DOCKER_IMAGE='simplepackages/git'
DOCKER_TAG=$GIT_VERSION

docker manifest inspect $DOCKER_IMAGE:$DOCKER_TAG >/dev/null 2>&1
if [ $? -ne 0 ]; then
    docker buildx create --name multibuilder
    docker buildx use multibuilder
    docker buildx build --push \
                        --platform linux/amd64,linux/arm64,linux/arm/v7 \
                        --tag $DOCKER_IMAGE:$DOCKER_TAG \
                        --tag $DOCKER_IMAGE:latest \
                        .
else
    echo 'Image '$DOCKER_IMAGE:$DOCKER_TAG' already exists, building aborted.'
    echo
fi

docker pull $DOCKER_IMAGE:$DOCKER_TAG
echo
docker image ls | grep $DOCKER_IMAGE
