#!/usr/bin/env bash

set -e

ACTION=$1 # up, down
export SYNC_DATA=$2  # path to dir to be whitelisted in sync.conf::webui::dir_whitelist and to be mounted in container

if [ "$ACTION" = "up" ]
then
    docker volume create sync_storage || true
    docker-compose up -d
elif [ "$ACTION" = "down" ]
then
    docker-compose down
else
    echo "Invalid action. Must be up or down"
fi
