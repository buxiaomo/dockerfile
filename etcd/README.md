# etcd

构建容器
```
docker build -t daocloud.io/buxiaomo/etcd:3.2.9 .
```

如何启动etcd容器
```
docker run -d --name etcd \
--net host \
daocloud.io/buxiaomo/etcd:3.2.9 \
--name etcd \
--data-dir /etcd \
--advertise-client-urls http://0.0.0.0:4001 \
--initial-advertise-peer-urls http://0.0.0.0:7001
```
添加一个特权账号并开启认证

    docker exec -it etcd etcdctl user add root
    New password: root123456
    docker exec -it etcd etcdctl auth enable

查看角色列表

    docker exec -it etcd etcdctl --username root:root123456 user list

添加一个非特权账号

    docker exec -it etcd etcdctl --username root:root123456 user add phpor
添加角色

    docker exec etcd etcdctl --username root:root123456 role add test1

给角色添加能力：

    docker exec etcd etcdctl --username root:root123456 role grant --rw --path /test1 test1
注意，这里只添加了 /test1 的读写权限，不包含其子目录（文件），如果需要包含，请这么写：

    docker exec etcd etcdctl --username root:root123456 role grant --rw --path /test1/* test1

查看有哪些角色

    docker exec etcd etcdctl --username root:root123456 role list

查看指定角色的权限

    docker exec etcd etcdctl --username root:root123456 role get test1

将用户添加到角色：

    docker exec etcd etcdctl --username root:root123456 user grant --roles test1 phpor

查看用户拥有哪些角色

    docker exec etcd etcdctl --username root:root123456 user get phpor
