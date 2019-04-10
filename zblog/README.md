 docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306  mysql:5.7.20

docker run -d --name zblog \
-e ZBLOG_DB_HOST=10.10.1.206:3306 \
-e ZBLOG_DB_NAME=zblog \
-e ZBLOG_DB_USER=root \
-e ZBLOG_DB_PASS=root \
zblog:1.5.1
