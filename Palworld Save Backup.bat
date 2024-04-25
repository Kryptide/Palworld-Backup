@echo off
REM Sets the Window Title/Name/Version
title Palworld Automated Game Save Backup v3.3
REM Allows for 10 Second Delay
setlocal enabledelayedexpansion
REM Sets Color of Terminal BG and Text
color 0E
REM ASCII Art
:start
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
echo _________________________________________________________________Kryptide__

REM This reaches out to Github to pull the latest version. Responsible for the flash you see when opening the script.
REM Code used to grab the latest version from Github.
for /f "delims=" %%v in ('powershell -command "(Invoke-WebRequest -Uri 'https://api.github.com/repos/Kryptide/Palworld-Backup/releases/latest').Content | ConvertFrom-Json | Select -ExpandProperty tag_name"') do set "latest_version=%%v"
REM The current version the user is running.
echo Current version: v3.3
REM The output of the latest version available on Github
echo Latest version available: %latest_version%
echo.

echo Choose an Option:
echo ------------------
REM Menu Selection Text
echo 1. Backup Palworld Save Files and Exit
echo 2. Run Palworld and Backup on Game Exit
echo 3. Restore Backup
echo 4. Set or Update Backup Save Location
echo 5. Check for Updates
echo 6. Exit
REM Removes the need to hit Enter after making selection
choice /C 123456 /N /M "Enter option (1/2/3/4/5/6): "

set option=%errorlevel%
REM (Option 1): Runs only the backup command then exits.
if %option% equ 1 (
    call :backup
    goto :EOF
)
REM (Option 2): Runs Palworld, Creates a countdown to allow the game to fully launch before executing the backup automation.
if %option% equ 2 (
    REM If you have Steam installed normally this should open Palworld. If it doesn't right-click on the steam shortcut to Palworld, select
    REM Properties and copy/paste what is in the URL field to the line below after the word start.
    start steam://rungameid/1623730
    REM Wait until palworld.exe is running
    :WAIT_FOR_PALWORLD
    REM Waiting Text
    echo Waiting for Palworld to open
    REM Loading dots animation
    set "loading_dots=."
    REM The loop checking to see if palworld.exe is running so the script doesn't start prematurely.
    :WAIT_FOR_PALWORLD_LOOP
    timeout /t 0 /nobreak >nul
    REM Finding and checking the palworld.exe process
    tasklist /FI "IMAGENAME eq palworld.exe" 2>NUL | find /I /N "palworld.exe">NUL
    REM A simple 10 second countdown after it finds palworld.exe running
    if "%ERRORLEVEL%"=="0" (
        echo.
        call :countdown 10
        call :CHECK_PROCESS
    ) else (
        set "loading_dots=!loading_dots!."
        if "!loading_dots!"=="...." set "loading_dots=."
        cls
        set "loading_message=Waiting for Palworld to open!loading_dots!"
        echo !loading_message!
        goto :WAIT_FOR_PALWORLD_LOOP
    )
)

REM (Option 3): Restore Backup
if %option% equ 3 (
    call :restore_backup
    goto :EOF
)

REM (Option 4): Change Backup Location
if %option% equ 4 (
    REM Runs the backup_path.vbs script to allow the user to select a new/change backup location.
    echo Select a Backup Location...
    for /f "delims=" %%a in ('cscript //nologo backup_path.vbs "Select a new folder for backup"') do set "destination_folder=%%a"
    REM Trim leading and trailing spaces to properly define the file path
    set "destination_folder=!destination_folder!"
    if not defined destination_folder goto :EOF
    REM Saves the selected folder path to the backup_path text file, overwriting the existing one if it exists
    if exist backup_path.txt (
        >backup_path.txt echo !destination_folder!
        echo Backup path updated!
    ) else (
        >backup_path.txt echo !destination_folder!
        echo Backup path created!
    )
    REM Display message for 3 seconds
    timeout /t 3 >nul
    REM Clear the terminal window
    cls
    REM Restarts the script back to the main menu after setting or changing the backup folder path
    goto :start
)

REM (Option 5): Check for Updates
if %option% equ 5 (
    REM Get the latest release version number from GitHub repo.
    for /f "delims=" %%v in ('powershell -command "(Invoke-WebRequest -Uri 'https://api.github.com/repos/Kryptide/Palworld-Backup/releases/latest').Content | ConvertFrom-Json | Select -ExpandProperty tag_name"') do set "latest_version=%%v"
    echo Current version: v3.3
    REM While making this, sometimes the latest available version field would be blank. This mitigates that by reloading the version number a second time if it doesn't appear on first launch.
    if "%latest_version%"=="" (
        for /f "delims=" %%v in ('powershell -command "(Invoke-WebRequest -Uri 'https://api.github.com/repos/Kryptide/Palworld-Backup/releases/latest').Content | ConvertFrom-Json | Select -ExpandProperty tag_name"') do set "latest_version=%%v"
    )
    echo Latest version available: %latest_version%
    REM Check if an update is available
    if "%latest_version%" gtr "v3.3" (
        echo A newer version is available.
        REM Prompts the user for their choice in downloading the update or not.
        choice /M "Do you want to update to the latest version? (Yes/No)"
        if errorlevel 2 (
		REM The message the user gets if they decline the update.
            echo You chose not to update. Returning to the main menu...
            timeout /t 3 >nul
            cls
            goto :start
        ) else (
		REM the message the user gets if they agree to update.
            echo Updating to the latest version...
            REM This downloads the latest release from the Github repo and overwrites the old version. The script will automatically reload showing the new current version.
            powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Kryptide/Palworld-Backup/main/Palworld Save Backup.bat', 'Palworld Save Backup.bat')"
            if exist "Palworld Save Backup.bat" (
                echo Update completed. Reloading...
                timeout /t 5 >nul
                cls
                goto :start
            ) else (
			REM the message the user gets if there is some sort of issue with donwloading the newest release.
                echo Failed to update. Please try again later.
            )
        )
    ) else (
	REM The message the user gets if they're already on the latest version.
        echo You're up to date.
    )
    timeout /t 5 >nul
    cls
    goto :start
)


REM (Option 6): Exit
if %option% equ 6 (
    echo Exiting...
    timeout /t 5 >nul
    exit
)

REM Backup function
:backup
REM This should automatically find your game save folder. If your game saves are located outside the default directory change it below.
set source_folder=%USERPROFILE%\AppData\Local\Pal\Saved
REM Get current date and time to create a unique name for the .zip backup file
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set "datestamp=%%a-%%b-%%c")
for /f "tokens=1-3 delims=/: " %%a in ("%TIME%") do (
    set "hour=%%a"
    set "minute=%%b"
    for /f "tokens=1-2 delims=." %%x in ("%%c") do set "second=%%x"
)
REM This converts the 24-hour format to 12-hour format and determines either AM/PM
set "ampm=AM"
if %hour% gtr 12 (
    set /a "hour=hour-12"
    set "ampm=PM"
)
REM Pad single digits with a leading zero which keeps the filename timestamp correctly formatted when there is a 1 digit hour or minute.
if %hour% lss 10 set "hour=0%hour%"
if %minute% lss 10 set "minute=0%minute%"
if %second% lss 10 set "second=0%second%"
REM This is the Format of the timestamp
set "timestamp=%hour%-%minute%-%second%-%ampm%"
REM This checks if the backup_path.txt already existed or not.
if exist backup_path.txt (
    set /p "destination_folder=" < backup_path.txt
) else (
    REM Calls the backup_path VBScript to allow the selection of the backup folder location
    echo Backup folder is not set. Please select the backup folder.
    for /f "delims=" %%a in ('cscript //nologo backup_path.vbs "Select a folder for backup"') do set "destination_folder=%%a"
    REM Trim leading and trailing spaces to properly define the file path
    set "destination_folder=!destination_folder!"
    if not defined destination_folder goto :EOF
    REM Save the selected folder to a text file for future use
    echo !destination_folder!>backup_path.txt
)
REM Enclose the destination path in quotes to handle spaces in folder names
set "zip_file=!destination_folder!\PalworldBackup_%datestamp%_%timestamp%.zip"
REM This lists the files being backed up and the destination in which it's being saved to in the terminal.
echo Creating zip file: !zip_file!...
REM This is the actual Backup command that compresses and archives the backup files.
powershell -Command "Compress-Archive -LiteralPath \"%source_folder%\" -DestinationPath \"%zip_file%\" -Force"
REM This dialog is shown once the backup transfer is complete.
echo Backup completed.
REM Pause for 5 seconds before closing the window
timeout /t 5 >nul
REM EOF simply ends the script when finished.
goto :EOF



REM Restore Backup function
:restore_backup
REM Check if the backup folder is already set
if not exist backup_path.txt (
    REM If backup folder is not set, prompt the user to set one.
    echo Backup folder is not set. Please select the backup folder.
    for /f "delims=" %%a in ('cscript //nologo backup_path.vbs "Select the backup folder"') do set "backup_folder=%%a"
    REM Save the selected backup folder to backup_path.txt
    echo !backup_folder!>backup_path.txt
) else (
    REM If backup folder is set, read it from backup_path.txt
    set /p "backup_folder=" < backup_path.txt
)

REM Display all available backup .zip files you can restore to.
echo List of available backup files:
setlocal enabledelayedexpansion
set "count=1"
for %%F in ("%backup_folder%\*.zip") do (
    echo !count!. %%~nxF
    set "backup[!count!]=%%~fF"
    set /a count+=1
)
echo.

REM Allows user to select a backup file
set /P "backup_choice=Enter the number of the backup file you want to restore: "
REM Confirm selection
set "selected_backup=!backup[%backup_choice%]!"
echo Selected backup: !selected_backup!
choice /M "Confirm restore of selected backup?"
if errorlevel 2 goto :EOF
REM Additional confirmation step
:confirm_restore
echo.
echo WARNING: THIS WILL RESTORE ALL PLAYER CHARACTERS AND MAPS TO THE DATE/TIME OF THE BACKUP SELECTED!
set /P "confirm_text=Please type 'restore' (without quotes) to confirm the restore: "
if /I not "!confirm_text!"=="restore" (
    REM if restore is typed incorrectly it will give you another attempt at typing it again.
    echo Check your spelling and Try Again.
    goto confirm_restore
)
REM Extract selected backup to destination folder
echo Restoring selected backup...
REM Encloses both the source and destination paths in quotes to handle spaces in folder names
powershell -Command "Expand-Archive -LiteralPath \"!selected_backup!\" -DestinationPath \"%USERPROFILE%\AppData\Local\Pal\" -Force"
REM Successful backup dialog
echo Backup restored successfully.
REM 5 second pause before closing after restore.
timeout /t 5 /nobreak >nul
goto :EOF


REM This sets palworld.exe as the process for the script to check if the process is still active.
:CHECK_PROCESS
set "GAME_PROCESS=palworld.exe"
REM This calls the loading animation.
set "loading_dots=."

REM This is what continually checks to see if Palworld is still running so it knows when it's been closed.
:CHECK_PROCESS_LOOP
REM Searches for the games process.
tasklist | find /i "%GAME_PROCESS%" > nul
REM Text displayed once the game as been identified as no longer running.
if errorlevel 1 (
    echo Palworld Has Been Closed. Running Backup...
    REM Ends script after Palworld has been closed and backed up.
    endlocal
    goto :EOF
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
REM EOF simply ends the script when finished.
:end
REM The countdown you see before the process check automation begins.
:countdown
set "COUNT=%1"
for /l %%i in (%COUNT%,-1,1) do (
    cls
    echo Starting Backup Automation: %%i Sec.
    timeout /t 1 /nobreak > nul
)
cls
