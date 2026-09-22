#!/bin/bash
# Author: javy liu
#Date & Time: 2026-09-17 12:47:58
#Description: 主要用于在服务器执行简单命令，需提供服务器登入别名

server_name=$1
cmd=${@:2}
os=$(uname -s)
if [[ "$os" == "Darwin" ]];then
  SED="gsed"
  bash_file="$HOME/.bash_profile"
  ops="-o WarnWeakCrypto=no"
else
  SED="sed"
  bash_file="$HOME/.bashrc"
  ops=""
fi
con=`$SED -nE "/\b$server_name\b/p" $bash_file | $SED -E "s/.*'(.*)'.*/\1/"`

if [ -z "$con" ]; then
  echo "no alias"
else
  echo $con
  $con $ops -T <<-EOF
    $cmd
EOF
fi

