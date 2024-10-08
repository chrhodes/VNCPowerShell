﻿Function global:TEST-LocalAdmin() 
{ 
	Return ([security.principal.windowsprincipal] [security.principal.windowsidentity]::GetCurrent()).isinrole([Security.Principal.WindowsBuiltInRole] "Administrator") 
}
				
Function global:SET-PATH()
{
[Cmdletbinding(SupportsShouldProcess=$TRUE)]
param
(
[parameter(Mandatory=$True, 
ValueFromPipeline=$True,
Position=0)]
[String[]]$NewPath
)

If ( ! (TEST-LocalAdmin) ) { Write-Host 'Need to RUN AS ADMINISTRATOR first'; Return 1 }
	
# Update the Environment Path

if ( $PSCmdlet.ShouldProcess($newPath) )
{
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH –Value $newPath

# Show what we just did

Return $NewPath
}
}

Function global:ADD-PATH()
{
[Cmdletbinding(SupportsShouldProcess=$TRUE)]
param
	(
	[parameter(Mandatory=$True, 
	ValueFromPipeline=$True,
	Position=0)]
	[String[]]$AddedFolder
	)

If ( ! (TEST-LocalAdmin) ) { Write-Host 'Need to RUN AS ADMINISTRATOR first'; Return 1 }
	
# Get the Current Search Path from the Environment keys in the Registry

$OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path

# See if a new Folder has been supplied

IF (!$AddedFolder)
	{ Return ‘No Folder Supplied.  $ENV:PATH Unchanged’}

# See if the new Folder exists on the File system

IF (!(TEST-PATH $AddedFolder))
	{ Return ‘Folder Does not Exist, Cannot be added to $ENV:PATH’ }

# See if the new Folder is already IN the Path

IF ($ENV:PATH | Select-String -SimpleMatch $AddedFolder)
	{ Return ‘Folder already within $ENV:PATH' }

If (!($AddedFolder[-1] -match '\')) { $Newpath=$Newpath+'\'}

# Set the New Path

$NewPath=$OldPath+';’+$AddedFolder
if ( $PSCmdlet.ShouldProcess($AddedFolder) )
{
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH –Value $newPath

# Show our results back to the world

Return $NewPath 
}
}

FUNCTION GLOBAL:GET-PATH()
{
Return (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
}

Function global:REMOVE-PATH()
{
[Cmdletbinding(SupportsShouldProcess=$TRUE)]
param
(
[parameter(Mandatory=$True, 
ValueFromPipeline=$True,
Position=0)]
[String[]]$RemovedFolder
)

If ( ! (TEST-LocalAdmin) ) { Write-Host 'Need to RUN AS ADMINISTRATOR first'; Return 1 }
	
# Get the Current Search Path from the Environment keys in the Registry

$NewPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path

# Make sure the folder follows a proper syntax in the Path

If (!($RemovedFolder[-1] -match ';')) { $RemovedFolder=$RemovedFolder+';'}
If (!($RemovedFolder[-2] -match '\')) { $RemovedFolder=$RemovedFolder -replace ";","\;" }

# Find the value to remove, replace it with $NULL.  If it’s not found, nothing will change

$NewPath=$NewPath –replace $RemovedFolder,$NULL

# Update the Environment Path
if ( $PSCmdlet.ShouldProcess($RemovedFolder) )
{
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH –Value $newPath

# Show what we just did

Return $NewPath
}
}
