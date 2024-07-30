# Palworld Automated Game Save/Restore Backup Script

This is a script created to backup and restore your Palworld Game save Files. This is **ONLY** for the Steam version of Palworld. If you're running this game through Xbox PC or the Xbox Console this will not work for you. This script was created and tested in Windows 11. If you are running another version of Windows your mileage may vary.


## The Reasoning
There is currently a critical bug in Palworld that can cause your game saves to disappear randomly for both single and multiplayer worlds. This script was created to keep an ongoing backup of your game saves so in the event you are affected by this bug you can restore your save files.
![bug_notice](https://michaelreynolds.tech/wp-content/uploads/2024/07/bug2.jpg)

## Setup

Simply download the .zip file from the releases page and extract it. You can also copy the code from the batch file and vbs file into a new notepad text document. Make sure that when you select "Save As" to add .bat at the end of the file name as well as .vbs. Then change "Save as Type:" to "All Files (*.*)" and hit save. Palworld_Save_Backup.bat and backup_path.vbs MUST be in the same folder to work correctly. Open the Palworld Save Backup.bat you just saved and allow windows to run the script by selecting "More Info" then "Run Anyways". This prompt is simply stating that this script was not created on your PC and has been downloaded. It is not stating that the file is malicious as it's not. I have put a considerable amount of time into commenting each command to show what each one does. If you have any concerns on the security or integrity of the script please feel free to go through and review every command before running.

```bash
___________________________________________________________________________
" _______  _______  ___      _     _  _______  ______    ___      ______  "
"|       ||   _   ||   |    | | _ | ||       ||    _ |  |   |    |      | "
"|    _  ||  |_|  ||   |    | || || ||   _   ||   | ||  |   |    |  _    |"
"|   |_| ||       ||   |    |       ||  | |  ||   |_||_ |   |    | | |   |"
"|    ___||       ||   |___ |       ||  |_|  ||    __  ||   |___ | |_|   |"
"|   |    |   _   ||       ||   _   ||       ||   |  | ||       ||       |"
"|___|    |__| |__||_______||__| |__||_______||___|  |_||_______||______| "
"         _______  _______  _______  ___   _  __   __  _______            "
"        |  _    ||   _   ||       ||   | | ||  | |  ||       |           "
"        | |_|   ||  |_|  ||       ||   |_| ||  | |  ||    _  |           "
"        |       ||       ||       ||      _||  |_|  ||   |_| |           "
"        |  _   | |       ||      _||     |_ |       ||    ___|           "
"        | |_|   ||   _   ||     |_ |    _  ||       ||   |               "
"        |_______||__| |__||_______||___| |_||_______||___|               "
_________________________________________________________________Kryptide__
Current version: v3.3
Latest version available: v3.3

Choose an Option:
------------------
1. Backup Palworld Save Files and Exit
2. Run Palworld and Backup on Game Exit
3. Restore Backup
4. Set or Update Backup Save Location
5. Check for Updates
6. Exit
Enter option (1/2/3/4/5/6):


```

## Usage

```python
Option 1: Backs up your Palworld game save files for all characters and all worlds in a compressed .zip file. These files are named according to the date and time in which the backup took place in a 12-hour format.
The backup file will look something like this: PalworldBackup_02-11-2024_02-10-18-AM.zip. MONTH-DAY-YEAR_HOUR-MINUTE-SECOND-AM/PM.
If this is the first time you are running the script it will trigger the backup_path.vbs script to run. This will allow you to select the location you wish to save your backups to.
When you select your backup location there will be a new file called backup_path.txt created. This tells the script which location to save all backups to for future subsequent script runs essentially setting the path you chose as the default backup save location
and copying all your game save backups into that folder unless changed using option 4. 

Option 2: Will launch Palworld and the automation which checks for the game to be closed.
Once the script realizes the game is no longer running it will run the backup script and copy your game save files 
to the "PalworldBackup" folder on your Desktop then exit automatically. As with option 1, if you have never set your default backup folder then once the game closes the script will let you know that no backup path has been set and will ask you to select one.
After you select your default backup path it will continue to backup your saves.

Option 3: This option restores your game saves from a previous backup. If you have never selected a backup path it will ask you to select your backup path before proceeding though you probably wont see this as restoring a backup without ever creating one wouldn't make much sense though I did add this just in case
someone selected this option before ever backing up to keep from errors. In normal usuage you will have several backups to choose from. This option will list all the backups in your default backup folder. Each backup zip will have a corresponding number. Simple select the number that corresponds to the backup you
wish to restore. To help prevent accidental restores I've added 2 counter measures. First after selecting the backup you wish to restore it will ask are you sure you wish to restore that backup. Type Y for Yes and N for No. If you select Y it will then warn you that ALL characters and ALL worlds will be restored
and ask you to type out the word restore to continue. Simply type the word restore and your save files will be restored to the day and time listed in the backups file name.

Option 4: This will update your backups save location. If for whatever reason you need to change the default location the script uses for backing up your saves you can use this option to easily change it. If for whatever reason you have never selected a default backup folder it will prompt you that you need to create one. 
Like with option 3 most people won't change this without first running and backup and having a default save location already but just in case I created it to keep from errors occurring.

Option 5: This compares the version number of the script the user is running to the latest version released on this repo. If the users script version is lower than the repos it will alert the user and download the latest version straight from the repo. If the users script version is the same or higher than the one in the repo it will alert the user that they are currently up to date.

Option 6: This simply exits the terminal window and ends the script.
```

## Contributing

This was made for myself and my girlfriend in the event we were affected by this bug but figured I would share in case it would be helpful for others.
This script works for us but any recommendations that can make this more efficient or effective I'm more than open to hearing.
**Thank you to catboy_feet on Reddit for the ideas and motivation to release v3**


## A Step Further

To keep myself from opening Palworld without the script I deleted the original Steam shortcut on my Desktop and replaced it with a Shortcut to the script and changed the icon to the included Palworld icon.ico file. If you would like to do this as well then save the Palworld Save Backup.bat + backup_path.vbs + icon.ico to a folder on your desktop or somewhere in a folder on your PC. Right click on the Palworld Save Backup.bat file and select create shortcut. Drag the shortcut you just made to the desktop. You may need to right click and select rename and remove the "-shortcut" at the end of the shortcut name. You may also rename it to just "Palworld" to make it cleaner. Right click on the shortcut once again and select properties. Select the "Change Icon.." button near the bottom. In the pop-up window select browse and select the folder you saved the .bat, .vbs, and .ico file to. You should see the Palworld icon in this directory. Select open, then okay and you should now have a Palworld desktop shortcut that will always run the script first. This simply helps you from having to remember to open the script instead of opening the game and having to manually run it to save your backups after you're done playing.

## Screenshots


![Main Menu](https://michaelreynolds.tech/wp-content/uploads/2024/04/main_menu_v3.3.png)
![Restore](https://michaelreynolds.tech/wp-content/uploads/2024/02/restore.png)
![Waiting for Launch](https://michaelreynolds.tech/wp-content/uploads/2024/07/launch1.png)
![Waiting for Close](https://michaelreynolds.tech/wp-content/uploads/2024/07/close1.png)
![Select Default Backup Folder](https://michaelreynolds.tech/wp-content/uploads/2024/07/selection1.png)
![Update](https://michaelreynolds.tech/wp-content/uploads/2024/04/update.png)

