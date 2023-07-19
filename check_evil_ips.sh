#!/usr/bin/env bash
# Author: javy liu
#Date & Time: 2023-07-18 17:45:05
#Description: 通过检查/data3/access_logs/ 中的iphone_community.log 及 web_access.log,挑出状态为404的访问的ip, 超过指定访问量后就把该ip加到 /etc/nginx/domains/blockips 中。

log_path=/data3/access_logs/
# 限定访问次数
limit_count=100
# 以当前时间为基准的时间
limit_time="-10 minutes"
# 阻止时间,当前为一天
deny_range="-1 day"

#tago=`export LC_ALL=en_US.UTF-8;date -d "$limit_time" "+%d/%b/%Y:%T %z"`
#tago=`date -d "$limit_time" "+%Y/%b/%Y:%T"`
tago=`date -d "$limit_time" "+%FT%H:%M"`
echo ===========time: $tago =limit_count: $limit_count ==limit_time: $limit_time
block_file=/home/qmliu/blockips
nginx_domains=/etc/nginx/domains
nginx_blocks=$nginx_domains/blockips
#nginx_blocks=/home/oswap/blockips
echo $nginx_blocks
# 已配置 403及503到单独的日志文件，所以去除403的判断
awk -F'[][]' -v tago=$tago '$2>tago' $log_path/wap.log $log_path/bbs_access.log $log_path/admin_access.log $log_path/iphone_community.log $log_path/web_access.log | awk 'BEGIN{IGNORECASE=1}!/google|yahoo|baidu|soguo|360/{print $1}'|sort|uniq -c|awk -v lc=$limit_count '$1>lc'>$block_file

# 如果有需要阻止的ip, 那么把ip放到nginx配置的blockips文件中
# TODO 阻止多少时间，需要有一个数量
# blockips 格式为：deny x.x.x.x; #2343498
# 井号后面的为险止时的时间戳,如果没有时间戳，那么永久阻止
if [ -s "$block_file" ]; then
  echo "------存在需阻止的ip"
  tt2 /home/qmliu/.start
  sudo chattr -i $nginx_blocks
  cat $block_file
  #sudo awk -v file=$nginx_blocks '{print "deny "$2";">file}' $block_file

  ori_sign=`md5sum $nginx_blocks`

  # 删除过期的行
  jtime=`date -d "$deny_range" "+%s"`
  sudo awk -F'[ ;#]+' -v jt=$jtime -v file=$nginx_blocks '!$3 || $3<jt{print $0 > file}' $nginx_blocks

  # 直接写原文件,重复的ip不再写入
  sudo awk -F'[ ;#]+' -v jt=$jtime -v file=$nginx_blocks 'ARGIND==1{a[$2]=1}ARGIND==2{if(!a[$2]){print "deny "$2";#"jt >> file}}' $nginx_blocks $block_file

  cur_sign=`md5sum $nginx_blocks`

  if [[ $ori_sign == $cur_sign ]]; then
    echo "--没有变化，删除.start"
    rm /home/qmliu/.start
  else
    echo "----md5 比对文件不同"
    sudo systemctl reload nginx
    cd $nginx_domains && sudo git commit -am "append blockips"
    mv /home/qmliu/.start /home/qmliu/.end
  fi

  sudo chattr +i $nginx_blocks
else
  echo "------没有需要阻止的ip"
fi
