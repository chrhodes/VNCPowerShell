################################################################################
#
# GetAssemblyInfo.ps1
#

# Script to automate the collection of Assembly Version information.
#
# TODO:
#
#
################################################################################

# This needs to be first.
# Get command line arguments

param
(
	$files = (get-childitem *.dll)
)
	
"Assembly                       AssemblyVersion      FileVersion          ProductVersion"
foreach ($file in $files)
{
	$asmb = [System.Reflection.Assembly]::Loadfile($file)
	$Aname = $asmb.GetName()
	$Aver = $Aname.version
	$VersionInfo = (get-childitem $file).VersionInfo
	$AFileVersion = $VersionInfo.FileVersion
	$AProductVersion = $VersionInfo.ProductVersion
	"{0,30}  {1,-20} {2,-20} {3,-20}" -f $Aname.name, $Aver, $AFileVersion, $AProductVersion
	
}

################################################################################
#
# GetAssemblyInfo.ps1
#
################################################################################