@echo off
setlocal enabledelayedexpansion

REM Get the current username dynamically
set "USER_NAME=%USERNAME%"

REM Define the destination Rainmeter Skins directory for the current user
set "skins_dir=C:\Users\%USER_NAME%\Documents\Rainmeter\Skins\TextAnimationBy_www.mehadi.me"

REM Check if Rainmeter is installed by looking for the executable
if exist "%ProgramFiles%\Rainmeter\Rainmeter.exe" (
    echo Rainmeter is installed.
) else if exist "%ProgramFiles(x86)%\Rainmeter\Rainmeter.exe" (
    echo Rainmeter is installed.
) else (
    echo Rainmeter is not installed. Please install Rainmeter first.
    exit /b
)

REM Create the new folder if it doesn't exist
if not exist "%skins_dir%" (
    mkdir "%skins_dir%"
    echo Created folder: %skins_dir%
)

REM Copy files and folders, excluding .idea, .git, and install_skin.cmd
echo Copying files...

REM Copying files from the current directory to the target directory
for /d %%D in (.) do (
    for /d %%X in (*) do (
        set "folder=%%X"
        if /i not "!folder!"==".idea" (
            if /i not "!folder!"==".git" (
                xcopy /E /I /H /Y "%%X" "%skins_dir%\%%X"
            )
        )
    )
)

REM Copy files excluding specific files
for %%F in (*) do (
    set "file=%%~nxF"
    if /i not "!file!"=="install_skin.cmd" (
        xcopy /I /H /Y "%%F" "%skins_dir%"
    )
)

echo Files copied successfully to %skins_dir%.
pause