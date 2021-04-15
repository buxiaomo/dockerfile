FROM alpine:3.12.3

RUN apk add --no-cache openssh-server openssh-client \
    && mkdir /var/run/sshd \
    && sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^#UsePAM\s+.*/UsePAM yes/g' /etc/ssh/sshd_config

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV ROOT_PASSWORD=root

EXPOSE 22

CMD [ "/docker-entrypoint.sh" ]