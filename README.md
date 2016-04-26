#BackupAndRestore
#Assignment for Software Installation
#Rudolf Suguitan - C13460538

This assignment allows the users to back up and restore the entire* root  
directory to 3 different locations: to a backup folder in the root directory,  
to Dropbox for cloud storage, and an external memory. Users can also  
restore selected backup from these locations.  

To start, open terminal and enter 'sudo su'. After entering your password,  
enter the command 'cd /' to go to root. Then clone BackupAndRestore  
repository by entering this code:  
git clone "https://github.com/RudolfSuguitan/BackupAndRestore.git"  
You should not anything from this repository in the root  
You also have to be logged in as root to run scripts    

The repository should include 3 files, BackupAndRestore.sh, AutoBackup,sh,  
and README.md which must be read first before runningthe 2 .sh files.  
Check the following steps:  

1-Install rsync  
	You can check if rsync is installed on your device by entering this  
	command on the terminal: apt-cache policy rsync If rsync is not  
	installed on your device, install it by entering this command on the  
	terminal: sudo apt-get install rsync  
2-Setup Auto Backup  
	This is done by adding a line of code in crontab. You can do this by  
	entering 'sudo crontab -e' in the root. Then before entering the date  
	and command, understand that in crontab there are 6 columns:  
	m = minuntes, h = hour(24), dom = day of month, y = year,  
	dow = day of week(0-6=Sunday-Saturday), and the command.  
	For example: 30 10 * * 1,5 /bin/bash /BackupAndRestore/AutoBackup.sh,  
	this will run the code AutoBackup.sh every 10:30 am on Monday and  
	Friday. If your want backup schedule to be like this, enter this code  
	at the end of crontab. You can make any changes on the schedule time  
	to whichever you prefer.  
3-Permissions  
	The sh files should be ready to go but in case they arent,  
	add excutable permissions to them by entering:  
	chmod 755 BackupAndRestore.sh, chmod 755 AutoBackup.sh, and to run the  
	scripts enter ./NameOfFile. When running these, you have to be the root.  
	use the command: sudo su  

HOW THE CODE WORKS  
1-AutoBackup.sh  
	This code should be only used for scheduled backup like mentioned above.  
	However you can still run this but will only be able to  
	backup to the backup folder in the root.  
2-BackupAndRestore.sh  
	This script when ran, will allow the users to backup the root directory  
	into 3 locations and restore the backups from these locations to the  
	RestoreFolder in the root. These options are shown on the main menu.  
	this script also includes error checkings which catch any invalid inputs  
	and display error messages. eg when backup or restore was unsuccessful.  
	note that you can only restore after backing up to that location.  
3-Files to be backed up  
	By defeault, the scripts only backup some folder in the root directory.  
	however you can choose which directories you want to back up  
	by changing the DIR_EX variables on top of the 2 scripts.  
	to do this enter: nano NameOfScript  
4-Log Files  
	Log files are created/updated every time a user did backup or restore.  
	these log files are located on the backup folders, 1 for each  
	location. this log file will show the specific time and date when the  
	user did a back up or restore. it also shows when  
	the backup or restore is unsuccessfull or successfull so always check  
	it after backing up or after restoring.
	


