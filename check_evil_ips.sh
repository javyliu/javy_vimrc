#!/usr/bin/env sh
# Author: javy liu
#Date & Time: 2023-07-18 17:45:05
#Description: 通过检查/data3/access_logs/ 中的iphone_community.log 及 web_access.log,挑出状态为404的访问的ip, 超过指定访问量后就把该ip加到 /etc/nginx/domains/blockips 中。

log_path=/data3/access_logs/
# 限定访问次数
limit_count=10
# 以当前时间为基准的时间
limit_time="-10 minutes"


#tago=`export LC_ALL=en_US.UTF-8;date -d "$limit_time" "+%d/%b/%Y:%T %z"`
#tago=`date -d "$limit_time" "+%Y/%b/%Y:%T"`
tago=`date -d "$limit_time" "+%FT%H:%M"`
echo $tago
block_file=/home/qmliu/blockips
#nginx_blocks=/etc/nginx/domains/blcokips
nginx_blocks=/home/oswap/blockips

awk -F'[][]' -v tago=$tago '$2>tago' $log_path/iphone_community.log $log_path/web_access.log | awk 'BEGIN{IGNORECASE=1}$6!=403&&!/google|yahoo|baidu|soguo|360/{print $1}'|sort|uniq -c|awk -v lc=$limit_count '$1>lc'>$block_file

# 如果有需要阻止的ip, 那么把ip放到nginx配置的blockips文件中
# TODO 阻止多少时间，需要有一个数量
if [ -s "$block_file" ]; then
  echo "------存在需阻止的ip"
  #tt2 /home/qmliu/.start
  #sudo chattr -i $nginx_blocks
  cat $block_file
  sudo awk -v file=$nginx_blocks '{print "deny "$2";">file}' $block_file
  #sudo systemctl reload nginx
  #sudo chattr +i $nginx_blocks
  #cd /etc/nginx/domains && sudo git commit -am "append blockiops"
  #mv /home/qmliu/.start /home/qmliu/.end
else
  echo "------没有需要阻止的ip"
fi

