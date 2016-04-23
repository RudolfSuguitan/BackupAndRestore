#!/bin/bash
#Declaring variables
DIR_EX="/* --exclude=/dev/* --exclude=/boot/* --exclude=/cdrom/* --exclude=/dev/* --exclude=/home/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/lib/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found/* --exclude=/BackupFolder/*  --exclude=/RestoreFolder/* --exclude=/ZippedFiles/* --exclude=/usr/* --exclude=/var/*"
DATE=`date +%d%m%y` #-%X`
DATE2=`date +"%A %d-%B-%Y %R"`
FILENAME=Backup-$DATE.tar.gz

SBLOG="--> $DATE2 -- $FILENAME -- Full System Back Up -- SUCCESSFULL <--"
FBLOG="--> $DATE2 -- $FILENAME -- Full System Back Up -- UNSUCCESSFULL <--"
cd /
mkdir -p BackupFolder
mkdir -p ZippedFiles
BACKUP_TO="/BackupFolder/"

tar cvpfz /ZippedFiles/$FILENAME $DIR_EX && rsync -av /ZippedFiles/ $BACKUP_TO

if [ "$?" -eq "0" ]
then
	if [ ! -e /$BACKUP_TO/LogFile.txt ]
	then
   		echo $SBLOG > /$BACKUP_TO/LogFile.txt
	else
   		echo $SBLOG >> /$BACKUP_TO/LogFile.txt
	fi

else
	if [ ! -e /$BACKUP_TO/LogFile.txt ]
        then
                echo $FBLOG > /$BACKUP_TO/LogFile.txt
        else
                echo $FBLOG >> /$BACKUP_TO/LogFile.txt
        fi
fi


