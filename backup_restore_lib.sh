#!/bin/bash


function validate_backup_params(){
#check if backup directory exists

if [ ! -d "$1" ]; then

	echo "Not a valid directory to backup" 
	exit 1
fi

	
}


function validate_restore_params(){
#check if the directory to restore exists
if [ ! -d "$1" ]; then

	echo "Not a valid directory to restore" 
	exit 1
fi

	
}

function backup(){

 cd $1 # name of directory to store backup in
 mkdir $2 # date
 cd $3  # directory to be backed up
 for file in * ; do
	 
	echo ${file}
	tar -cvzf ./${file}_$2.tgz ./${file} #create tar.gz  
       	gpg --symmetric --batch --yes --passphrase $4 --output $1/$2/${file}_$2.tgz.gpg ./${file}_$2.tgz
	#encrypt file using given key $4
	rm -r ${file} #delete original file
	rm -r ./${file}_$2.tgz #delete compressed file
 done

 tar -cvf ./all.tgz $1/$2/test1.txt_$2.tgz.gpg #first file /switch

 for efile in * ; do
 tar -uvf ./all.tgz $1/$2/${file}_$2.tgz.gpg #add other files to the previous .tgz 

 done

 tar -cvzf ./allC.tgz ./all.tgz #compress the tar file
 rm -r ./all.tgz #delete prev tar file
 #encrypt the compressed file
 gpg --symmetric --batch --yes --passphrase $4 --output $1/$2/allEncFiles.tgz.gpg ./allC.tgz
 rm -r ./allC.tgz #delete the prev compressed .tgz file

}

function restore(){
 mkdir $2
 cd $1
	for file in * ;do
	#gpg -d ./${file} --o ./$2/${file} 
	#gpg --output $2/${file} --decrypt ./${file} --passphrase $4
	gpg --pinentry-mode=loopback --passphrase $3 -d -o $2/${file} ./${file}
	done

	cd $2 #go to temp dir
	for file in * ; do
	tar -xvzf ${file}
	rm -r ${file}
	done

}
