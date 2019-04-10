#!/bin/bash
set -e
if [ ${MasqueradeAddress} == "**IP**" ];then
    MasqueradeAddress=$(curl -s  --unix-socket /run/docker.sock http://unix/info  | jq -r .Swarm.NodeAddr)
fi
sed -i "s/^#.MasqueradeAddress.*/MasqueradeAddress ${MasqueradeAddress}/g" /etc/proftpd/proftpd.conf
echo -e "\n\nSQLConnectInfo ${MYSQL_DATABASE}@${MYSQL_HOST}:${MYSQL_PORT} ${MYSQL_USER} ${MYSQL_PASSWORD}" >> /etc/proftpd/sql.conf
chown -R 82:82 /var/www
chmod 755 /var/www
# chmod -R 775 /var/www
# cat > /tmp/mysql.cnf << EOF
# [client]
# port = ${MYSQL_PORT}
# host = ${MYSQL_HOST}
# user= ${MYSQL_USER}
# password = ${MYSQL_PASSWORD}
# EOF
# mysql --defaults-file=/tmp/mysql.cnf ${MYSQL_DATABASE} < /var/lib/proftpd/ftp_group.sql
# mysql --defaults-file=/tmp/mysql.cnf ${MYSQL_DATABASE} < /var/lib/proftpd/ftp_user.sql
# rm -rf /tmp/mysql.cnf

if [ -d /etc/proftpd/ssl ];then
    sed -i "s|#Include /etc/proftpd/tls.conf|Include /etc/proftpd/tls.conf|g" /etc/proftpd/proftpd.conf
    cat > /etc/proftpd/tls.conf << EOF
<IfModule mod_tls.c>
    TLSEngine                  on
    TLSLog                     /var/log/proftpd/tls.log
    TLSProtocol TLSv1.2
    TLSCipherSuite AES128+EECDH:AES128+EDH
    TLSOptions                 NoCertRequest AllowClientRenegotiations
    TLSRSACertificateFile      ${TSL_CERTFILE}
    TLSRSACertificateKeyFile   ${TSL_KEYFILE}
    TLSVerifyClient            off
    TLSRequired                on
    RequireValidShell          no
</IfModule>
EOF
fi

exec proftpd -nc /etc/proftpd/proftpd.conf