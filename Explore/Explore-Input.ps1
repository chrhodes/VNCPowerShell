$folderName = "Page"
[int]$startNumber = 1
[int]$endNumber = 25
$delimiter ="-"
$ending = ""

$userInput = Read-Host "Enter Folder Name ($folderName)"

if ($userInput.Length -gt 0 ){ $folderName = $userInput}

$userInput = Read-Host "Starting Number ($startNumber)"

if ($userInput.Length -gt 0 ){ $startNumber = $userInput}

$userInput = Read-Host "Ending Number ($endNumber)"

if ($userInput.Length -gt 0 ){ $endNumber = $userInput}

$userInput = Read-Host "Delimiter ($delimiter)"

if ($userInput.Length -gt 0 ){ $delimiter = $userInput}

$userInput = Read-Host "Ending ($ending)"

if ($userInput.Length -gt 0 ){ $ending = $userInput}


Write-Host "Creating Folders ..."

for ($i = $startNumber ; $i -le $endNumber ; $i++)
{
    $folderName + $delimiter + ("{0:d2}" -f $i) + $ending
	
	#New-Item -Path . -Name $folderName -ItemType Directory
}

Read-Host "Press Enter to Exit"