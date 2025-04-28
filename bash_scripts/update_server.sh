#!/bin/bash

# File: update_server.sh
# Purpose: Update system packages and deployed API project

# Variables
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOG_FILE="/var/log/update.log"
API_DIR="/home/ubuntu/CS421-API"   # Path to your API project
GIT_REPO="https://github.com/Issa-Big/CS421_Assignments.git"  # (Not needed unless cloning new)

# Start logging
echo "[$TIMESTAMP] Starting system and API update..." >> "$LOG_FILE"

# Update Ubuntu packages
echo "[$TIMESTAMP] Updating Ubuntu packages..." >> "$LOG_FILE"
sudo apt update && sudo apt upgrade -y >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] System update successful." >> "$LOG_FILE"
else
    echo "[$TIMESTAMP] WARNING: System update failed." >> "$LOG_FILE"
fi

# Pull latest changes from GitHub
echo "[$TIMESTAMP] Pulling latest changes from GitHub..." >> "$LOG_FILE"
cd "$API_DIR"
git pull origin main >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] Git pull successful." >> "$LOG_FILE"

    # Restart Nginx and PM2 to apply new changes
    echo "[$TIMESTAMP] Restarting services..." >> "$LOG_FILE"
    sudo systemctl restart nginx
    pm2 restart index.js

    echo "[$TIMESTAMP] Services restarted successfully." >> "$LOG_FILE"
else
    echo "[$TIMESTAMP] WARNING: Git pull failed. Services NOT restarted." >> "$LOG_FILE"
    exit 1
fi

# Finish
echo "[$TIMESTAMP] Update process completed." >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
