#!/bin/sh
BACKUP_DIR="/home/acha/backups"
TARGET_DIR="/home/ppioli/data"
CREATE=0
FETCH=0
RESTORE=0
DEFAULT=0
show_help(){
    echo "-c Create: Creates the backup on the server"
    echo "-f Fetch: Copies the latest backup to the current dir"
    echo "-r Restore: Drops the local db and restores the backup"
    echo "By default, all flags are passed"
} 

while getopts "h?cfr" opt; do
    DEFAULT=1
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    c)  CREATE=1
        ;;
    f)  FETCH=1
        ;;
    r)  RESTORE=1
        ;;
    esac
done
if [ $DEFAULT -eq 0 ]; then
    CREATE=1
    FETCH=1 
    RESTORE=1
fi

if [ $CREATE -eq 1 ]; then
    echo "Creating backup"
    ssh acha@192.168.137.118 "sh $BACKUP_DIR/backup.sh"
fi
if [ $FETCH -eq 1 ]; then
    echo "Fetching backup" 
    scp acha@192.168.137.118:$BACKUP_DIR/latest.sql.gz $TARGET_DIR
fi
if [ $RESTORE -eq 1 ]; then
    echo "Restoring Backup"
    dropdb acha --username acha
    createdb acha --username acha
    gunzip < $TARGET_DIR/latest.sql.gz | psql acha - --username acha
fi

