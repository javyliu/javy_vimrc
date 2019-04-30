#!/usr/bin/env sh
# Author: javy liu
#Date & Time: 2017-09-29 18:00
#Description: use this create a base shell script
#$0：是脚本本身的名字；
#$#：是传给脚本的参数个数；
#$@：是传给脚本的所有参数的列表，即被扩展为"$1" "$2" "$3"等；
#$*：是以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个，即被扩展成"$1c$2c$3"，其中c是IFS的第一个字符；
#$$：是脚本运行的当前进程ID号；
#$?：是显示最后命令的退出状态，0表示没有错误，其他表示有错误；
#echo '根据nginx日志统计代理的访问次数，排降序排列'

if [[ -n "$1" ]]; then
  newfile=$1
else
  newfile=`pwd`/newscript_`date +%m%d_%S`
fi

if ! grep "^#!" $newfile &>/dev/null; then
  cat >> $newfile << EOF
#!/usr/bin/env sh
# Author: javy liu
#Date & Time: `date +"%F %T"`
#Description: $2

EOF
fi

vim +5 $newfile

