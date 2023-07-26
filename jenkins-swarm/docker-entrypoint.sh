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
    if [ -e /run/user/1000/docker.sock ]; then
        ln /run/user/1000/docker.sock /var/run/docker.sock
        ln /run/user/1000/containerd.sock /var/run/containerd.sock
    else
        echo "Agent is not allow run docker command! if you want do it, please mount '/var/run/docker.sock' file."
    fi
fi

# use os env set git proxy
if [ ! -z $http_proxy ]; then
    echo "set git http_proxy env."
    git config --global http.proxy $http_proxy
fi
if [ ! -z $https_proxy ]; then
    echo "set git https_proxy env."
    git config --global https.proxy $https_proxy
fi

if [ ! -z $no_proxy ]; then
    echo "set git no_proxy env."
    git config --global no.proxy $no_proxy
fi

git config --global http.postBuffer 524288000
git config --global http.maxRequestBuffer 524288000
git config --global core.compression 0

# exec gosu jenkins "$@"
# bash
if [ $@ == "bash" ];then
    bash
fi

exec gosu jenkins java -jar /usr/local/bin/swarm-client.jar -name $HOSTNAME -master $JENKINS_MASTER -username $JENKINS_USER -password $JENKINS_PASS -executors $JENKINS_EXECUTORS -labels $LABELS $JENKINS_OPTS