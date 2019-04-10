#!/bin/bash
echo "Config Kolla-ansible"
mkdir ~/.ssh/
touch ~/.ssh/known_hosts
cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/kolla/
# config docker registry
if [ ${DOCKER_REGISTRY} != "127.0.0.1" ];then
    sed -i "s|#docker_registry:.*|docker_registry: \"${DOCKER_REGISTRY}\"|g" /etc/kolla/globals.yml
fi
if [ ${DOCKER_REGISTRY_NAME} != "NULL" ];then
    sed -i "s|#docker_registry_username:.*|docker_registry_username: \"${DOCKER_REGISTRY_NAME}\"|g" /etc/kolla/globals.yml
fi
if [ ${DOCKER_REGISTRY_PASSWORD} != "NULL" ];then
    sed -i "s|#docker_registry_password:.*|docker_registry_password: \"${DOCKER_REGISTRY_PASSWORD}\"|g" /etc/kolla/globals.yml
fi
sed -i "s|#openstack_release:.*|openstack_release: \"${OPENSTACK_RELEASE}\"|g" /etc/kolla/globals.yml
sed -i "s|#docker_namespace:.*|docker_namespace: \"${DOCKER_REGISTRY_NAME}\"|g" /etc/kolla/globals.yml
sed -i "s|#kolla_base_distro:.*|kolla_base_distro: \"ubuntu\"|g" /etc/kolla/globals.yml
sed -i "s|#kolla_install_type:.*|kolla_install_type: \"source\"|g" /etc/kolla/globals.yml
# pull docker images
echo "UserKnownHostsFile /dev/null
StrictHostKeyChecking no" > ~/.ssh/config
echo "[kolla]
${KOLLA_HOST} ansible_ssh_port=${KOLLA_PORT} ansible_ssh_user=${KOLLA_USER} ansible_ssh_pass=${KOLLA_PASS}" > /tmp/host
sed -i "s/localhost       ansible_connection=local/${KOLLA_HOST} ansible_ssh_port=${KOLLA_PORT} ansible_ssh_user=${KOLLA_USER} ansible_ssh_pass=${KOLLA_PASS}/g" /usr/local/share/kolla-ansible/ansible/inventory/all-in-one
ansible -i /tmp/host kolla -m shell -a 'yum install epel-release ca-certificates -y'
ansible -i /tmp/host kolla -m shell -a 'sed -i "s/#baseurl/baseurl/g" /etc/yum.repos.d/epel.repo'
ansible -i /tmp/host kolla -m shell -a 'sed -i "s/mirrorlist/#mirrorlist/g" /etc/yum.repos.d/epel.repo'
ansible -i /tmp/host kolla -m shell -a 'sed -i "s#http://download.fedoraproject.org/pub#https://mirrors.tuna.tsinghua.edu.cn#g" /etc/yum.repos.d/epel.repo'
ansible -i /tmp/host kolla -m shell -a 'yum install python-docker-py git python-pip python-devel libffi-devel gcc openssl-devel -y'
ansible -i /tmp/host kolla -m shell -a 'pip install -i https://pypi.tuna.tsinghua.edu.cn/simple python-openstackclient'
kolla-ansible pull
if [ $? == 0 ];then
    exit 1
fi
sed -i "s/#network_interface: \"eth0\"/network_interface: \"${NETWORK_INTERFACE}\"/g" /etc/kolla/globals.yml
sed -i "s/#neutron_external_interface: \"eth1\"/neutron_external_interface: \"${NEUTRON_EXTERNAL_INTERFACE}\"/g" /etc/kolla/globals.yml
sed -i "s/kolla_internal_vip_address:.*/kolla_internal_vip_address: \"${KILLA_INTERNAL_VIP_ADDRESS}\"/g" /etc/kolla/globals.yml
mkdir -p /etc/kolla/config/nova
cat > /etc/kolla/config/nova/nova-compute.conf <<  EOF
[libvirt]
virt_type=qemu
EOF
kolla-genpwd
if [ $? != 0 ];then
    exit 1
fi
kolla-ansible prechecks
if [ $? != 0 ];then
    exit 1
fi
kolla-ansible deploy
if [ $? ！= 0 ];then
    exit 1
fi
kolla-ansible post-deploy
ansible -i /tmp/host kolla -m copy -a 'src=/etc/kolla/admin-openrc.sh dest=/etc/kolla/admin-openrc.sh mode=744'
# sed -i "s|IMAGE_URL=http://download.cirros-cloud.net/0.3.4/|IMAGE_URL=http://images.trystack.cn/0.3.4/|g" /usr/local/share/kolla-ansible/init-runonce
ansible -i /tmp/host kolla -m copy -a 'src=/usr/local/share/kolla-ansible/init-runonce dest=/etc/kolla/init-runonce mode=744'
ansible -i /tmp/host kolla -m copy -a 'src=/etc/kolla/passwords.yml dest=/etc/kolla/passwords.yml'
passwd=`cat /etc/kolla/passwords.yml | grep keystone_admin_password | awk -F ': ' '{print $2}'`
echo "Web Url: http://${KOLLA_HOST}
User: admin
Password: ${passwd}"
