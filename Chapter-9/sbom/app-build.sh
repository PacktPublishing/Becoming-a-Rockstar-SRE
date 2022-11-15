#!/bin/bash

export VERSION="0.1.3"
export USERNAME="rod4n4m1"
export APPNAME="node-api"
export PASSWORD="xxxxxxxx"

# Buid the application container image and push it to the repository
docker login -u $USERNAME -p $PASSWORD
docker build . -t ${USERNAME}/${APPNAME}:${VERSION}
docker push ${USERNAME}/${APPNAME}:${VERSION}
# Create an SBOM and attach it to the image on Docker Hub
syft ${USERNAME}/${APPNAME}:${VERSION} -o spdx-json > sbom.spdx.json
# Scans the SBOM for known vulnerabilities
grype sbom.spdx.json > vulnerabilities.grype
# TODO
# cosign the SBOM and attach it to the repository
