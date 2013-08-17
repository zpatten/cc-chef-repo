#!/bin/bash

head -$((`wc -l /etc/rc.local | cut -d ' ' -f 1` - 1)) /etc/rc.local > /tmp/rc.local

cat <<EOF >> /tmp/rc.local
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/sbin/iptables -A FORWARD -i eth0 -o br1 -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i eth1 -o br1 -j ACCEPT
exit 0
EOF

sudo cp /tmp/rc.local /etc/

sudo chmod 0755 /etc/rc.local
sudo sh /etc/rc.local 2> /dev/null
echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward

echo net.ipv4.ip_forward=1 | sudo tee -a /etc/sysctl.conf > /dev/null
