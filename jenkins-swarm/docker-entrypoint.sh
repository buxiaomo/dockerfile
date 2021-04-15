#!/bin/bash
set -x
if [ -e /var/run/docker.sock ]; then
    DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
    egrep "${DOCKER_GID}" /etc/group >&/dev/null
    if [ $? -ne 0 ]; then
        groupadd -g ${DOCKER_GID} docker
    fi
    usermod -G docker jenkins
else
    echo "Agent is not allow run docker command! if you want do it, please mount '/var/run/docker.sock' file."
fi
chown -R jenkins.jenkins /home/jenkins

if [ ! -z $http_proxy ] && [ ! -z $https_proxy ]; then
    git config --global http.proxy $http_proxy
    git config --global https.proxy $https_proxy
fi

exec gosu jenkins "$@"
