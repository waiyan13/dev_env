#! /bin/sh

docker buildx build \
    --file Dockerfile-${1} \
    --tag dev_env_${1}:latest \
    $(xargs --arg-file .env -I {} echo --build-arg {}) \
    .
