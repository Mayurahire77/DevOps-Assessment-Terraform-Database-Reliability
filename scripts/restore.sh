#!/bin/bash


############################################
# PostgreSQL Restore Script
############################################


set -e



DB_HOST=$1

DB_PORT=${2:-5432}

DB_NAME=$3

DB_USER=$4

BACKUP_FILE=$5



############################################
# Restore Database
############################################


echo "Starting database restore..."



PGPASSWORD=$PGPASSWORD psql \

-h $DB_HOST \

-p $DB_PORT \

-U $DB_USER \

-d $DB_NAME \

-f $BACKUP_FILE



echo "Database restore completed successfully"