#!/bin/bash

source ./backup_restore_lib.sh

if [ "$#" -ne 3 ];then

	echo "You must enter 3 parameters"
	echo "Enter the file name ./restore.sh followed by three parameters dirToRestore
       	dirToStore  decrKey"
	exit 1
fi

DIR_TO_RESTORE="$1"
DIR_TO_STORE="$2"
DEC_KEY="$3"

echo $DIR_TO_RESTORE
echo $DIR_TO_STORE
echo $DEC_KEY


validate_restore_params $DIR_TO_RESTORE


restore $DIR_TO_RESTORE $DIR_TO_STORE $DEC_KEY


