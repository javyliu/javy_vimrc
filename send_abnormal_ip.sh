#!/bin/bash
# Author: javy liu
#Date & Time: 2025-12-01 11:17:39
#Description: 分析每日异常ip, 然后发邮件到javy_liu@163.com

logpath=/home/upcera/upcera_docker/nginx/logs/
cd $logpath
cat access.log | awk '{$7=gensub(/(\/[^\/]+)(\/[^\/]+)+$/,"\\1","g", $7); a[$1"\t"$7]++}END{for(i in a) print i,a[i]}' | sort -k3nr | awk '!seen[$1]++{order[++n]=$1}{a[$1]=a[$1]$0"\n"}END{for(i=1;i<=n;i++) printf "%s",a[order[i]]}' > ips.log

head -50 ips.log | mail -r 'aierchuang_web@163.com' -s 'top abnormal ips' 'javy_liu@163.com'

echo "$(date) 异常ip发送成功"

