FROM maven:latest as builder

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin \
    KAFKAEAGLE_VERSION=1.2.3 

RUN git clone https://github.com/smartloli/kafka-eagle.git /usr/local/src/kafka-eagle

COPY pom.xml  /usr/local/src/kafka-eagle

RUN cd  /usr/local/src/kafka-eagle \
    && ./build.sh \
    && tar -zxf /usr/local/src/kafka-eagle/kafka-eagle-web/target/kafka-eagle-web-${KAFKAEAGLE_VERSION}-bin.tar.gz -C /usr/local/

FROM java:8u111
ENV KAFKAEAGLE_VERSION=1.2.3

COPY --from=builder /usr/local/kafka-eagle-web-${KAFKAEAGLE_VERSION} /usr/local/kafka-eagle
ENV KE_HOME=/usr/local/kafka-eagle
ENV PATH=$PATH:$KE_HOME/bin

RUN ${JAVA_HOME}/bin/jar -xvf $KE_HOME/kms/webapps/ke.war

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

EXPOSE 8048

CMD ["java","-jar","$KE_HOME/kms/webapps/ke.war"]