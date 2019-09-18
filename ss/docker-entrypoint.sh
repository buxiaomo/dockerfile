#!/bin/sh
cat > /usr/local/etc/ss-server.json << EOF
{
  "server": ["0.0.0.0"],
  "server_port": ${server_port},
  "password": "${password}",
  "timeout": ${timeout},
  "user": "nobody",
  "fast_open": ${fast_open},
  "method": "${method}",
  "plugin": "${plugin}",
  "plugin_opts": "${plugin_opts}",
  "nameserver": "${nameserver}",
  "mode": "${mode}",
  "mtu": ${mtu},
  "workers": ${workers}
}
EOF
exec /usr/local/bin/ss-server -c /usr/local/etc/ss-server.json