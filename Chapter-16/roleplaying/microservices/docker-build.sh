#!/bin/bash
export APP_NAME="web-game"
export VERSION="0.1.1"

docker login
docker build . -t rod4n4m1/$APP_NAME:$VERSION
docker push rod4n4m1/$APP_NAME:$VERSION
