#!/usr/bin/env bash
# Author: javy liu
#Date & Time: 2025-11-28 12:01:42
#Description: 设置postfix 使用中继账号发送邮件
#发送方式：
# echo -n "要发送的文本" | mail -r '中邮箱箱' -s '邮件标题' ‘收件人'
# echo -n "test" | mail -r 'aierchuang_web@163.com' -s 'test' 'jav_liu@163.com'
#
# 使用 sendmail 发送
#
#sendmail javy_liu@163.com qmliu@pipgame.com <<EOF
#Subject: test email
#From: aierchuang_web@163.com
#To: javy_liu@163.com, qmliu@pipgame.com
#
#This is the email body for test
#`date`
#EOF


postfix_main="/etc/postfix/main.cf"
echo "配置 $postfix_main 文件"

if grep -q 'smtp.163.com' $postfix_main; then
        echo "已添加设置"
else

sed -i -E '/an.ip.add.ress\]/a\
\
relayhost = [smtp.163.com]:465\
smtp_sasl_auth_enable = yes\
smtp_tls_wrappermode = yes\
smtp_tls_security_level = encrypt\
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd\
smtp_sasl_security_options = noanonymous\
smtp_use_tls = yes' $postfix_main

fi

sed -i -E 's/^smtp_tls_security_level = may/#smtp_tls_security_level = may/' $postfix_main

echo 安装SASL认证模块

dnf install cyrus-sasl cyrus-sasl-plain -y

echo 创建中继账号密码文件

echo "[smtp.163.com]:465 $aier_user_and_pwd" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
chmod 600 /etc/postfix/sasl_passwd*

echo 重启postfix
systemctl restart postfix
~
~
