# dockerfile

已验证完成列表：

| 名称          | 说明             | 备注 |
| ------------- | ---------------- | ---- |
| chanzhieps    | 然之协同Docker版 | N/A  |
| cobbler | Cobbler Docker    | N/A  |
| jenkins     | 增加对宿主机的Docker操作支持 | N/A |
| kafka   | 一键部署Kafka集群|可上生产|
| zookeeper   | 一键部署Zookeeper集群|可上生产|
| maven   | 增加国内仓库地址 |N/A|
| ngrok   | Ngrok Docker |N/A|
| DockerRegistryUI   | 私有仓库管理Web |基本功能管理|
| php-ext   | 基于官方php镜像增加模块 | N/A |
| zblog   | zblog Docker版 | N/A |
| ssh   | ssh Docker版 | Dockerfile Demo |
| mycat   | mycat 基础镜像 | N/A |
| proftpd   | FTP基于MySQL认证 | N/A |
| php-ext   | 基于官方PHP扩展部分常用模块 | N/A |
| confd   | confd | N/A |
| elasticsearch   | N/A | N/A |
| kibana   | N/A | N/A |
| oracle-jdk   | N/A | N/A |

<!-- | KafkaEagle   | Kafka监控工具 |N/A| -->

<!-- ```
FROM java:8u111-jdk as builder
COPY . /app
RUN maven /app/file
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
COPY --from=builder /app/jarfile/
CMD ["./app"]
``` --># dockerfile
