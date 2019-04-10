#!/bin/sh
# set -ex
# user="${APACHE_RUN_USER:-www-data}"
# group="${APACHE_RUN_GROUP:-www-data}"
user='www-data'
group='www-data'
if ! [ -e zb_system/login.php -a -e index.php ]; then
    echo >&2 "Z-Blog not found in $PWD - copying now..."
    if [ "$(ls -A)" ]; then
        echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    tar --create \
        --file - \
        --one-file-system \
        --directory /usr/src/zblog \
        --owner "$user" --group "$group" \
        . | tar --extract --file -
    echo >&2 "Complete! Z-Blog has been successfully copied to $PWD"
fi
if [ ! -n ${ZBLOG_DB_HOST} ] || [ ! -n ${ZBLOG_DB_USER}  ] || [ ! -n ${ZBLOG_DB_PASS} ];then
    echo "error: database is uninitialized and password option is not specified"
    echo "  You need to specify of ZBLOG_DB_HOST, ZBLOG_DB_USER and ZBLOG_DB_PASS"
    exit 1
fi
ZBLOG_DB_NAME="${CHANZHI_DB_NAME:-zblog}"
# 创建数据库
TERM=dumb php -- <<'EOPHP'
<?php
// 通过环境变量获取MySQL服务器信息
list($HOST, $SOCKET) = explode(':', getenv('ZBLOG_DB_HOST'), 2);
$port = 0;
if (is_numeric($SOCKET)) {
    $PORT = (int) $SOCKET;
    $SOCKET = null;
} else {
    $PORT = 3306;
}
$USER = getenv('ZBLOG_DB_USER');
$PASS = getenv('ZBLOG_DB_PASS');
$NAME = getenv('ZBLOG_DB_NAME');
// 尝试10次连接MySQL
$maxTries = 10;
$stderr = fopen('php://stderr', 'w');
do {
    $mysql = new mysqli($HOST, $USER, $PASS, '', $PORT, $SOCKET);
    if ($mysql->connect_error) {
        fwrite($stderr, "\n" . 'MySQL Connection Error: (' . $mysql->connect_errno . ') ' . $mysql->connect_error . "\n");
        --$maxTries;
        if ($maxTries <= 0) {
            exit(1);
        }
        sleep(3);
    }
} while ($mysql->connect_error);
// 创建数据库
if (!$mysql->query('CREATE DATABASE IF NOT EXISTS `' . $NAME . '`')) {
    echo "Database NOT Found";
    fwrite($stderr, "\n" . 'MySQL "CREATE DATABASE" Error: ' . $mysql->error . "\n");
    $mysql->close();
    $HAVEDATA = false;
    exit(1);
}
// 关闭MySQL
$mysql->close();
?>
EOPHP
exec "$@"




TERM=dumb php -- <<'EOPHP'
<?php
$NAME = getenv('ZBLOG_DB_NAME');
echo "Database NOT Found";
?>
EOPHP
