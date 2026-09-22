#!/bin/bash
# Author: javy liu
#Date & Time: 2026-09-17 12:47:58
#Description: 主要用于在服务器执行简单命令，需提供服务器登入别名

server_name=$1
cmd=${@:2}
con=`gsed -nE "/\b$server_name\b/p" ~/.bash_profile|sed -E "s/.*'(.*)'.*/\1/"`

if [ -z "$con" ]; then
  echo "no alias"
else
  echo $con
  $con -o WarnWeakCrypto=no -T <<-EOF
    $cmd
EOF
fi

