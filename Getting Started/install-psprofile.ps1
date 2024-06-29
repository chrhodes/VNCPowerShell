# TODO
# Have this do all the magic described in ReadMe.txt

get-item "profile.ps1"
Write-Host -ForegroundColor Red "Installing current version of profile.ps1 to all locations"
Write-Host

get-item "C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"
Write-Host -ForegroundColor Red "Installing 64bit PowerShell profile - AllUsersAllHosts"
Write-Host "Copy-Item profile.ps1 C:\Windows\System32\WindowsPowerShell\v1.0"

Copy-Item profile.ps1 "C:\Windows\System32\WindowsPowerShell\v1.0"

get-item "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\profile.ps1"
Write-Host -ForegroundColor Red "Installing 32bit PowerShell profile - AllUsersAllHosts"
Write-Host "Copy-Item profile.ps1 C:\Windows\SysWOW64\WindowsPowerShell\v1.0"

Copy-Item profile.ps1 "C:\Windows\SysWOW64\WindowsPowerShell\v1.0"

get-item "C:\Program Files\PowerShell\7\profile.ps1"
Write-Host -ForegroundColor Red "64bit V7 PowerShell profile - AllUsersAllHosts"
Write-Host "Copy-Item profile.ps1 C:\Program Files\PowerShell\7"

Copy-Item profile.ps1 "C:\Program Files\PowerShell\7"

get-item "C:\Users\crhodes\Documents\PowerShellprofile.ps1"
Write-Host -ForegroundColor Red "Current User All Hosts"
Write-Host "Copy-Item profile.ps1 C:\Users\crhodes\Documents\PowerShell"

Copy-Item profile.ps1 "C:\Users\crhodes\Documents\PowerShell"

Write-Host

Read-Host -Prompt "Press Enter to Exit"

