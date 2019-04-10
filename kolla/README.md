# kolla
# 配置Kolla项目镜像仓库
wget -O /usr/local/src/ubuntu-source-registry-ocata.tar.gz http://tarballs.openstack.org/kolla/images/ubuntu-source-registry-ocata.tar.gz
<!-- tar -zvxf ubuntu-source-registry-ocata.tar.gz -->
mkdir -p /var/lib/registry
tar -zxf /usr/local/src/ubuntu-source-registry-ocata.tar.gz -C /var/lib/registry

docker run -d --name registry \
-p 80:5000/tcp \
-v /var/lib/registry:/var/lib/registry:rw \
registry:2.6.1

# 运行Kolla-Ansielbe容器部署基于Docker的OpenStack
docker run -it --name kolla \
-e DOCKER_REGISTRY=49.4.69.22 \
-e DOCKER_REGISTRY_NAME=lokolla \
-e KOLLA_HOST=192.168.23.100 \
-e KOLLA_USER=root \
-e KOLLA_PASS=123456 \
-e KOLLA_PORT=22 \
-e KILLA_INTERNAL_VIP_ADDRESS=192.168.23.101 \
-e NETWORK_INTERFACE=eno33554984 \
-e NEUTRON_EXTERNAL_INTERFACE=eno16777736 \
-e OPENSTACK_RELEASE=4.0.3 \
daocloud.io/buxiaomo/kolla

参数说明：
`DOCKER_REGISTRY` Kolla镜像仓库地址
`DOCKER_REGISTRY_NAME` Kolla镜像仓库名
`KOLLA_HOST` 部署OpenStack主机的IP地址
`KOLLA_USER` 部署OpenStack主机的用户名
`KOLLA_PASS` 部署OpenStack主机的密码
`KOLLA_PORT` 部署OpenStack主机的端口
`KILLA_INTERNAL_VIP_ADDRESS` VIP地址，此地址不能被使用
`NETWORK_INTERFACE` 一般是ssh的地址即可
`NEUTRON_EXTERNAL_INTERFACE` 管理地址，内网，不允许被访问的地址
