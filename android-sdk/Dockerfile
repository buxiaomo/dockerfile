FROM openjdk:8-jdk

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O /usr/local/src/sdk-tools-linux-4333796.zip \
    && unzip /usr/local/src/sdk-tools-linux-4333796.zip  -d /usr/local/android-sdk \
    && rm -rf /usr/local/src/sdk-tools-linux-4333796.zip
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $ANDROID_HOME/tools/bin:$PATH

ENV GRABLE_VERSION=4.10.2
RUN wget https://services.gradle.org/distributions/gradle-${GRABLE_VERSION}-bin.zip -O /usr/local/src/gradle-${GRABLE_VERSION}-bin.zip \
    && cd /usr/local/src/ && unzip gradle-${GRABLE_VERSION}-bin.zip \
    && mv /usr/local/src/gradle-4.10.2 /usr/local/gradle \
    && rm -rf /usr/local/src/gradle-${GRABLE_VERSION}-bin.zip
ENV GRADLE_HOME=/usr/local/gradle
ENV PATH=$GRADLE_HOME/bin:$PATH

RUN sdkmanager --update \
    && echo y | sdkmanager "platforms;android-26"
# RUN echo y | android update sdk --no-ui --filter 19,20,21,22,23,24,25,26,27,28