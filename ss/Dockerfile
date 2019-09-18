# docker run -it -p 8389:8388 alpine:3.10.2 sh
FROM alpine:3.10.2
ARG BUILD_PKG='gcc perl g++ make file autoconf automake git'
ARG RUNTIME_PKG='libev-dev c-ares-dev pcre-dev'

RUN mkdir /usr/local/src /usr/local/etc

WORKDIR /usr/local/src

ENV LIBSODIUM_VER=1.0.16
RUN apk add --no-cache -t build ${BUILD_PKG} \
    && wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz \
    && tar -xf libsodium-${LIBSODIUM_VER}.tar.gz \
    && cd libsodium-${LIBSODIUM_VER} \
    && ./configure --prefix=/usr && make -j && make install \
    && apk del --no-cache build \
    && rm -rf /usr/local/src/*

ENV MBEDTLS_VER=2.6.0
RUN apk add --no-cache -t build ${BUILD_PKG} \
    && wget https://tls.mbed.org/download/mbedtls-${MBEDTLS_VER}-gpl.tgz \
    && tar -xf mbedtls-${MBEDTLS_VER}-gpl.tgz \
    && cd mbedtls-${MBEDTLS_VER} \
    && make SHARED=1 CFLAGS=-fPIC \
    && make DESTDIR=/usr install \
    && apk del --no-cache build \
    && rm -rf /usr/local/src/*

RUN apk add --no-cache -t build ${BUILD_PKG} libtool xmlto asciidoc linux-headers libev-dev \
    && git clone https://github.com/shadowsocks/simple-obfs.git \
    && cd simple-obfs \
    && git submodule update --init --recursive \
    && ./autogen.sh && ./configure && make -j \
    && make install \
    && apk del --no-cache build \
    && rm -rf /usr/local/src/*

RUN apk add --no-cache -t build ${BUILD_PKG} libtool xmlto asciidoc linux-headers \
    && apk add --no-cache ${RUNTIME_PKG} \
    && git clone https://github.com/shadowsocks/shadowsocks-libev.git \
    && cd shadowsocks-libev \
    && git submodule update --init --recursive \
    && ./autogen.sh && ./configure && make -j \
    && make install \
    && apk del --no-cache build \
    && rm -rf /usr/local/src/*

ENV server_port=8388 \
    password=123456 \
    timeout=300 \
    fast_open=true \
    method=aes-256-gcm \
    plugin=obfs-server \
    plugin_opts=obfs=http \
    nameserver=8.8.8.8 \
    mode=tcp_and_udp \
    mtu=1300 \
    workers=2

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
CMD [ "/usr/local/bin/docker-entrypoint.sh" ]