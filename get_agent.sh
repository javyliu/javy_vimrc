#!/usr/bin/env bash
#$0：是脚本本身的名字；
#$#：是传给脚本的参数个数；
#$@：是传给脚本的所有参数的列表，即被扩展为"$1" "$2" "$3"等；
#$*：是以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个，即被扩展成"$1c$2c$3"，其中c是IFS的第一个字符；
#$$：是脚本运行的当前进程ID号；
#$?：是显示最后命令的退出状态，0表示没有错误，其他表示有错误；
echo '根据nginx日志统计代理的访问次数，排降序排列'


while getopts "s:e:f:F:c:H:" arg #选项后面的冒号表示该选项需要参数
do
  case $arg in
    s)
      start_date=$OPTARG
      echo "start date: $start_date" #开始日期
      ;;
    e)
      end_date=$OPTARG
      echo "end date:" $end_date #结束日期
      ;;
    f)
      origin_filename=$OPTARG
      echo "filename: $filename" #要分析的文件名
      ;;
    F)
      separtor=$OPTARG
      ;;
    c)
      columns=$OPTARG
      ;;
    H)
      lines=$OPTARG
      ;;
    ?)  #当有不认识的选项的时候arg为?
      echo "unkonw argument"
      exit 1
      ;;
  esac
done

filename=${origin_filename:='web_access.log'}
separtor=${separtor:-" "}
columns=${columns:-1}
lines=${lines:-150}

t2=$(date -d "$end_date" +%s)

if [[ -n $start_date ]]; then
  end_date=${end_date:-$(date -d "-1 days" +%Y-%m-%d)}

  t1=$(date -d "$start_date" +%s)

  while [[ $t2 -gt $t1 ]]; do
    filename="$filename $origin_filename.$start_date"
    start_date=$(date -d "$start_date 1 days" +%Y-%m-%d)
    t1=$(date -d "$start_date" +%s)
  done
fi

#可以传分隔符及需打印列的值
parselog() {
  f=$1
  #echo -e "--------------------------\n$f\n------------------------------" >> $target_filename && awk -F\" '{a[$6]++;}END{for(k in a){print a[k]":"k}}' $f|sort -t: -k1,1nr >> $target_filename
  echo -e "--------------------------\n$f\n------------------------------" && awk -v FS="$separtor" -v N="$columns" '{print $N}' $f|sort|uniq -c|sort -rnk1,1|head -n ${lines}

}

#echo -n '' > $target_filename
for f in $filename ; do
  echo "正在解析 $f"
  parselog $f
done

#read this file every day hahaha!
