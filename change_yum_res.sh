#!/usr/bin/env sh
# Author: javy liu
#Date & Time: 2022-05-27 10:49:02
#Description: 更换centos8 的源，centos8 于2021年后不再更新

# 进入 /etc/yum.repos.d/ 目录
cd /etc/yum.repos.d/

# 运行以下命令
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

#换成alyun
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
yum clean all && yum makecache


# 重新运行 yum 命令
sudo yum update -y


