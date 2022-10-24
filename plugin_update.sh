#!/usr/bin/env sh
# Author: javy liu
#Date & Time: 2022-10-24 09:43:39
#Description: git pull all vim plugin

#change plugin src to git@github.com:xxx

sed -i -E 's/(https|git)\:\/\/github.com\//git@github.com:/' ~/.vim/bundle/**/.git/config

dir=$(ls -d ~/.vim/bundle/*)
for folder in $dir ; do
  echo "current is $folder"
  cd $folder && git pull
done

