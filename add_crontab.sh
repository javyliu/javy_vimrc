#!/bin/bash
# Author: javy liu
#Date & Time: 2025-03-06 12:09:55
#Description: 添加crontab脚本

# 定义要添加的cron任务
script_path=${HOME}/upcera_docker/certs/renew_letsencrypt.sh
needed_crons=(
"3 2 * * * sleep \$((RANDOM\%90));${HOME}/upcera_docker/renew_letsencrypt.sh >> ${HOME}/upcera_docker/renew.log 2>&1"
"3 3 * * * ${HOME}/upcera_docker/backup_data.sh >> ${HOME}/upcera_docker/backup.log 2>&1"
"3 4 * * * sleep \$((RANDOM\%90)); podman exec aier bin/rails update_factory:run >> ${HOME}/upcera_docker/update_factory.log 2>&1"
"0 2 * * * ${HOME}/upcera_docker/send_abnormal_ip.sh >> ${HOME}/upcera_docker/send_abnormalip_mail_log.log 2>&1"
)

#echo $renew_certs
# 创建临时文件
TEMP_FILE=$(mktemp) || { echo "创建临时文件失败"; exit 1; }

# 导出当前crontab内容，忽略错误（如无现存任务）
crontab -l 2>/dev/null > "$TEMP_FILE"
echo "=======origin===="
cat $TEMP_FILE
echo "=======origin end===="

# -F 表示按字面量查找，不使用正则，多个字面量可以用 grep -F -e 'sldfkj' -e 'slkdjf'
for line in "${needed_crons[@]}" ; do
  grep -F -x -q "$line" "$TEMP_FILE" > /dev/null
  if [ $? -ne 0 ]; then
    echo "添加缺失任务：$line"
    echo "$line" >> "$TEMP_FILE"
  fi
done

crontab "$TEMP_FILE" && echo "Cron任务添加成功。"


# 清理临时文件
rm -f "$TEMP_FILE"
