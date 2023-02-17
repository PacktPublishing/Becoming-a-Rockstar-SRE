#!/bin/bash

export VERSION="0.1.1"

docker login
docker build . -t rod4n4m1/node-api:$VERSION
docker push rod4n4m1/node-api:$VERSION
