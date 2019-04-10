#!/bin/bash
echo "Config Cobbler"
sed -i "s/^server:.*/server: $Cobbler_SERVER_IP/g" /etc/cobbler/settings
sed -i "s/^next_server:.*/next_server: $Cobbler_SERVER_IP/g" /etc/cobbler/settings
Cobbler_PASSWORD=$(openssl passwd -1 -salt '123456' "$Cobbler_PASSWORD")
sed -i "s|^default_password_crypted:.*|default_password_crypted: \"$Cobbler_PASSWORD\"|" /etc/cobbler/settings
sed -i 's/^pxe_just_once:.*/pxe_just_once: 1/g' /etc/cobbler/settings
sed -i 's/^manage_dhcp:.*/manage_dhcp: 1/g' /etc/cobbler/settings

echo "Config DHCP"
cat > /etc/cobbler/dhcp.template << EOF
# ******************************************************************
# Cobbler managed dhcpd.conf file
#
# generated from cobbler dhcp.conf template ($date)
# Do NOT make changes to /etc/dhcpd.conf. Instead, make your changes
# in /etc/cobbler/dhcp.template, as /etc/dhcpd.conf will be
# overwritten.
#
# ******************************************************************

ddns-update-style interim;
allow booting;
allow bootp;
ignore client-updates;
set vendorclass = option vendor-class-identifier;
option pxe-system-type code 93 = unsigned integer 16;
subnet ${Cobbler_DHCP_SUBNET} netmask ${Cobbler_DHCP_NETMASK} {
     option routers             ${Cobbler_DHCP_ROUTER};
     option domain-name-servers ${Cobbler_DHCP_DNS};
     option subnet-mask         ${Cobbler_DHCP_NETMASK};
     range dynamic-bootp        ${Cobbler_DHCP_RANGE};
     default-lease-time         21600;
     max-lease-time             43200;
     next-server                \$next_server;
     class "pxeclients" {
          match if substring (option vendor-class-identifier, 0, 9) = "PXEClient";
          if option pxe-system-type = 00:02 {
                  filename "ia64/elilo.efi";
          } else if option pxe-system-type = 00:06 {
                  filename "grub/grub-x86.efi";
          } else if option pxe-system-type = 00:07 {
                  filename "grub/grub-x86_64.efi";
          } else if option pxe-system-type = 00:09 {
                  filename "grub/grub-x86_64.efi";
          } else {
                  filename "pxelinux.0";
          }
     }

}

#for dhcp_tag in \$dhcp_tags.keys():
    ## group could be subnet if your dhcp tags line up with your subnets
    ## or really any valid dhcpd.conf construct ... if you only use the
    ## default dhcp tag in cobbler, the group block can be deleted for a
    ## flat configuration
# group for Cobbler DHCP tag: \$dhcp_tag
group {
        #for mac in \$dhcp_tags[\$dhcp_tag].keys():
            #set iface = \$dhcp_tags[\$dhcp_tag][\$mac]
    host \$iface.name {
        #if \$iface.interface_type == "infiniband":
        option dhcp-client-identifier = \$mac;
        #else
        hardware ethernet \$mac;
        #end if
        #if \$iface.ip_address:
        fixed-address \$iface.ip_address;
        #end if
        #if \$iface.hostname:
        option host-name "\$iface.hostname";
        #end if
        #if \$iface.netmask:
        option subnet-mask \$iface.netmask;
        #end if
        #if \$iface.gateway:
        option routers \$iface.gateway;
        #end if
        #if \$iface.enable_gpxe:
        if exists user-class and option user-class = "gPXE" {
            filename "http://\$cobbler_server/cblr/svc/op/gpxe/system/\$iface.owner";
        } else if exists user-class and option user-class = "iPXE" {
            filename "http://\$cobbler_server/cblr/svc/op/gpxe/system/\$iface.owner";
        } else {
            filename "undionly.kpxe";
        }
        #else
        filename "\$iface.filename";
        #end if
        ## Cobbler defaults to \$next_server, but some users
        ## may like to use \$iface.system.server for proxied setups
        next-server \$next_server;
        ## next-server \$iface.next_server;
    }
        #end for
}
#end for
EOF

sed -i "s/^#ServerName www.example.com:80/ServerName :80/" /etc/httpd/conf/httpd.conf
sed -i "s/service %s restart/supervisorctl restart %s/g" /usr/lib/python2.7/site-packages/cobbler/modules/sync_post_restart_services.py

rm -rf /run/httpd/*
/usr/sbin/apachectl
/usr/bin/cobblerd

cobbler sync
# cobbler get-loaders
# cobbler signature update
# if [ $(ls -l /iso/*.iso &> /dev/null | wc -l) -gt 0 ];then
    for file in $(ls /iso/*.iso)
    do
        echo "import ${file}"
        dirname=$(echo ${file}  | awk -F '/' '{print $NF}' | sed 's/.iso//g')
        mkdir -p /mnt/${dirname}
        mount ${file} /mnt/${dirname}
        cobbler import --name=${dirname} --path=/mnt/${dirname}
        umount /mnt/${dirname}
    done
# fi
cobbler sync

pkill cobblerd
pkill httpd
rm -rf /run/httpd/*

exec supervisord -n -c /etc/supervisord.conf