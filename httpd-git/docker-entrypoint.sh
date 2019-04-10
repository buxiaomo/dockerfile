#!/bin/sh
set -e
sed -i "s/#ServerName.*/ServerName :80/g" /usr/local/apache2/conf/httpd.conf
rm -f /usr/local/apache2/logs/httpd.pid
echo "${PASSWORD}" | htpasswd -m -i -c /usr/local/apache2/conf/git.htpasswd ${USERNAME}
chown root.daemon /usr/local/apache2/conf/git.htpasswd
chmod 640 /usr/local/apache2/conf/git.htpasswd
git init --bare demo1.git
chown -R www-data:www-data .
exec httpd -D FOREGROUND