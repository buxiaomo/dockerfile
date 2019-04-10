```
docker run -d --name ss -P -e SS_PASSWORD=123456 shadowsocks-go:1.2.1

docker service create --name wuxin --publish 5001:8388 --env SS_PASSWORD=wuxin123 daocloud.io/buxiaomo/ssserver:1.2.1
```

ID=878f8c27108d
docker stats ${ID} --no-stream
PID=$(docker inspect ${ID} | jq .[0].State.Pid)
cat /proc/${PID}/net/dev
