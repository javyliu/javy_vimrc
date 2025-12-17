#!/bin/bash
# Author: javy liu
#Date & Time: 2025-12-01 11:17:39
#Description: 分析每日异常ip, 然后发邮件到指定邮箱, 需根据服务器来设置用
# 邮件客户端为s-nail, 可以用 dnf install -y s-nail 来安装，配置 ~/.mailrc 文件来调协

logpath=/data3/access_logs/
cd $logpath
# $7 为user_agent,正常nginx日志应该是$4
# gensub 替换长链接及以/xx?后面的内容
cat web_access.log iphone_community.log | awk '{$4=gensub(/(\/[^\/]+)(\/[^\/]+|[?].*)+$/,"\\1","g", $4); a[$1"\t"$4]++}END{for(i in a) print i,a[i]}' | sort -k3nr | \
  awk '!seen[$1]++{order[++n]=$1}{a[$1]=a[$1]$0"\n"}END{for(i=1;i<=n;i++){
  print order[i] >> "uniq_ips.tmp"
  printf "%s",a[order[i]]
}}' > ips.tmp
# 只取排名前10的ip
ips=`head uniq_ips.tmp | xargs | sed 's/ /,/g'`
#ips=`awk '{print $1}' ips.log | uniq| head | xargs | sed 's/ /,/g'`

# 查询ip所在地区, 需先布署ipquery 容器，默认监听8080
curl -s "http://localhost:3006/query?ip=$ips"|jq -r '.[]|.ip+"\t"+.country+"/"+.province+"/"+.city' > ip_with_area.tmp

awk 'FILENAME==ARGV[1]{a[$1]=$2}FILENAME==ARGV[2]{
b[$1]++
print $0,a[$1]
if(length(b)>10){exit}
}' ip_with_area.tmp ips.tmp > mail_content.tmp

cat mail_content.tmp | mail -s 'TOP ABNORMAL IPS' 'qmliu@pipgame.com'
#awk '{
#        if(!a[$1]){
#                cmd="curl -s http://localhost:3006/query?ip="$1"|jq -r .country+"/"+.province+"/"+.city"
#                        if((cmd | getline res)>0){
#                                a[$1]=res
#                        }else{
#                                print $0
#                        }
#                close(cmd);
#        }
#        if(length(a)<=10){print $0,a[$1]}else{exit}
#
#}' ips.log | mail -s 'top abnormal ips' 'qmliu@pipgame.com'


#head -50 ips.log | mail -r 'aierchuang_web@163.com' -s 'top abnormal ips' 'javy_liu@163.com'

echo "$(date) 异常ip发送成功"
