#!/bin/bash

NAME="$(basename $PWD)"-$RANDOM

[ -d .config ] || mkdir .config
[ -d .ssh ] || mkdir .ssh

echo "Starting container - $NAME"
podman run -ti --rm \
    -v "$(pwd)"/.config:/root/.config \
    -v "$(pwd)"/.ssh:/root/.ssh \
    -v "$(pwd)":/work \
    -w /work \
    --name $NAME \
    gcp-devops
