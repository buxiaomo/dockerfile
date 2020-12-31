FROM jenkins/jenkins:2.273

USER root

COPY plugins.txt /tmp/
RUN /usr/local/bin/install-plugins.sh $(cat /tmp/plugins.txt | tr '\n' ' ')

USER jenkins