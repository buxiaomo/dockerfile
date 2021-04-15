## 1. Setup

### get jenkins plugins list

```
curl -s -k -u '<username>:<password>' "http://<address>:<port>/pluginManager/api/json?depth=1" | jq '.plugins[]|"\(.shortName):\(.version)"' -r
curl -s -k -u 'admin:gee9Jaim' "https://jenkins.nuomi.io/pluginManager/api/json?depth=1" | jq '.plugins[]|"\(.shortName):\(.version)"' -r
```

### build images

```
docker build -t jenkins:2.204.4-alpine.2 .
```