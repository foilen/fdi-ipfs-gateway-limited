#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

echo ----[ Download assets ]----
mkdir -p _assets
cd _assets

if [ ! -f ipfs-gateway-limited_1.0.0_amd64.deb ] ; then
    wget https://dl.bintray.com/foilen/debian/ipfs-gateway-limited_1.0.0_amd64.deb
    ar x ipfs-gateway-limited_1.0.0_amd64.deb
    tar -Jxf data.tar.xz
fi

if [ ! -f go-ipfs_v0.7.0_linux-amd64.tar.gz ] ; then
    wget https://dist.ipfs.io/go-ipfs/v0.7.0/go-ipfs_v0.7.0_linux-amd64.tar.gz
    tar -zxf go-ipfs_v0.7.0_linux-amd64.tar.gz
fi

echo ----[ Build docker image ]----
cd $RUN_PATH
DOCKER_IMAGE=fcloud-docker-ipfs-gateway-limited:$VERSION
docker build -t $DOCKER_IMAGE .

rm -rf $DOCKER_BUILD
