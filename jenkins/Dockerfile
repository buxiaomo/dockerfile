FROM jenkins/jenkins:2.415
COPY plugins.txt /tmp/plugins.txt
RUN cat /tmp/plugins.txt | xargs jenkins-plugin-cli --plugins

COPY extend.txt /tmp/extend.txt
RUN cat /tmp/extend.txt | xargs jenkins-plugin-cli --plugins
