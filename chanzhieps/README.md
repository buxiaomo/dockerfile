# 婵知
```
docker build -t daocloud.io/buxiaomo/chanzhieps:6.4.1 .
docker node update --label-add mysql=true nodename
docker stack deploy -c docker-compose.yml chanzhi
```
