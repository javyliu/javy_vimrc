#!/usr/bin/env sh
# Author: javy liu
#Date & Time: 2019-12-02 17:30:28
#Description: 更改整个项目的名字，比如把该项目从pearl_platform 更改为 new_app
#使用方式: ./change_project_name.sh my_new_app

new_name=$1
new_constant=`echo $new_name|sed -r 's/\b\w|_./\U&/g;s/_//g'`
ori_name=${2:-pearl_platform}
ori_constant=`echo $ori_name|sed -r 's/\b\w|_./\U&/g;s/_//g'`
echo $new_name
echo $new_constant
cat << EOF
  ori_name: ${ori_name}, ori_constant: ${ori_constant}
  new_name: ${new_name}, new_constant: ${new_constant}
EOF
sed -i "s/${ori_name}/${new_name}/g" `ack -rl ${ori_name}  --ignore-file=ext:sh`
sed -i "s/${ori_constant}/${new_constant}/g" `ack -rl ${ori_constant}  --ignore-file=ext:sh`

