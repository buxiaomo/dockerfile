## 1. Setup

### get jenkins plugins list

```
curl -s -k -u '<username>:<password>' "http://<address>:<port>/pluginManager/api/json?depth=1" | jq '.plugins[]|"\(.shortName):\(.version)"' -r
curl -s -k -u 'admin:admin' "http://172.16.115.11:49154/pluginManager/api/json?depth=1" | jq '.plugins[]|"\(.shortName)"' -r
```

### build images

```
docker build -t jenkins:2.204.4-alpine.2 .

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```
docker builder build --platform linux/amd64 -t docker.io/buxiaomo/jenkins:2.340-amd64 --pull -f Dockerfile .
docker builder build --platform linux/arm64 -t docker.io/buxiaomo/jenkins:2.340-arm64 --pull -f Dockerfile . 

docker manifest create buxiaomo/jenkins:2.340 \
buxiaomo/jenkins:2.340-arm64 \
buxiaomo/jenkins:2.340-amd64
docker manifest push buxiaomo/jenkins:2.340



