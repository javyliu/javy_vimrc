#!/usr/bin/env bash
# Author: javy liu
#Date & Time: 2023-03-15 11:59:09
#Description: 用于更新所有插件

vimpath="/home/`whoami`/.vim/bundle/"
echo $vimpath
find $vimpath -name config | xargs sed -i 's!git://github.com/!git@github.com:!'
for fold in `ls $vimpath `; do
  echo $fold
  cd "$vimpath/$fold"
  git pull
  cd ..
done


