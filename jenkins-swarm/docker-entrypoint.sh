#!/bin/sh
set -x
if [ -e /var/run/docker.sock ];then
    DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
    egrep "${DOCKER_GID}" /etc/group >& /dev/null
    if [ $? -ne 0 ];then  
        groupadd -g ${DOCKER_GID} docker
    fi
    usermod -G docker jenkins
fi

exec gosu jenkins "$@"