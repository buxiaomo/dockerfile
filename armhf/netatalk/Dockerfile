FROM armhf/debian:jessie

COPY sources.list /etc/apt/sources.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9165938D90FDDD2E \
    && apt-get update \
    && apt-get install wget gcc make libgcrypt-dev libdb-dev libacl1-dev pkg-config file -y \
    && wget http://prdownloads.sourceforge.net/netatalk/netatalk-3.1.11.tar.gz?download -O /usr/local/src/netatalk-3.1.11.tar.gz \
    && tar -zxvf /usr/local/src/netatalk-3.1.11.tar.gz -C /usr/local/src/ \
    && cd /usr/local/src/netatalk-3.1.11 \
    && ./configure \
            --enable-fhs \
            --with-acls \
            --with-init-style=debian-systemd \
            --with-zeroconf \
    && make && make install && mkdir -p /TimeMachine \
    && apt-get remove wget gcc make pkg-config file  -y && apt-get autoremove -y \
    && rm -rf /usr/local/src/* \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get install avahi-daemon -y \
    && sed -i '/rlimit-nproc/d' /etc/avahi/avahi-daemon.conf \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY afp.conf /etc/afp.conf

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

VOLUME [ "/TimeMachine" ]

EXPOSE 548

CMD ["docker-entrypoint.sh"]