FROM alpine:3.11

COPY repositories /etc/apk/repositories

RUN apk add --no-cache vlc ffmpeg

RUN addgroup -S xteve && adduser -S xteve -G xteve \
    && mkdir -p /home/xteve/bin /usr/local/src \
    && wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O /usr/local/src/xteve_linux_amd64.zip \
    && unzip /usr/local/src/xteve_linux_amd64.zip -d /home/xteve/bin \
    && rm -rf /usr/local/src

USER xteve

VOLUME ["/home/xteve/.xteve", "/tmp/xteve"]

EXPOSE 34400

CMD ["/home/xteve/bin/xteve"]