#!/bin/bash
[ -d /var/www/html/_h5ai ] || unzip /usr/local/src/h5ai-0.30.0.zip -d /var/www/html
chown -R 33.33 /var/www/html/_h5ai
$@