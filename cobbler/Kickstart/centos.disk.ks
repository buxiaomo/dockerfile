# System authorization information
auth  --useshadow  --enablemd5
# System bootloader configuration
bootloader --location=mbr
# Use text mode install
text
# Firewall configuration
firewall --disabled
# Run the Setup Agent on first boot
firstboot --disable
# System keyboard
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8
# Use network installation
url --url=$tree
# If any cobbler repo definitions were referenced in the kickstart profile, include them here.
$yum_repo_stanza

# Network information
$SNIPPET('network_config')

# Reboot after installation
reboot

#Root password
rootpw --iscrypted $default_password_crypted
# System services
services --enabled="chronyd"
# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx
# System timezone
timezone Asia/Shanghai --isUtc --nontp
# Install OS instead of upgrade
install
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part pv.198 --fstype="lvmpv" --ondisk=sda --size=63492
part /boot --fstype="xfs" --ondisk=sda --size=500
volgroup centos --pesize=4096 pv.198
logvol /  --fstype="xfs" --size=51200 --name=root --vgname=centos
logvol swap  --fstype="swap" --size=2048 --name=swap --vgname=centos
logvol /home  --fstype="xfs" --size=10240 --name=home --vgname=centos

%include /tmp/part-include
%pre --interpreter=/bin/bash
ls /sys/block/
disk=$(while read line;do awk ‘BEGIN{} {if ($3 == "33554432" && $2 == "0") print $4} END{}‘;done < /proc/partitions)
cat > /tmp/part-include << EOF
part / --asprimary --fstype="ext4" --ondisk=$disk --size=24576
part swap --fstype="swap" --ondisk=$disk --size=8191
%end

%packages
@^minimal
@core
vim
net-tools
bash-completion
wget
curl
telnet
%end

%post --nochroot
$SNIPPET('log_ks_post_nochroot')
%end

%post
set -x -v
exec 1>/root/ks-post.log 2>&1
curl "http://mirrors.aliyun.com/repo/Centos-7.repo" --output /etc/yum.repos.d/aliyun.repo
curl "https://download.docker.com/linux/centos/docker-ce.repo" --output /etc/yum.repos.d/docker-ce.repo
sed -i "s+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+" /etc/yum.repos.d/docker-ce.repo
echo "UseDNS no" >> /etc/ssh/sshd_config
%end