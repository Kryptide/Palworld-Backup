# Palworld Automated Game Save Backup

This is a script created to backup your Palworld Game save Files. This is **ONLY** for the Steam version of Palworld. If you're running this game through Xbox PC or the Xbox Console this will not work for you.


## The Reasoning
There is currently a critical bug in Palworld that can cause your game saves to disappear randomly for both single and multiplayer worlds. This script was created to keep an ongoing backup of your game saves so in the event you are affected by this bug you can restore your save files.

## Setup

Simply download the .zip file from the releases page and extract it. You can also copy the code from the batch file into a new notepad text document. Make sure that when you select "Save As" to add .bat at the end of the file name. Then change "Save as Type:" to "All Files (*.*)" and hit save. Open the file you just saved and allow windows to run the script by selecting "Run Anyways". The file has been commented to show what each command does. If you have any concerns on the security or integrity of the script please feel free to go through and review every command before running.

```bash
___________________________________________________________________________
 _______  _______  ___      _     _  _______  ______    ___      ______  
|       ||   _   ||   |    | | _ | ||       ||    _ |  |   |    |      | 
|    _  ||  |_|  ||   |    | || || ||   _   ||   | ||  |   |    |  _    |
|   |_| ||       ||   |    |       ||  | |  ||   |_||_ |   |    | | |   |
|    ___||       ||   |___ |       ||  |_|  ||    __  ||   |___ | |_|   |
|   |    |   _   ||       ||   _   ||       ||   |  | ||       ||       |
|___|    |__| |__||_______||__| |__||_______||___|  |_||_______||______| 
         _______  _______  _______  ___   _  __   __  _______            
        |  _    ||   _   ||       ||   | | ||  | |  ||       |           
        | |_|   ||  |_|  ||       ||   |_| ||  | |  ||    _  |           
        |       ||       ||       ||      _||  |_|  ||   |_| |           
        |  _   | |       ||      _||     |_ |       ||    ___|           
        | |_|   ||   _   ||     |_ |    _  ||       ||   |               
        |_______||__| |__||_______||___| |_||_______||___|               
___________________________________________________Created By: Kryptide___
Choose an option:
------------------
1. Backup Palworld Save Files and Exit
2. Run Palworld and Backup on Game Exit
3. Exit
```

## Usage

```python
Option 1: Backs up your Palworld game save files by creating a folder on your Desktop named "PalworldBackup" 
and copying all your game save files into that folder. Files that have never been backed up, are newer, or have been changed will be saved to this folder.

Option 2: Will launch Palworld and the automation which checks for the game to be closed.
Once the script realizes the game is no longer running it will run the backup script and copy your game save files 
to the "PalworldBackup" folder on your Desktop then exit automatically.

Option 3: This simply exits the terminal window and ends the script.
```

## Contributing

This was made for myself and my girlfriend in the event we were affected by this bug but figured I would share in case it would be helpful for others.
This script works for us but any recommendations that can make this more efficient or effective I'm more than open to hearing.


## A Step Further

To keep myself from opening Palworld without the script I deleted the original Steam shortcut on my Desktop and replaced it with a Shortcut to the script. I saved the batch file to another folder, created a shortcut, placed it on my Desktop to replace the original and changed the Icon to the Palworld Icon. Now whenever I want to play I just run the game through the script so that I never worry about having an old or outdated backup.

## Screenshots

![Patch Notes](https://michaelreynolds.tech/wp-content/uploads/2024/02/patch_notes.png)
![Main Menu](https://michaelreynolds.tech/wp-content/uploads/2024/02/main_menu.png)
![Waiting for Launch](https://michaelreynolds.tech/wp-content/uploads/2024/02/waiting_for_launch.png)
![Waiting for Close](https://michaelreynolds.tech/wp-content/uploads/2024/02/waiting_for_close.png)

