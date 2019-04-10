FROM docker.io/betacloud/kolla-ansible:4.0.2
MAINTAINER "Xiao Mo" <root@xiaomo.red>

USER root

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install --no-install-recommends sshpass iputils-ping -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

ENV DOCKER_REGISTRY 127.0.0.1
ENV DOCKER_REGISTRY_NAME NULL
ENV DOCKER_REGISTRY_PASSWORD NULL
ENV KOLLA_HOST 127.0.0.1
ENV KOLLA_USER root
ENV KOLLA_PASS root
ENV KOLLA_PORT 22
ENV KILLA_INTERNAL_VIP_ADDRESS 192.168.1.100
ENV NETWORK_INTERFACE eth0
ENV NEUTRON_EXTERNAL_INTERFACE eth1
ENV OPENSTACK_RELEASE 4.0.3

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

CMD ["docker-entrypoint.sh"]
