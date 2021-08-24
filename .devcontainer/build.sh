#!/bin/bash

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
TAG="haxe/terraform_devcontainer_workspace:$(date +%Y%m%d%H%M%S)"

docker build --pull -t "$TAG" "$DIR"

yq eval ".services.workspace.image = \"$TAG\"" "$DIR/docker-compose.yml" -i
yq eval ".jobs.plan.container = \"$TAG\"" "$DIR/../.github/workflows/ci.yml" -i
