# 设置参数
设置各节点： `id` ，以及 `zookeeper.cluster` 信息，本实例集群使用host网络，所以IP为宿主机的IP的地址

`id` 集群唯一，不要重复

`zookeeper.cluster` 各zookeeper节点通讯地址，可以使用下面的命令修改全部：

```shell
cluster=10.211.55.75:2888:3888,10.211.55.76:2888:3888,10.211.55.77:2888:3888
sed -i "s/10.211.55.75:2888:3888,10.211.55.76:2888:3888,10.211.55.77:2888:3888/${cluster}/g" zookeeper.yml
```



# 设置节点标签

```
docker node update --label-add zookeeper.node01=true Docker01
docker node update --label-add zookeeper.node02=true Docker02
docker node update --label-add zookeeper.node03=true Docker03
```

# 创建各节点数据目录

```
mkdir -p /var/lib/zookeeper
```

# 部署集群

```
docker stack deploy -c zookeeper.yml zookeeper
```


