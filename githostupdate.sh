#!/usr/bin/env sh
# Author: javy liu
#Date & Time: 2023-11-08 09:40:38
#Description: 每二十分钟更新一次host

sed -i "" "/# GitHub520 Host Start/,/# Github520 Host End/d" /etc/hosts && curl https://raw.hellogithub.com/hosts >> /etc/hosts

