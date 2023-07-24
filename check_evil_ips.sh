#!/usr/bin/env bash
# Author: javy liu
#Date & Time: 2023-07-18 17:45:05
#Description: 通过检查/data3/access_logs/ 中的iphone_community.log 及 web_access.log,挑出状态为404的访问的ip, 超过指定访问量后就把该ip加到 /etc/nginx/domains/blockips 中。

log_path=/data3/access_logs
# 限定访问次数
limit_count=100
# 以当前时间为基准的时间
limit_time="-10 minutes"
# 阻止时间,当前为一天
deny_range="-1 day"

#tago=`export LC_ALL=en_US.UTF-8;date -d "$limit_time" "+%d/%b/%Y:%T %z"`
#tago=`date -d "$limit_time" "+%Y/%b/%Y:%T"`
tago=$(date -d "$limit_time" "+%FT%H:%M")
echo ===========time: $tago =limit_count: $limit_count ==limit_time: $limit_time
block_file=/home/qmliu/blockips
nginx_domains=/etc/nginx/domains
nginx_blocks=$nginx_domains/blockips
#nginx_blocks=/home/oswap/blockips
echo $nginx_blocks
# 已配置 403及503到单独的日志文件，所以去除403的判断
evil_regexp=$(cat evil_content.txt | xargs | sed -E 's@[|/.${()\]@\\\\&@g;s!\s+!|!g')
awk -F'[][]' -v tago=$tago '$2>tago{print FILENAME" "$0}' $log_path/inner_ssl_app.log $log_path/wap.log $log_path/bbs_access.log $log_path/admin_access.log $log_path/iphone_community.log $log_path/web_access.log | awk 'BEGIN{IGNORECASE=1}!/google|yahoo|baidu|soguo|360/{print $2}$0~/'"$evil_regexp"'/{print $0 >> "evil_file.log"}' | sort | uniq -c | awk -v lc=$limit_count '$1>lc' >$block_file

# 不在使用blocks来阻止ip， 直接写到ipset中，这样就不用重启nginx
if [ -s "$block_file" ]; then
  echo "------阻止以下ip 一天： "
  awk '{print $0;str="sudo ipset add nginx_blocks "$2" timeout 86400"; print str; system(str);}' $block_file
fi

# # 如果有需要阻止的ip, 那么把ip放到nginx配置的blockips文件中
# # blockips 格式为：deny x.x.x.x; #2343498
# # 井号后面的为险止时的时间戳,如果没有时间戳，那么永久阻止
# tt2 /home/qmliu/.start
# sudo chattr -i $nginx_blocks
# #sudo awk -v file=$nginx_blocks '{print "deny "$2";">file}' $block_file

# ori_sign=`md5sum $nginx_blocks`

# # echo -----删除过期的ip
# # jtime=`date -d "$deny_range" "+%s"`
# # awk -F'[ ;#]+' -v jt=$jtime '!$3 || $3>jt{print $0}' $nginx_blocks | sudo tee $nginx_blocks

# #echo -----删除重复的ip,暂用
# #awk -F'[ ;#]+' -v jt=$jtime '!a[$2]++' $nginx_blocks | sudo tee $nginx_blocks

# echo -----------nginx_block begin-----------
# if [ -s "$block_file" ]; then
#   cur_time=`date '+%s'`
#   echo "------需阻止的ip"
#   cat $block_file
#   echo "------恶意ip"
#   cat $evil_ipfiles
#   # 如果在ipset中已存在，则不再写入nginx_block
#   # 直接写原文件,重复的ip不再写入
#   #sudo awk -F'[ ;#]+' -v jt=$cur_time -v file=$nginx_blocks 'ARGIND==1{a[$2]=1}ARGIND==2{b[$3]=1}ARGIND==3{if(!a[$3] && !b[$3]){print "deny "$3";#"jt >> file}}' $nginx_blocks $evil_ipfiles $block_file
#   # 暂不加入ipset
#   sudo awk -F'[ ;#]+' -v jt=$cur_time -v file=$nginx_blocks 'ARGIND==1{a[$2]=1}ARGIND==2{if(!a[$3]){print "deny "$3";#"jt >> file}}' $nginx_blocks $block_file
# fi

# cur_sign=`md5sum $nginx_blocks`

# if [[ $ori_sign == $cur_sign ]]; then
#   echo "--blockips 没有变化，删除.start"
#   rm /home/qmliu/.start
# else
#   echo "----md5 比对文件不同, 重启nginx 并提交变化"
#   sudo systemctl reload nginx
#   cd $nginx_domains && sudo git commit -am "append blockips"
#   mv /home/qmliu/.start /home/qmliu/.end
# fi

# sudo chattr +i $nginx_blocks

# 可以考虑ipset来封ip
#hash:ip存储类型
#创建集合：ipset create nginx_blocks hash:ip hashsize 4096 maxelem 1000000 timeout 0
#编辑/root/iptables.cfg：-A INPUT -m set --match-set nginx_blocks src -p tcp -j DROP
#向集合中添加IP：ipset add nginx_blocks 1.2.3.4 timeout 300
#重新指定集合中的IP的timeout：ipset -exist add nginx_blocks 1.2.3.4 timeout 100
#从集合中移除IP：ipset del nginx_blocks 1.2.3.4
#ipset规则保存到文件：ipset save nginx_blocks -f /root/nginx_blocks.cfg
#从文件中导入ipset规则：ipset restore -f /root/nginx_blocks.cfg
#删除ipset集合（需要先注释掉iptables.cfg中的ipset条目，重新加载iptables）：ipset destroy nginx_blocks
#查看集合：ipset list
# 恶意访问，提取特征码, 超过指定次数的ip直接加入ipset
#echo ---------evil_ip begin-----------------
#evil_count=1
#evil_regexp=`cat evil_content.txt | xargs | sed -E 's@[|/.${()!]@\\\\&@g;s!\s+!|!g'`
#evil_ipfiles=/home/qmliu/evil_ips.txt
#echo -------扫描当天访问日志，符合恶意特征码的ip
#awk 'BEGIN{IGNORECASE=1}$4 ~ /'"$evil_regexp"'/{print $1}' $log_path/bbs_access.log $log_path/admin_access.log $log_path/iphone_community.log $log_path/web_access.log | sort | uniq -c | sort -k1,1n | awk -v ct=$evil_count '$1>ct{print $0}' > $evil_ipfiles
#echo 直接加入ipset
##awk '{print $0;str="sudo ipset add nginx_blocks "$2; print str; system(str);}' $evil_ipfiles
#echo ----------evil_ip end----------------
