#!/bin/sh
set -e
DOCKER_SOCKET=/var/run/docker.sock
DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
if [ ! -d "/home/jenkins" ]; then
	mkdir -p /home/jenkins
fi

groupadd -for -g ${DOCKER_GID} jenkins
exec "$@"