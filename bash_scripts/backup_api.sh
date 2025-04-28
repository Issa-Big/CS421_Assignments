#!/bin/bash

# File: backup_api.sh
# Purpose: Backup API project files and database

# Variables
TIMESTAMP=$(date "+%F")
BACKUP_DIR="/home/ubuntu/backups"
API_DIR="/home/ubuntu/CS421-API"   # Change this if your project path is different
DB_NAME="CS421_API"                # Your actual database name
DB_USER="root"
DB_PASSWORD="123456"                     # Your MySQL password (empty if no password)
LOG_FILE="/var/log/backup.log"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Start logging
echo "[$(date '+%F %T')] Starting backup..." >> "$LOG_FILE"

# Backup API project directory
tar -czf "$BACKUP_DIR/api_backup_$TIMESTAMP.tar.gz" "$API_DIR" 2>>"$LOG_FILE"
if [ $? -eq 0 ]; then
  echo "[$(date '+%F %T')] API project backup successful." >> "$LOG_FILE"
else
  echo "[$(date '+%F %T')] WARNING: API project backup FAILED." >> "$LOG_FILE"
fi

# Backup MySQL database
if [ -z "$DB_PASSWORD" ]; then
  mysqldump -u "$DB_USER" "$DB_NAME" > "$BACKUP_DIR/db_backup_$TIMESTAMP.sql" 2>>"$LOG_FILE"
else
  mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/db_backup_$TIMESTAMP.sql" 2>>"$LOG_FILE"
fi

if [ $? -eq 0 ]; then
  echo "[$(date '+%F %T')] Database backup successful." >> "$LOG_FILE"
else
  echo "[$(date '+%F %T')] WARNING: Database backup FAILED." >> "$LOG_FILE"
fi

# Delete backups older than 7 days
find "$BACKUP_DIR" -type f -mtime +7 -exec rm {} \;
echo "[$(date '+%F %T')] Old backups cleaned." >> "$LOG_FILE"

# Finish
echo "[$(date '+%F %T')] Backup completed." >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
