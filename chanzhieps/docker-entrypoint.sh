#!/bin/sh
# set -ex
# user="${APACHE_RUN_USER:-www-data}"
# group="${APACHE_RUN_GROUP:-www-data}"
user='www-data'
group='www-data'
if ! [ -e VERSION -a -e www/index.php ]; then
    echo >&2 "ChanZhiEPS not found in $PWD - copying now..."
    if [ "$(ls -A)" ]; then
        echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    tar --create \
        --file - \
        --one-file-system \
        --directory /usr/src/chanzhieps \
        --owner "$user" --group "$group" \
        . | tar --extract --file -
    echo >&2 "Complete! ChanZhiEPS has been successfully copied to $PWD"
fi
if [ ! -n ${CHANZHI_DB_HOST} ] || [ ! -n ${CHANZHI_DB_USER}  ] || [ ! -n ${CHANZHI_DB_PASS} ];then
    echo "error: database is uninitialized and password option is not specified"
    echo "  You need to specify of CHANZHI_DB_HOST, CHANZHI_DB_USER and CHANZHI_DB_PASS"
    exit 1
fi
CHANZHI_DB_NAME="${CHANZHI_DB_NAME:-chanzhi}"
CHANZHI_TABLE_PREFIX="${CHANZHI_TABLE_PREFIX:-eps_}"
# 创建数据库
TERM=dumb php -- <<'EOPHP'
<?php
// 通过环境变量获取MySQL服务器信息
list($HOST, $SOCKET) = explode(':', getenv('CHANZHI_DB_HOST'), 2);
$port = 0;
if (is_numeric($SOCKET)) {
    $PORT = (int) $SOCKET;
    $SOCKET = null;
} else {
    $PORT = 3306;
}
$USER = getenv('CHANZHI_DB_USER');
$PASS = getenv('CHANZHI_DB_PASS');
$NAME = getenv('CHANZHI_DB_NAME');
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
////导入数据库
//echo "$HAVEDATA";
//if ( $HAVEDATA == false){
//    mysqli_query($mysql,'use ' . $NAME . ';' . 'source /var/www/html/system/db/chanzhi.sql');
//}
// 关闭MySQL
$mysql->close();
?>
EOPHP
exec "$@"