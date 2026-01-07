#!/usr/bin/env bash

set -x

CONTAINER_CLI="${CONTAINER_CLI:-podman}"

name="ztunnel"
version="1.26.8"
registry="container-registry.oracle.com/olcne"
docker_tag=${registry}/${name}:${version}

"${CONTAINER_CLI}" build --pull \
    --build-arg https_proxy=${https_proxy} \
    --build-arg istio_version=${version} \
    -t ${docker_tag} -f ./olm/builds/Dockerfile .
