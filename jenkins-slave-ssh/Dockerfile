FROM openjdk:8-jdk

RUN apt-get update \
    && apt-get install -y --no-install-recommends netcat openssh-server \
    && mkdir /var/run/sshd \
    && sed -ri 's/#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && apt-get clean all

# Docker
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.06.1-ce
RUN wget -O /usr/local/src/docker.tgz "https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
    && tar --strip-components=1 -xvzf /usr/local/src/docker.tgz -C /usr/local/bin \
    && rm -rf /usr/local/src/docker.tgz

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

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
    && apt-get install -y libpng-dev make nodejs \
    && apt-get purge apt-transport-https lsb-release -y \
    && apt-get -y autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nodesource.list

# POSTMAN Tools
RUN npm install -g newman \
    && npm install newman-reporter-html

# Build Tools
RUN apt-get update \
    && apt install -y build-essential libpng-dev make \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV ROOT_PASSWORD=root

EXPOSE 22

VOLUME [ "/var/jenkins_home" ]

CMD ["docker-entrypoint.sh"]