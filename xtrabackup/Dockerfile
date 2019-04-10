FROM centos:7.3.1611
MAINTAINER "Xiao Mo" <root@xiaomo.red>

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY epel.repo epel-testing.repo percona-release.repo /etc/yum.repos.d/
RUN yum install --nogpgcheck -y libev 
RUN yum install --nogpgcheck -y percona-xtrabackup-24 
COPY entrypoint /usr/local/bin/entrypoint
RUN chmod a+x /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
