FROM daocloud.io/buxiaomo/oracle-jdk:8u181

ENV GRABLE_VERSION=4.10.2
RUN apt-get update && apt-get install unzip wget -y \
    && wget https://services.gradle.org/distributions/gradle-${GRABLE_VERSION}-bin.zip -O /usr/local/src/gradle-${GRABLE_VERSION}-bin.zip \
    && cd /usr/local/src/ && unzip gradle-${GRABLE_VERSION}-bin.zip \
    && mv /usr/local/src/gradle-4.10.2 /usr/local/gradle \
    && rm -rf /usr/local/src/gradle-${GRABLE_VERSION}-bin.zip
ENV GRADLE_HOME=/usr/local/gradle
ENV PATH=$GRADLE_HOME/bin:$PATH