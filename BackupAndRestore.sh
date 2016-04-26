#!/bin/bash

#forcing the user to run as root
if [ "$EUID" -ne "0" ]
then
	echo -e "\n\t--> You have to be root to run this file! < --\n"
	exit
fi

#Declaring GLOBAL variables
DIR_EX="/* --exclude=/dev/* --exclude=/boot/* --exclude=/cdrom/* --exclude=/dev/* --exclude=/home/* --exclude=/proc/* --exclude=/sys/*  --exclude=/tmp/* --exclude=/run/* --exclude=/lib/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found/* --exclude=/BackupFolder/* --exclude=/RestoreFolder/* --exclude=/ZippedFiles/* --exclude=/usr/* --exclude=/var/*"
DATE=`date +%d%m%y` #-%X`
DATE2=`date +"%A %d-%B-%Y %R"`
FILENAME=LinuxBackup-$DATE.tar.gz
SBLOG="--> $DATE2 -- Full System Back Up -- SUCCESSFULL! -- $FILENAME"
FBLOG="--> $DATE2 -- Full System Back Up -- UNSUCCESSFULL! -- $FILENAME"
SRLOG="--> $DATE2 -- Full System Restore -- SUCCESSFULL! -- "
FRLOG="--> $DATE2 -- Full System Restore -- UNSUCCESSFULL! -- "

#Declaring functions
#backup to root
option1() {
	clear
	cd /
	mkdir -p BackupFolder
	mkdir -p ZippedFiles
	BACKUP_TO="/BackupFolder/"

	echo -e "\n\t Comfirm backup into root backup folder?"
        echo -e "\n\t Please enter 1 for YES or 2 for NO."
        echo -e -n "\n\t ---> Input: "
        read answer

        if test $answer  = "1"
        then
                tar cvpfz /ZippedFiles/$FILENAME $DIR_EX
		clear
		rsync -av /ZippedFiles/ $BACKUP_TO
		#check if command is successful
		if [ "$?" -eq "0" ]
		then
  			echo -e "\n\t--> Files have been backed up!"
                	echo -e "\n\t--> Check backup folder in root!"
			#creating log file
			if [ ! -e /$BACKUP_TO/LogFile.log ]
		        then
                		echo $SBLOG > /$BACKUP_TO/LogFile.log
       			else
                		echo $SBLOG >> /$BACKUP_TO/LogFile.log
        		fi

		else
  			echo -e "\n\t--> Error occured! Please try again."
			if [ ! -e /$BACKUP_TO/LogFile.log ]
		        then
                		echo $FBLOG > /$BACKUP_TO/LogFile.log
        		else
                		echo $FBLOG >> /$BACKUP_TO/LogFile.log
       			fi
			return 0
		fi
        elif test $answer = "2"
        then
                return 0 #Bring back to the main menu
        else
                echo -e "\n\t INVALID INPUT!"
        fi
}
#backup to dropbox
option2() {
	clear
	cd /
        mkdir -p ZippedFiles
     	cd /home
	echo -e "\n\tThese are you home directories: \n\t--> $(ls)"
	echo -e "\n\tPlease enter which directory your Dropbox is located."
        echo -e -n "\n\t ---> Input: "
        read option
	USER=$option
	BACKUP_TO1="/home/$USER/Dropbox/"
	cd $BACKUP_TO1
	mkdir -p BackupFolder
	BACKUP_TO2="/home/$USER/Dropbox/BackupFolder"
	cd $BACKUP_TO2
	mkdir -p LinuxBackup
	BACKUP_TO3="/home/$USER/Dropbox/BackupFolder/LinuxBackup"
	cd /
	
	echo -e "\n\t Comfirm backup into Dropbox backup folder?"
        echo -e "\n\t Please enter 1 for YES or 2 for NO."
        echo -e -n "\n\t ---> Input: "
        read answer

	if test $answer  = "1"
        then
        	tar cvpfz /ZippedFiles/$FILENAME $DIR_EX
		clear
		rsync -av /ZippedFiles/ $BACKUP_TO3
		#check if command is successful
	        if [ "$?" -eq "0" ]
                then
                        echo -e "\n\t--> Files have been backed up!"
                        echo -e "\n\t--> Check backup folder in Dropbox!"
			if [ ! -e /$BACKUP_TO3/LogFile.log ]
        		then
                		echo $SBLOG > /$BACKUP_TO3/LogFile.log
        		else
                		echo $SBLOG >> /$BACKUP_TO3/LogFile.log
        		fi

                else
                        echo -e "\n\t--> Error occured! Please try again."
                        if [ ! -e /$BACKUP_TO3/LogFile.log ]
		        then
                		echo $FBLOG > /$BACKUP_TO3/LogFile.log
        		else
                		echo $FBLOG >> /$BACKUP_TO3/LogFile.log
        		fi
			return 0
                fi
        elif test $answer = "2"
        then
                return 0 #Bring back to the main menu
        else
                echo -e "\n\t INVALID INPUT!"
        fi
}
#backup to external memory
option3() {
	clear
	cd /
        mkdir -p ZippedFiles
	cd /media
	echo -e "\n\tThese are you directories for external memories: \n\t--> $(ls)"
	echo -e "\n\tPlease enter which directory your external memory is located."
        echo -e -n "\n\t ---> Input: "
	read INPUT1
	cd /media/$INPUT1
	echo -e "\n\tThese are the available external memories in selected directoy: \n\t--> $(ls)"
	echo -e "\n\tPlease enter which external memory you want to backup into."
        echo -e -n "\n\t ---> Input: "
	read INPUT2
	cd /media/$INPUT1/$INPUT2
	mkdir -p BackupFolder
	cd /media/$INPUT1/$INPUT2/BackupFolder
	mkdir -p LinuxBackup
	BACKUP_TO="/media/$INPUT1/$INPUT2/BackupFolder/LinuxBackup"
	cd /

	echo -e "\n\t Comfirm backup into external backup folder?"
        echo -e "\n\t Please enter 1 for YES or 2 for NO."
        echo -e -n "\n\t ---> Input: "
        read answer

        if test $answer  = "1"
        then
                tar cvpfz /ZippedFiles/$FILENAME $DIR_EX
		clear
		rsync -av /ZippedFiles/ $BACKUP_TO
		#check if command is successful
	        if [ "$?" -eq "0" ]
                then
                        echo -e "\n\t--> Files have been backed up!"
                        echo -e "\n\t--> Check backup folder in external memory!"
               		if [ ! -e /$BACKUP_TO/LogFile.log ]
        		then
                		echo $SBLOG > /$BACKUP_TO/LogFile.log
        		else
                		echo $SBLOG >> /$BACKUP_TO/LogFile.log
        		fi
 
		else
                        echo -e "\n\t--> Error occured! Please try again."
                        if [ ! -e /$BACKUP_TO/LogFile.log ]
        		then
                		echo $FBLOG > /$BACKUP_TO/LogFile.log
       			else
                		echo $FBLOG >> /$BACKUP_TO/LogFile.log
        		fi

			return 0
                fi
        elif test $answer = "2"
        then
                return 0 #Bring back to the main menu
        else
                echo -e "\n\t INVALID INPUT!"
        fi
}
#restore to root
option4() {
	clear
	cd /
	mkdir -p RestoreFolder
	rm -rf /RestoreFolder/*
	cd /BackupFolder
	echo -e "\n->Choose which of the following restore points to restore.\n"
	ls | grep LinuxBackup
	echo -e -n "\n\t ---> Input: "
	read RP

	echo -e "\n\t Comfirm restore?"
        echo -e "\n\t Please enter 1 for YES or 2 for NO."
        echo -e -n "\n\t ---> Input: "
        read answer

	if test $answer  = "1"
        then
               	tar zxvf $RP -C /RestoreFolder/
		#check if command is successfull
                if [ "$?" -eq "0" ]
                then
                        echo -e "\n\t--> Files has been restored successfully!"
			if [ ! -e /BackupFolder/LogFile.log ]
        		then
                		echo $SRLOG $RP > /BackupFolder/LogFile.log
        		else
                		echo $SRLOG $RP >> /BackupFolder/LogFile.log
        		fi
                else
                        echo -e "\n\t--> Error occured! Please try again."
                        if [ ! -e /BackupFolder/LogFile.log ]
                        then
                                echo $FRLOG $RP > /BackupFolder/LogFile.log
                        else
                                echo $FRLOG $RP >> /BackupFolder/LogFile.log
                        fi

			return 0
                fi
        elif test $answer = "2"
        then
                return 0 #Bring back to the main menu
        else
                echo -e "\n\t INVALID INPUT!"
        fi
}
#restore from dropbox
option5() {
	clear
	cd /
	mkdir -p RestoreFolder
	rm -rf /RestoreFolder/*
	
	cd /home
        echo -e "\n\tThese are you home directories: \n\t--> $(ls)"
        echo -e "\n\tPlease enter which directory your Dropbox is located."
        echo -e -n "\n\t ---> Input: "
        read option
        USER=$option
        cd /home/$USER/Dropbox/
        mkdir -p BackupFolder
        cd /home/$USER/Dropbox/BackupFolder
        mkdir -p LinuxBackup
        cd /home/$USER/Dropbox/BackupFolder/LinuxBackup
	BFOLDER="/home/$USER/Dropbox/BackupFolder/LinuxBackup"
	clear
	echo -e "\n->Choose which of the following restore points to restore.\n"
        ls | grep LinuxBackup
	echo -e -n "\n\t ---> Input: "
	read RP

	echo -e "\n\t Comfirm restore?"
        echo -e "\n\t Please enter 1 for YES or 2 for NO."
        echo -e -n "\n\t ---> Input: "
        read answer

        if test $answer  = "1"
        then
                tar zxvf $RP -C /RestoreFolder/
		#check if command is successfull
                if [ "$?" -eq "0" ]
                then
                        echo -e "\n\t--> Files has been restored successfully!"
               		if [ ! -e /$BFOLDER/LogFile.log ]
                        then
                                echo $SRLOG $RP > /$BFOLDER/LogFile.log
                        else
                                echo $SRLOG $RP >> /$BFOLDER/LogFile.log
                        fi
 
		else
                        echo -e "\n\t--> Error occured! Please try again."
                        if [ ! -e /$BFOLDER/LogFile.log ]
                        then
                                echo $FRLOG $RP > /$BFOLDER/LogFile.log
                        else
                                echo $FRLOG $RP >> /$BFOLDER/LogFile.log
                        fi

			return 0
                fi
        elif test $answer = "2"
        then
                return 0 #Bring back to the main menu
        else
                echo -e "\n\t INVALID INPUT!"
        fi

}
#restore from external memory
option6() {
	clear
	cd /
	mkdir -p RestoreFolder
	rm -rf /RestoreFolder/*

	cd /media
        echo -e "\n\tThese are you directories for external memories: \n\t--> $(ls)"
        echo -e "\n\tPlease enter which directory your external memory is located."
        echo -e -n "\n\t ---> Input: "
        read INPUT1
        cd /media/$INPUT1
        echo -e "\n\tThese are the available external memories in selected directoy: \n\t--> $(ls)"
        echo -e "\n\tPlease enter which external memory you want to backup into."
        echo -e -n "\n\t ---> Input: "
        read INPUT2
        cd /media/$INPUT1/$INPUT2
        mkdir -p BackupFolder
        cd /media/$INPUT1/$INPUT2/BackupFolder
        mkdir -p LinuxBackup
        BACKUP_TO="/media/$INPUT1/$INPUT2/BackupFolder/LinuxBackup"
	cd $BACKUP_TO

	echo -e "\n->Choose which of the following restore points to restore.\n"
        ls | grep LinuxBackup
	echo -e -n "\n\t ---> Input: "
	read RP

	echo -e "\n\t Comfirm restore?"
        echo -e "\n\t Please enter 1 for YES or 2 for NO."
        echo -e -n "\n\t ---> Input: "
        read answer

        if test $answer  = "1"
        then
                tar zxvf $RP -C /RestoreFolder/
		#check if command is successfull
                if [ "$?" -eq "0" ]
                then
                        echo -e "\n\t--> Files has been restored successfully!"
               		if [ ! -e /$BACKUP_TO/LogFile.log ]
                        then
                                echo $SRLOG $RP > /$BACKUP_TO/LogFile.log
                        else
                                echo $SRLOG $RP >> /$BACKUP_TO/LogFile.log
                        fi
 
		else
                        echo -e "\n\t--> Error occured! Please try again."
                        if [ ! -e /$BACKUP_TO/LogFile.log ]
                        then
                                echo $FRLOG $RP > /$BACKUP_TO/LogFile.log
                        else
                                echo $FRLOG $RP >> /$BACKUP_TO/LogFile.log
                        fi

			return 0
                fi
        elif test $answer = "2"
        then
                return 0 #Bring back to the main menu
        else
                echo -e "\n\t INVALID INPUT!"
        fi

}
#exit
option7() {
	clear
	#Reassuring if the user really want to exit
	echo -e "\n\t Do you really want to exit program?"
	echo -e "\n\t Please enter 1 for YES or 2 for NO."
	
	echo -e -n "\n\t--->Input: "
	read answer
	
	if test $answer  = "1"
	then
		clear
		echo -e "\n\t----> GOODBYE! <----\n"
		exit

	elif test $answer = "2"
	then
		return 0 #Bring back to the main menu

	else
		echo -e "\n\t INVALID INPUT!"
	fi
}

#Main Function

i=1 #Used to make an infinite while loop to keep the program runnning
while [ $i -eq 1 ]
do
	#Forces the user to press enter to proceed to main menu
	echo -e "\n\n\t=============================================="
	echo -e "\t---> Press enter to continue to main menu <---"
	echo -e "\t=============================================="
	read enter
	clear

	echo -e "\n\t Choose from the following options 1 to 7."
	echo -e "\t================================================"
	echo -e "\t1 --> Backup into backup folder in root."
	echo -e "\t2 --> Backup into backup folder in Dropbox."
	echo -e "\t3 --> Backup into external memory."
	echo -e "\t================================================"
	echo -e "\t4 --> Restore into root from root backup folder."
	echo -e "\t5 --> Restore into root from Dropbox."
	echo -e "\t6 --> Restore into root from external memory."
	echo -e "\t================================================"
	echo -e "\t7--> Exit program."
	echo -e "\t================================================"
	echo -e -n "\n\t ---> Input: "	
	read option

	#Case statement used to call functions
	case $option in
		1) option1;;
		2) option2;;
		3) option3;;
		4) option4;;
		5) option5;;
		6) option6;;
		7) option7;;
		#If  wrong option is entered, this will give an error message
		*) echo -e "$(clear)\n\t---> INVALID INPUT! <---";;
	esac
done
