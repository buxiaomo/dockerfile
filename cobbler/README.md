# Cobbler

## 参数说明

| 环境变量 | 说明 | 默认值 |
| :- | :-- | :- |
| Cobbler_SERVER_IP | Cobbler容器所在主机的IP地址 | null |
| Cobbler_PASSWORD | root密码 | root |
| Cobbler_DHCP_SUBNET | 子网地址 | null |
| Cobbler_DHCP_ROUTER | 网关地址 | null |
| Cobbler_DHCP_DNS | DNS地址 | 114.114.114.114 |
| Cobbler_DHCP_RANGE | 装机时分配的IP地址池 | null |

## 示例

```shell
docker run -d --net host --name cobbler \
--privileged=true \
-e Cobbler_SERVER_IP=10.0.3.254 \
-e Cobbler_PASSWORD=root \
-e Cobbler_DHCP_SUBNET=10.0.0.0 \
-e Cobbler_DHCP_ROUTER=10.0.1.1 \
-e Cobbler_DHCP_DNS=114.114.114.114 \
-e Cobbler_DHCP_RANGE='10.0.11.200 10.0.11.210' \
-e Cobbler_DHCP_NETMASK=255.255.0.0 \
-v cobbler_tftpboot:/var/lib/tftpboot \
-v cobbler_log:/var/log/cobbler \
-v cobbler_www:/var/www/cobbler \
-v cobbler_lib:/var/lib/cobbler \
-v cobbler_etc:/etc/cobbler \
-v /mnt/iso:/iso:ro mo2017/cobbler:2.8.2

docker run -d --net host --name cobbler \
--privileged=true \
-e Cobbler_SERVER_IP=10.211.55.14 \
-e Cobbler_PASSWORD=root \
-e Cobbler_DHCP_SUBNET=10.211.55.0 \
-e Cobbler_DHCP_ROUTER=10.211.55.1 \
-e Cobbler_DHCP_DNS=114.114.114.114 \
-e Cobbler_DHCP_RANGE='10.211.55.100 10.211.55.110' \
-e Cobbler_DHCP_NETMASK=255.255.255.0 \
-v cobbler_tftpboot:/var/lib/tftpboot \
-v cobbler_log:/var/log/cobbler \
-v cobbler_www:/var/www/cobbler \
-v cobbler_lib:/var/lib/cobbler \
-v cobbler_etc:/etc/cobbler \
-v /mnt/iso:/iso:ro mo2017/cobbler:2.8.2
```
## Cobbler Web

Cobbler Web：http://${Cobbler_SERVER_IP}/cobbler_web

登录用户：cobbler

登录密码：cobbler

## 导入镜像
### 自动导入
​        将镜像放在宿主机mount到 `/ios` 目录，以上面的启动命令中的参数为例，将ISO镜像放在 `/mnt/iso` 目录并启动Cobbler容器，容器启动后将会自动导入镜像：

```Shell
root@Docker:~# ls /mnt/iso/
CentOS-7-x86_64-DVD-1511.iso  CentOS-7-x86_64-DVD-1611.iso  CentOS-7-x86_64-DVD-1708.iso  ubuntu-16.04.3-server-amd64.iso
```

### 手动导入

​        将镜像放在宿主机mount到 `/ios` 目录，以上面的启动命令中的参数为例，将ISO镜像放在 `/mnt/iso` 目录或使用 `docker cp` 命令本示例以mount方式：

```shell
# 查看镜像文件
root@Docker:~# docker exec -it cobbler ls /iso
CentOS-7-x86_64-DVD-1511.iso  CentOS-7-x86_64-DVD-1708.iso
CentOS-7-x86_64-DVD-1611.iso  ubuntu-16.04.3-server-amd64.iso

# 挂在镜像
root@Docker:~# docker exec -it cobbler mount /iso/CentOS-7-x86_64-DVD-1511.iso /tmp
mount: /dev/loop0 is write-protected, mounting read-only

# 导入镜像
root@Docker:~# docker exec -it cobbler cobbler import --name=CentOS-7-x86_64-DVD-1708 --path=/mnt/iso/centos1708
task started: 2018-05-04_200944_import
task started (id=Media import, time=Fri May  4 20:09:44 2018)
......
*** TASK COMPLETE ***

# 卸载镜像
root@Docker:~# docker exec -it cobbler umount /tmp

# 同步相关文件
docker exec -it cobbler cobbler sync
```
cobbler import --name=EXSI6.5 --path=/iso/esxi


