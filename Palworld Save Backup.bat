@echo off
REM Sets the Window Title/Name
title Palworld Automated Game Save Backup
REM Allows for 10 Second Delay
setlocal enabledelayedexpansion
REM Sets Color of Terminal BG and Text
color 0E
REM ASCII Art
echo ___________________________________________________________________________
echo " _______  _______  ___      _     _  _______  ______    ___      ______  "
echo "|       ||   _   ||   |    | | _ | ||       ||    _ |  |   |    |      | "
echo "|    _  ||  |_|  ||   |    | || || ||   _   ||   | ||  |   |    |  _    |"
echo "|   |_| ||       ||   |    |       ||  | |  ||   |_||_ |   |    | | |   |"
echo "|    ___||       ||   |___ |       ||  |_|  ||    __  ||   |___ | |_|   |"
echo "|   |    |   _   ||       ||   _   ||       ||   |  | ||       ||       |"
echo "|___|    |__| |__||_______||__| |__||_______||___|  |_||_______||______| "
echo "         _______  _______  _______  ___   _  __   __  _______            "
echo "        |  _    ||   _   ||       ||   | | ||  | |  ||       |           "
echo "        | |_|   ||  |_|  ||       ||   |_| ||  | |  ||    _  |           "
echo "        |       ||       ||       ||      _||  |_|  ||   |_| |           "
echo "        |  _   | |       ||      _||     |_ |       ||    ___|           "
echo "        | |_|   ||   _   ||     |_ |    _  ||       ||   |               "
echo "        |_______||__| |__||_______||___| |_||_______||___|               "
echo ____________________________________________________Created By: Kryptide___
echo Choose an option:
echo ------------------
REM Menu Selection Text
echo 1. Backup Palworld Save Files and Exit
echo 2. Run Palworld and Backup on Game Exit
echo 3. Exit
REM Removes the need to hit Enter after making selection
choice /C 123 /N /M "Enter option (1/2/3): "

set option=%errorlevel%
REM (Option 1): Runs only the backup command then exits.
if %option% equ 1 (
    call :backup
)
REM (Option 2):Runs Palworld, Creates a countdown to allow the game to fully launch before executing the backup automation.
if %option% equ 2 (
REM If you have Steam installed normally this should open Palworld. If it doesn't right-click on the steam shortcut to Palworld, select
REM Properties and copy/paste what is in the URL field to the line below after the word start. 
    start steam://rungameid/1623730
    call :countdown 10
    call :CHECK_PROCESS
)
REM (Option 3): Simply closes the Terminal Window
if %option% equ 3 (
    exit
)
REM This is the backup command which only copies files that are new.
REM If the file that is being backed up is newer or has changed it will overwrite the old backup files.
REM None of the files in your actual save directory is ever modified, only Copied for backup.
:backup
REM This should automatically finds your game save folder. If your game saves are located outside the defauly directory change it below.
set source_folder=%USERPROFILE%\AppData\Local\Pal
REM This is where the backups get saved. I have it set as a folder on your Desktop. Feel free to save it anywhere you like.
set destination_folder=%USERPROFILE%\Desktop\PalworldBackup
REM This lists the files being backed up and the destination in which it's being saved to in the terminal.
echo Backing up %source_folder% to %destination_folder%...
REM This is the actual Backup command.
xcopy "%source_folder%" "%destination_folder%" /E /I /Y /D
REM This is shown once the backup transfer is complete.
echo Backup completed.
REM EOF simply ends the script when finished.
goto :EOF

REM This sets the process the script waits to end.
:CHECK_PROCESS
set "GAME_PROCESS=palworld.exe"
REM This calls the loding animation.
set "loading_dots=."

REM This is what continually checks to see if Palworld is still running so it knows when it's been closed.
:CHECK_PROCESS_LOOP
REM Searches for the games process.
tasklist | find /i "%GAME_PROCESS%" > nul
REM Text displayed once the game as been identified as no longer running.
if errorlevel 1 (
    echo Palworld Has Been Closed. Running Backup...
REM Text displayed showing the script is still waiting for the game to be closed before running the backup.	
) else (
    set "process_message=Palworld is Still Running. Waiting for Game to Close!loading_dots!"
    echo !process_message!
    set "loading_dots=!loading_dots!."
    if "!loading_dots!"=="....." set "loading_dots=."
REM The amount of time in seconds between checks to see if Palworld is still running. Change 1 to whatever you like if 1 second is too fast.	
    timeout /t 1 /nobreak > nul 2>&1
REM Clears the terminal before each check to keep from having a million lines in the terminal.
    cls
REM Command to go back to the beginning of the process check until Palworld has been closed.
    goto CHECK_PROCESS_LOOP
)
REM Ends script after Palworld has been closed and backed up.
endlocal
goto :EOF

REM The countdown you see before the process check automation begins.
:countdown
set "COUNT=%1"
for /l %%i in (%COUNT%,-1,1) do (
    cls
    echo Starting Backup Automation: %%i Sec.
    timeout /t 1 /nobreak > nul
)
cls
