FROM jenkins/jenkins:2.225
MAINTAINER "Xiao Mo" <root@xiaomo.site>

USER root

COPY plugins.txt /tmp/
RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')