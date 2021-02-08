#!/bin/bash
source ./backup_restore_lib.sh

if [ "$#" -ne 3 ];then #check that 3 parameters are recieved

	echo "You must enter 3 parameters"
	echo "Enter the file name ./backup.sh followed by three parameters dirToBackUp
       	dirToStoreBackUp Key" #help msg
	exit 1
fi

#bash variables of the 3 params

DIR_TO_BACKUP="$1"
DIR_TO_STORE_BACKUP="$2"
KEY="$3"

echo $DIR_TO_BACKUP
echo $DIR_TO_STORE_BACKUP
echo $KEY


validate_backup_params $DIR_TO_BACKUP

#snapshot of current date
#replace any space or colon with underscore

DATE=$(date | sed s/\ /_/g | sed s/\:/_/g )
#echo $DATE

#call backup function
backup $DIR_TO_STORE_BACKUP $DATE $DIR_TO_BACKUP $KEY


