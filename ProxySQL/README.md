# 添加后端节点
```
insert into mysql_servers(hostgroup_id,hostname,port,weight,max_connections,max_replication_lag,comment) values(100,'mysql-master',3306,1,1000,10,'dockerqa');
insert into mysql_servers(hostgroup_id,hostname,port,weight,max_connections,max_replication_lag,comment) values(1000,'mysql-slave',3306,1,1000,10,'dockerqa');

select * from mysql_servers;
```
# 配置后端账户
```
# 监控
GRANT USAGE ON *.* TO 'proxysql'@'192.168.200.24' IDENTIFIED BY 'proxysql';
# 程序
GRANT SELECT, INSERT, UPDATE, DELETE ON `sbtest`.* TO 'sbuser'@'192.168.200.24' identified by 'sbuser';
```

insert into mysql_users(username,password,active,default_hostgroup,transaction_persistent) values('sbuser','sbuser',1,100,1);

select * from mysql_users;