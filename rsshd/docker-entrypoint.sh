#!/bin/sh
if [ -z "$PASSWORD" ]; then
    PASSWORD=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c8)
    echo "==========="
    echo "== Root Password is $PASSWORD"
    echo "==========="
    echo
fi
echo "root:${PASSWORD}" | chpasswd &> /dev/null || exit 1
if [ ! -f "${KEYS}/ssh_host_rsa_key" ]; then
    ssh-keygen -A
    if [ -f "/etc/ssh/ssh_host_rsa_key" ]; then
        mv /etc/ssh/ssh_host_rsa_key /etc/ssh/keys/ssh_host_rsa_key
        mv /etc/ssh/ssh_host_rsa_key.pub /etc/ssh/keys/ssh_host_rsa_key.pub
    fi
    if [ -f "/etc/ssh/ssh_host_dsa_key" ]; then
        mv /etc/ssh/ssh_host_dsa_key /etc/ssh/keys/ssh_host_dsa_key
        mv /etc/ssh/ssh_host_dsa_key.pub /etc/ssh/keys/ssh_host_dsa_key.pub
    fi
    if [ -f "/etc/ssh/ssh_host_ecdsa_key" ]; then
        mv /etc/ssh/ssh_host_ecdsa_key /etc/ssh/keys/ssh_host_ecdsa_key
        mv /etc/ssh/ssh_host_ecdsa_key.pub /etc/ssh/keys/ssh_host_ecdsa_key.pub
    fi
    if [ -f "/etc/ssh/ssh_host_ed25519_key" ]; then
        mv /etc/ssh/ssh_host_ed25519_key /etc/ssh/keys/ssh_host_ed25519_key
        mv /etc/ssh/ssh_host_ed25519_key.pub /etc/ssh/keys/ssh_host_ed25519_key.pub
    fi
fi
if [ -f "$KEYS/ssh_host_rsa_key" ]; then
    sed -i "s;\#HostKey $SDIR/ssh_host_rsa_key;HostKey $KEYS/ssh_host_rsa_key;g" $SDIR/sshd_config
fi
if [ -f "$KEYS/ssh_host_dsa_key" ]; then
    sed -i "s;\#HostKey $SDIR/ssh_host_dsa_key;HostKey $KEYS/ssh_host_dsa_key;g" $SDIR/sshd_config
fi
if [ -f "$KEYS/ssh_host_ecdsa_key" ]; then
    sed -i "s;\#HostKey $SDIR/ssh_host_ecdsa_key;HostKey $KEYS/ssh_host_ecdsa_key;g" $SDIR/sshd_config
fi
if [ -f "$KEYS/ssh_host_ed25519_key" ]; then
    sed -i "s;\#HostKey $SDIR/ssh_host_ed25519_key;HostKey $KEYS/ssh_host_ed25519_key;g" $SDIR/sshd_config
fi
if [ -z "$LOCAL" -o "$LOCAL" == 0 ]; then
    sed -i "s;\#GatewayPorts no;GatewayPorts yes;g" $SDIR/sshd_config
fi
chown root $HOME/.ssh
chmod 755 $HOME/.ssh
SHELL=$(awk -F ':' "/^${USER}/{print \$NF}" /etc/passwd)
sed -i "/${USER}/s|${SHELL}|/usr/bin/rssh|g" /etc/passwd
mkdir /usr/local/chroot
echo "logfacility = LOG_USER

allowscp
# allowsftp
# allowcvs
# allowrdist
# allowrsync

umask = 022

# chrootpath = /usr/local/chroot

user=${USER}:022:00001" > /etc/rssh.conf
exec /usr/sbin/sshd -D -e
# /usr/sbin/sshd -f ${SDIR}/sshd_config -D -e "$@"
