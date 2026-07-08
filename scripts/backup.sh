#!/bin/bash

############################################
# PostgreSQL Backup Script
############################################


set -e


# Database Configuration

DB_HOST=$1

DB_PORT=${2:-5432}

DB_NAME=$3

DB_USER=$4


# Backup Directory

BACKUP_DIR="./backup"


DATE=$(date +"%Y-%m-%d_%H-%M-%S")


BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${DATE}.sql"



############################################
# Create Backup Directory
############################################

mkdir -p $BACKUP_DIR



############################################
# Database Backup
############################################

echo "Starting database backup..."



PGPASSWORD=$PGPASSWORD pg_dump \

-h $DB_HOST \

-p $DB_PORT \

-U $DB_USER \

-d $DB_NAME \

-F p \

-f $BACKUP_FILE



echo "Backup completed successfully"

echo "File: $BACKUP_FILE"