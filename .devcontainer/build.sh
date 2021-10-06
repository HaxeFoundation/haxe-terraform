#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
IMAGE="haxe/terraform_devcontainer_workspace"
TAG="${IMAGE}:$(date +%Y%m%d%H%M%S)"

docker build --pull -t "$TAG" "$DIR"

sed -i -e "s#${IMAGE}:[0-9]*#$TAG#g" \
    "$DIR/docker-compose.yml" -i \
    "$DIR/../.github/workflows/ci.yml" -i
