#!/usr/bin/env sh
# Author: javy liu
# Date & Time: 2025-11-27 14:58:01
# Description:
# 实时监控 eth0 出口流量 (TX) 并显示用户态流量对比
# 依赖: awk, sleep, nethogs

# 监控网卡
IFACE="eth0"
INTERVAL=1  # 秒

# 获取初始值
prev_bytes=$(grep "$IFACE:" /proc/net/dev | awk '{print $10}')

echo "Monitoring $IFACE every $INTERVAL second(s)..."
echo "Time           TX_total_MB/s   nethogs_MB/s"

while true; do
    sleep $INTERVAL

    # 当前总发送字节
    curr_bytes=$(grep "$IFACE:" /proc/net/dev | awk '{print $10}')

    # 增量字节 / 秒
    delta=$((curr_bytes - prev_bytes))
    tx_MB=$(awk -v b=$delta -v i=$INTERVAL 'BEGIN{printf "%.2f", b/(1024*1024)/i}')
    prev_bytes=$curr_bytes

    # 获取用户态流量（nethogs 输出抓取 eth0）
    # nethogs 必须安装，-t 表示文本模式, -c 1 表示刷新一次
    nethogs_TX_MB=$(nethogs -t -c 1 $IFACE 2>/dev/null | awk -F'\t' '{sum+=$2} END{printf "%.2f", sum/1024}' )

    # 输出
    echo "$(date '+%H:%M:%S')      $tx_MB          $nethogs_TX_MB"
done
