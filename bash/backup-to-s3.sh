#!/bin/bash

# === CONFIGURATION ===
TIMESTAMP=$(date +"%Y%m%d%H%M")
BACKUP_DIR="/home/ubuntu/db_backups"
FILENAME="backup-$TIMESTAMP.sql"
DB_HOST="serpent-db.cstiwmk8m9ja.us-east-1.rds.amazonaws.com"
DB_USER="admin"
DB_PASSWORD="adminpassword"
DB_NAME="serpent_surge_db"
S3_BUCKET="serpent-surge-backups-071dbadc"  # <-- Replace with actual bucket

# === CREATE BACKUP DIRECTORY IF NOT EXISTS ===
mkdir -p "$BACKUP_DIR"

# === RUN MYSQLDUMP ===
mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/$FILENAME"

# === UPLOAD TO S3 ===
aws s3 cp "$BACKUP_DIR/$FILENAME" "s3://$S3_BUCKET/$FILENAME"

# === CLEANUP OLD FILES (OPTIONAL) ===
# find "$BACKUP_DIR" -type f -mtime +7 -name "*.sql" -delete

