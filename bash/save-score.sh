#!/bin/bash

# === CONFIG ===
DB_HOST="serpent-db.cstiwmk8m9ja.us-east-1.rds.amazonaws.com"
DB_USER="admin"
DB_PASSWORD="adminpassword"
DB_NAME="serpent_surge_db"

# === INPUT ===
read -p "Enter player name: " PLAYER
read -p "Enter score: " SCORE

# === EXECUTE SQL ===
SQL="INSERT INTO scores (player_name, score) VALUES ('$PLAYER', $SCORE);"

mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -e "$SQL"

echo "✅ Saved score for $PLAYER with $SCORE points!"

