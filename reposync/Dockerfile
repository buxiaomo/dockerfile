FROM centos:7.2.1511
MAINTAINER "Xiao Mo" <root@xiaomo.red>

RUN yum install epel-release ca-certificates yum-utils createrepo wget -y \
    && wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

WORKDIR /repo

CMD ["/usr/bin/reposync","--repoid=epel"]