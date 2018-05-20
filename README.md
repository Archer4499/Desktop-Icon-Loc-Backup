# Desktop Icon Location Backup
Backs up desktop icon locations to RB1.reg and RB2.reg in the same dir as this batch file automatically replacing the older .reg file with the current locations if they have changed.

Icon locations are only updated in the registry when explorer.exe closes gracefully.  
To close explorer manually you can ctrl+shift+right-click the taskbar and click exit explorer or restart it in the task manager.

Works well running on startup, just create a shortcut to this file in the startup folder.

To recover:
- Open the wanted .reg file, likely the older one if the computer has restarted since the unwanted location change
- Don't yet respond to the confirmation dialogue. Don't worry if you already did, just open the .reg file again
- Close explorer manually: ctrl+shift+right-click the taskbar and click exit explorer
- Now click yes on the .reg file confirmation
- ctrl+shift+esc to open the task manager then "File>Run new task"
- Type "explorer.exe" into the run window and click ok

Tested on Windows 10.
