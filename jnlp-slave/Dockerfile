FROM jenkins/jnlp-slave:3.27-1
MAINTAINER "Xiao Mo" <root@xiaomo.site>

COPY sources.list /etc/apt/sources.list

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

USER root

# Docker
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.06.1-ce
RUN wget -O /usr/local/src/docker.tgz "https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
    && tar --strip-components=1 -xvzf /usr/local/src/docker.tgz -C /usr/local/bin \
    && rm -rf /usr/local/src/docker.tgz

# 下载Kubernetes二进制文件
ENV KUBE_VERSION=v1.13.0
RUN wget https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/kubernetes-server-linux-amd64.tar.gz -O /usr/local/src/kubernetes-server-linux-amd64.tar.gz \
    && tar -zxvf /usr/local/src/kubernetes-server-linux-amd64.tar.gz  \
        --strip-components=3 -C /usr/local/bin \
        kubernetes/server/bin/kubectl \
    && rm -rf /usr/local/src/kubernetes-server-linux-amd64.tar.gz

# ANT
RUN apt-get update \
    && apt-get install ant --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV ANT_HOME /usr/share/ant
ENV PATH $PATH:$ANT_HOME/bin

# Maven
RUN apt-get update \
    && apt-get install maven --no-install-recommends -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*
ENV MAVEN_HOME /usr/share/maven/
ENV PATH $PATH:$MAVEN_HOME/bin

# gradle
ENV GRABLE_VERSION=4.10.2
RUN wget https://services.gradle.org/distributions/gradle-${GRABLE_VERSION}-bin.zip -O /usr/local/src/gradle-${GRABLE_VERSION}-bin.zip \
    && cd /usr/local/src/ && unzip gradle-${GRABLE_VERSION}-bin.zip \
    && mv /usr/local/src/gradle-4.10.2 /usr/local/gradle \
    && rm -rf /usr/local/src/gradle-${GRABLE_VERSION}-bin.zip
ENV GRADLE_HOME=/usr/local/gradle
ENV PATH=$GRADLE_HOME/bin:$PATH

# sonar-scanner
ENV SONAR_SCANNER_VERSION=3.3.0.1492
RUN wget https://repo1.maven.org/maven2/org/sonarsource/scanner/cli/sonar-scanner-cli/${SONAR_SCANNER_VERSION}/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip -O /usr/local/src/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip  \
    && cd /usr/local/src/ && unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
    && mv /usr/local/src/sonar-scanner-${SONAR_SCANNER_VERSION} /usr/local/sonar-scanner-cli \
    && rm -rf /usr/local/src/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip
ENV SONAR_RUNNER_HOME=/usr/local/sonar-scanner-cli
ENV PATH=$SONAR_RUNNER_HOME/bin:$PATH

# ./build/libs/jenkin/var/jenkins_home/tools/hudson.plugins.sonar.SonarRunnerInstallation/SonarQube_Runner/bin/sonar-scanner -Dsonar.host.url=http://150.109.69.179:9000
# USER jenkins:docker

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
    && apt-get install -y nodejs \
    && apt-get purge apt-transport-https lsb-release -y \
    && apt-get -y autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*