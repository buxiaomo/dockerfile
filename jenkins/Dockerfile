FROM jenkins/jenkins:2.326-alpine

USER root

COPY plugins.txt /tmp/plugins.txt

RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')