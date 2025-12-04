#!/bin/bash
# Author: javy liu
#Date & Time: 2025-12-01 11:17:39
#Description: 启用iptables 结合ipset 封禁ip
#自动配置ipset + iptables 防CC/DDoS 脚本

SSH_PORT=22
HTTP_PORT=80
HTTPS_PORT=443
TEMPBLACK_TIMEOUT=3600
WHITELIST=("221.216.213.154")


if ! command -v ipset > /dev/null; then
  echo "安装ipset..."
  sudo dnf install -y ipset
fi
if ! dnf list installed iptables-services > /dev/null 2>&1; then
  echo "安装ipset..."
  sudo dnf install -y iptables-services
fi

echo 清理已有规则
sudo ipset destroy tmpblock 2>/dev/null
sudo ipset destroy whitelist 2>/dev/null


sudo ipset create tmpblock hash:ip hashsize 4096 maxelem 65536 timeout $TEMPBLACK_TIMEOUT
sudo ipset create whitelist hash:ip hashsize 1024

echo "ipset 配置完成"


# 添加白名单
for ip in "${WHITELIST[@]}" ; do
  sudo ipset add whitelist $ip
done
echo "保存ipset 到/etc/ipset.conf"
sudo ipset save | sudo tee /etc/ipset.conf

echo "配置iptables"
sudo iptables -F
sudo iptables -X
sudo iptables -Z

echo SSH 自我保护
sudo iptables -A INPUT -p tcp --dport $SSH_PORT -m state --state NEW -m recent --set
sudo iptables -A INPUT -p tcp --dport $SSH_PORT -m state --state NEW -m recent --update --seconds 3 --hitcount 3 -j DROP
sudo iptables -A INPUT -p tcp --dport $SSH_PORT -j ACCEPT

sudo iptables -I INPUT 1 -m set --match-set whitelist src -j ACCEPT
sudo iptables -I INPUT 2 -m set --match-set tmpblock src -j DROP
sudo service iptables save
echo "iptables 配置完成"

#sudo systemctl enable iptables
#sudo systemctl start iptables
