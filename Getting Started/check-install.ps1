# Check that the profile exists everywhere we want

Write-Host -ForegroundColor Red "Latest profile.ps1"
get-item profile.ps1

Write-Host

Write-Host -ForegroundColor Red "Current files"

Write-Host 

get-item "C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"
get-item "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\profile.ps1"
get-item "C:\Program Files\PowerShell\7\profile.ps1"

get-item "C:\Users\crhodes\Documents\PowerShell\profile.ps1"

# Write-Host
# Write-Host -ForegroundColor Green "Check-Install.ps1 to see what has been installed and where"
# Write-Host

Read-Host -Prompt "Press Enter to Exit"