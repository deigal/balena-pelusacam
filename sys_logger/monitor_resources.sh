#!/bin/bash

LOG_FILE="/app/logs/system_resources.log"
mkdir -p /app/logs
echo "System Resource Monitoring - $(date)" > "$LOG_FILE"

while true; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")  # Format: YYYY-MM-DD HH:MM:SS
    CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2+$4}')
    MEM_USAGE=$(free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB", $3,$2}')
    DISK_USAGE=$(df -h | awk '$NF=="/"{printf "Disk: %s/%s", $3,$2}')

    echo "$TIMESTAMP | CPU Load: ${CPU_LOAD}% | Memory: ${MEM_USAGE} | Disk: ${DISK_USAGE}" >> "$LOG_FILE"

    sleep 1  # Log every second
done
