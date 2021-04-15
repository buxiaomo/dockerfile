#!/bin/bash
/usr/bin/ssh-keygen -A
echo "root:${ROOT_PASSWORD}" | chpasswd
echo "root password is: ${ROOT_PASSWORD}"
exec /usr/sbin/sshd -D