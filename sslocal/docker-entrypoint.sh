#!/bin/sh
if [ $PASSWORD = "**NULL**" ];then
    echo "Please set ssserver password."
    echo "For example:"
    echo "docker run -d --name sslocal -P -e PASSWORD=123456..."
    exit 1
fi
exec sslocal -s ${SERVER_ADDR} -p ${SERVER_PORT} -k ${PASSWORD}  -m ${SERVER_METHOD} -b ${LOCAL_ADDR} --fast-open