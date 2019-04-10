#!/bin/sh
[ ${SS_PASSWORD} = "**NULL**" ] && SS_PASSWORD=`pwgen -s 12 1`
exec shadowsocks-server -k ${SS_PASSWORD} -m ${SS_METHOD} -p 8388 -d
