@echo off
rem Backs up desktop icon locations to RB1.reg and RB2.reg in the same dir as this batch file
rem automatically replacing the older .reg file with the current locations if they have changed
rem Icon locations are only updated in the registry when explorer.exe closes gracefully
rem To close explorer manually you can ctrl+shift+right-click the taskbar and click exit explorer
rem Or restart it in the task manager

rem Works well running on startup, just create a shortcut to this file in the startup folder

rem To recover:
rem     Open the wanted .reg file, likely the older one if the computer has restarted since the unwanted location change
rem     Don't yet respond to the confirmation dialogue. Don't worry if you already did, just open the .reg file again
rem     Close explorer manually: ctrl+shift+right-click the taskbar and click exit explorer
rem     Now click yes on the .reg file confirmation
rem     ctrl+shift+esc to open the task manager then "File>Run new task"
rem     Type "explorer.exe" into the run window and click ok
rem The icon locations should now be recovered

rem Tested on Win 10

setlocal ENABLEDELAYEDEXPANSION

set _File1="%~dp0RB1.reg"
set _File2="%~dp0RB2.reg"
set _Curr="%~dp0curr.reg"

rem Get the current, as of last explorer restart, state of the icon locations
reg EXPORT HKCU\Software\Microsoft\Windows\Shell\Bags\1\Desktop !_Curr! /Y>Nul
rem Create file 1/file 2 if needed
if not exist !_File1! copy /V !_Curr! !_File1!
if not exist !_File2! copy /V !_Curr! !_File2!

rem Compares the age of the .reg files
for /F "Delims=" %%I In ('xcopy /DHYL !_File1! !_File2! ^|findstr /I "File"') Do set /a _Comp=%%I 2>Nul
if !_Comp! == 1 (
    set _Newer=!_File1!
    set _Older=!_File2!
) else (
    set _Newer=!_File2!
    set _Older=!_File1!
)

rem Check whether the icon locations have changed since last running
fc !_Curr! !_Newer!>Nul
if !errorlevel! == 0 (
    echo No change detected
) else if !errorlevel! == 1 (
    echo Change detected, overwriting !_Older!
    copy /Y /V !_Curr! !_Older!
) else (
    echo File error!
)

timeout 10
