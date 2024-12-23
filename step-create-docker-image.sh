#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

IPFS_GATEWAY_LIMITED_VERSION=1.2.0
IPFS_VERSION=0.32.1

echo ----[ Download assets ]----
mkdir -p _assets
cd _assets

if [ ! -f ipfs-gateway-limited_${IPFS_GATEWAY_LIMITED_VERSION}_amd64.deb ] ; then
    wget https://deploy.foilen.com/ipfs-gateway-limited/ipfs-gateway-limited_${IPFS_GATEWAY_LIMITED_VERSION}_amd64.deb
    ar x ipfs-gateway-limited_${IPFS_GATEWAY_LIMITED_VERSION}_amd64.deb
    tar --use-compress-program=unzstd -xf data.tar.zst
fi

if [ ! -f go-ipfs_v${IPFS_VERSION}_linux-amd64.tar.gz ] ; then
    wget https://dist.ipfs.io/go-ipfs/v${IPFS_VERSION}/go-ipfs_v${IPFS_VERSION}_linux-amd64.tar.gz
    tar -zxf go-ipfs_v${IPFS_VERSION}_linux-amd64.tar.gz
fi

echo ----[ Build docker image ]----
cd $RUN_PATH
DOCKER_IMAGE=fdi-ipfs-gateway-limited:$VERSION
docker build -t $DOCKER_IMAGE .

rm -rf $DOCKER_BUILD
