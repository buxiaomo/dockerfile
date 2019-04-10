
docker network create vsftpd

docker run -d --name vsftpd_mysql \
--network vsftpd \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=root \
-e MYSQL_DATABASE=vsftpd \
-e MYSQL_USER=vsftpd \
-e MYSQL_PASSWORD=123456 \
mysql:5.7.20

docker exec -it vsftpd_mysql bash
use vsftpd;
create table users (
  id int auto_increment not null,
  name char(20) not null unique key,
  passwd char(48) not null,
  primary key(id)
);
insert into vsftpd.users(name,passwd) values ('wuxin',password('123456'));

grant select on vsftpd.* to vsftpd@127.0.0.1 identified by 'abc123';

docker run -d --name vsftpd \
-p 20:20 -p 21:21 \
-p 21100-21110:21100-21110 \
--network vsftpd \
vsftpd:latest
