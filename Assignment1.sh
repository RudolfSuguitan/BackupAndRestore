
#Declaring functions for options A to K
EXCLUDE_DIRS="/* --exclude=/dev/* --exclude=/boot/* --exclude=/cdrom/* --exclude=/dev/* --exclude=/home/* --exclude=/proc/* --exclude=/sys/*  --exclude=/tmp/* --exclude=/run/* --exclude=/lib/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found/* --exclude=/backupfolder/* --exclude=/ZippedFiles/* --exclude=/usr/* --exclude=/var/*"
DATE=`date +%d%m%y` #-%X`
FILENAME=backup-$DATE.tar.gz

optionA() {
	clear
	cd /
	mkdir -p backupfolder
	mkdir -p ZippedFiles
	BACKUP_TO="/backupfolder/"
	tar cvpfz /ZippedFiles/$FILENAME $EXCLUDE_DIRS && rsync -av --delete /ZippedFiles/ $BACKUP_TO
	echo -e "\n-->Files have been backed up!"
}

optionB() {
	clear
	cd /
	mkdir -p backupfolder
        mkdir -p ZippedFiles
     	cd /home
	echo -e "\n\tThese are you home directories: \n\t--> $(ls)"
	echo -e "\n\tPlease enter which directory your Dropbox is located."
        echo -e -n "\n\t--->Input: "
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
        tar cvpfz /ZippedFiles/$FILENAME $EXCLUDE_DIRS && rsync -av --delete /ZippedFiles/ $BACKUP_TO3
        echo -e "\n\t-->Files have been backed up!"
	echo -e "\n\t-->Check Dropbox folder!"
}

optionC() {
	clear
	cd /
        mkdir -p backupfolder
        mkdir -p ZippedFiles
	cd /media
	echo -e "\n\tThese are you directories for external memories: \n\t--> $(ls)"
	echo -e "\n\tPlease enter which directory your external memory is located."
        echo -e -n "\n\t--->Input: "
	read INPUT1
	cd /media/$INPUT1
	echo -e "\n\tThese are the available external memories in selected directoy: \n\t--> $(ls)"
	echo -e "\n\tPlease enter which external memory you want to backup into."
        echo -e -n "\n\t--->Input: "
	read INPUT2
	cd /media/$INPUT1/$INPUT2
	mkdir -p BackupFolder
	cd /media/$INPUT1/$INPUT2/BackupFolder
	mkdir -p LinuxBackup
	BACKUP_TO="/media/$INPUT1/$INPUT2/BackupFolder/LinuxBackup"
	cd /
	tar cvpfz /ZippedFiles/$FILENAME $EXCLUDE_DIRS && rsync -av --delete /ZippedFiles/ $BACKUP_TO
	echo -e "\n\t-->Files have been backed up!"
        echo -e "\n\t-->Check external memory!"
}

optionD() {
	clear
	echo -e "\n-->Your current path settings is:\n$PATH"
	echo -e "\n-->Your current working directory is: $(pwd)."
}

optionE() {
	clear
	#pipe users command and display the number of words - ie. numbers of users
	echo -e "\n-->The number of users currently logged are: $(users | wc -w)."
}

optionF() {
	clear
	echo -e "\n-->OS version is:\n$(uname -o)."
	echo -e "\n-->Release number is:\n$(uname -r)."
  	echo -e "\n-->Kernel version is: $(uname -v)."
}

optionG() {
	clear
	echo -e "\n-->CPU information is:\n$(lscpu)."
	#Read contents of /proc/cpuinfo, pipe it and use grep to only display the line of where the keyword is found then pipe grep and use uniq to stop displaying data twice
	echo -e "\n-->Processor model name is:\n$(cat /proc/cpuinfo | grep "model name" | uniq)."
	#Pipe cat /proc/cpuinfo then Search keyword "cpu MHz" but only display it once
	echo -e "\n-->Processor speed is:\n$(cat /proc/cpuinfo | grep "cpu MHz" | uniq)."
	echo -e "\n-->The uptime is:\n$(uptime)."
}

optionH() {
	clear
	#Scan PATH commmand from the start to the end and when it detects ':' it will go to a new line
	echo -e "\n-->Path directories:"
	temp=$IFS
	IFS=: #Change IFS into :
	printf "\n%s\n" $PATH
	IFS=$temp #change IFS back to default
}

optionI() {
	clear
	cd #Go to home directory

	i=1 #To make an infinite while loop
	while [ $i -eq 1 ]
	do
		optionI2 #Call function
		#Give options to users to know what they want to do next
		echo -e "\n\tTo enter new directory, input 'd'."
		echo -e "\n\tTo go back to home directory, input 'h'."
		echo -e "\n\tTo go back main menu, input 'm'."
		
		echo -e -n "\n\t-->Input: "
		read input

		if test $input  = "d" -o $input = "D"
		then
			echo -e "\n\tPlease enter a directory."
			echo -e -n "\n\t-->Input: "
			read directory
			clear		
			cd $directory/ #Go to user's chosen directory
		
		elif test $input  = "h" -o $input = "H"
		then
			cd #Go to home directory
			clear
	
		elif test $input  = "m" -o $input = "M"
		then
			return 0 #Go back to main menu

		else 
			echo -e "\n\t INVALID INPUT!"
		fi
	done
}

optionI2() { #Function for optionI. Reduce length of code
	echo -e "\n-->Your current working directory is: $(pwd)."
	
#This part of code uses awk command to print the headings for each column of directories and files. Then pipe ls -l command and using awk to be able put tab between the columns to match the headings and lastly pipe awk and use grep to separate directories and files
	echo -e "\n-->List of subdirectories in this directory:\n"
	awk 'BEGIN {print "Permissions\tLinks\tUsers\tGroups\tSize\tMonth\tDay\tTime\tDirectories";}'
	
ls -l | awk '{print $1,"\t",$2,"\t",$3,"\t",$4,"\t",$5,"\t",$6,"\t",$7,"\t",$8,"\t",$9;}' | grep drw #grep drw Keyword for directories

	echo -e "\n-->List of files in this directory:\n"
	awk 'BEGIN {print "Permissions\tLinks\tUsers\tGroups\tSize\tMonth\tDay\tTime\tFiles";}'
	
ls -l | awk '{print $1,"\t",$2,"\t",$3,"\t",$4,"\t",$5,"\t",$6,"\t",$7,"\t",$8,"\t",$9;}' | grep rw- #grep rw- keyword for files
}

optionJ() {
	clear	
	cd #Go to home directory

	i=1 #Make an infinite while loop
	while [ $i -eq 1 ]
	do
		optionJ2 #Call funtion
		#Give options to users to know what they want to do next
		echo -e "\n\tTo enter new directory or subdirectory, input 'd'."
		echo -e "\n\tTo go back to home directory, input 'h'."
		echo -e "\n\tTo go back main menu, input 'm'."
		
		echo -e -n "\n\t-->Input: "
		read input

		if test $input  = "d" -o $input = "D"
		then
			echo -e "\n\tPlease enter a directory or subdirectory."
			echo -e -n "\n\t-->Input: "
			read directory
			clear		
		
			cd $directory/ #Go to user’s chosen directory

		elif test $input  = "h" -o $input = "H"
		then
			cd #Go to home directory			
			clear

		elif test $input  = "m" -o $input = "M"
		then
			return 0 #Go back to main menu

		else 
			echo -e "\n\t INVALID INPUT!"
		fi
	done
}

optionJ2() { #Funtion for optionJ. Reduce code length.
	echo -e "\n-->Your current working directory is: $(pwd)."
	#-s is for summary, -h shows unit of measurement in human readable form
	#* show files or subdirectories in current directory
	echo -e "\n-->Sizes of each files and subdirectories in this directory:\n$(du -sh *)"
	#Only shows the total size of current directory
	echo -e "\n-->Total size of this directory is --> $(du -sh)"
}

optionK() {
	clear
	#Reassuring if the user really want to exit
	echo -e "\n\t Do you really want to exit program?"
	echo -e "\n\t Please enter 'Y' YES or 'N' NO."
	
	echo -e -n "\n\t--->Input: "
	read answer
	
	if test $answer  = "y" -o $answer = "Y"
	then
		echo -e "\n\t---->GOODBYE!<----\n"
		exit

	elif test $answer = 'n' -o $answer = 'N'
	then
		return 0 #Bring back to the main menu

	else #Forces the user to only enter capitaL or small 'y' or 'n'.
		echo -e "\n\t INVALID INPUT!"
	fi
}

#Main Function

i=1 #Used to make an infinite while loop to keep the program runnning
while [ $i -eq 1 ]
do
	#Forces the user to press enter to proceed to main menu
	echo -e "\n\n\t--->Press enter to continue to main menu.<---"
	read enter
	clear

	echo -e "\n\tChoose from the following option A to K."
	echo -e "\n\tA-->Back up into root."
	echo -e "\tB-->Back up into Dropbox folder."
	echo -e "\tC-->Back up into external memory."
	echo -e "\tD-->Show current path settings and current working directory."
	echo -e "\tE-->Show the number of users currently logged."
	echo -e "\tF-->Show the OS version, release number, and kernel version."
	echo -e "\tG-->Show CPU info, processor model name, speed, and uptime."
	echo -e "\tH-->Display all directories in PATH."
	echo -e "\tI-->Display the info from the ls -l command."
	echo -e "\tJ-->Summary of the disk space usage for each directory argument."
	echo -e "\tK-->Exit program."

	echo -e -n "\n\t--->Input: "	
	read option

	#Case statement used to call functions
	case $option in
		a|A) optionA;;
		b|B) optionB;;
		c|C) optionC;;
		d|D) optionD;;
		e|E) optionE;;
		f|F) optionF;;
		g|G) optionG;;
		h|H) optionH;;
		i|I) optionI;;
		j|J) optionJ;;
		k|K) optionK;;
		#If  wrong option is entered, this will give an error message
		*) echo -e "\n\tINVALID INPUT!";;
	esac
done
