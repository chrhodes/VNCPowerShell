<#

.SYNOPSIS 
Cleans Visual Studio Build Output

.DESCRIPTION
Cleans Visual Studio Build Output
        
.EXAMPLE
Clean-VisualStudioBuildOutput
.EXAMPLE
TODO: Example usage.  This section can be repeated

.NOTES
Nothing more to add

Clean-VisualStudioBuildOutput.ps1
    
Be sure to leave two blank lines after end of block comment.    
#>

##############################################    
# Script Level Parameters.
##############################################

param
(
# <TODO: Add script level paramters>
    # [switch] $SwitchArg1,
    # [switch] $SwitchArg2,
    # [string] $StringArg1         = "DefaultValueStringArg1", 
    # [string] $StringArg2,
	# [switch] $Contents,
    [switch] $Verbose
)

##############################################    
# Script Level Variables
##############################################

# $ScriptVar1 = "Foo"
# $ScriptVar2 = 42
# $ScriptVar3 = @(
    # ("Apple")
    # ,("Pear")
    # ,("Yogurt")
# )

$SCRIPTNAME = $myInvocation.InvocationName
$SCRIPTPATH = & { $myInvocation.ScriptName }

##############################################
# Main function
##############################################

function Main
{    
    if ($SCRIPT:Verbose)
    {
		"SCRIPTPATH         = $SCRIPTPATH"
        "SCRIPTNAME         = $SCRIPTNAME"
        # "SwitchArg1         = $SwitchArg1"
        # "SwitchArg2         = $SwitchArg2"
        # "StringArg1         = $StringArg1"
        # "StringArg2         = $StringArg2"
        # "ScriptVar1         = $ScriptVar1"
        # "ScriptVar2         = $ScriptVar2"
        # "ScriptVar3         = $ScriptVar3"
        ""
    }
    
    # if ( ! (VerifyPrerequisites))
    # {
        # LogMessage "Error Verifying Prerequistes" "Main" "Error"
        # exit
    # }
    # else
    # {
        # LogMessage "Prerequisites OK" "Main" "Info"
    # }

    # $message = "Begining " + $SCRIPTNAME + ": " + (Get-Date)
    # LogMessage $message "Main" "Info"
    
# <TODO: Add code, functional calls here to do something cool>

Get-ChildItem .\ -include bin,obj,Debug -Recurse | foreach { $_.fullname; remove-item $_.fullname -Force -Recurse }
Get-ChildItem .\ -include Backup,_UpgradeReport_Files,ipch -Recurse | foreach { $_.fullname; remove-item $_.fullname -Force -Recurse }
Get-ChildItem .\ -include .vs -Attributes Hidden -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse }
Get-ChildItem .\ -include *.csproj.user -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse }

    # $message = "Ending   " + $SCRIPTNAME + ": " + (Get-Date)
    # LogMessage $message "Main" "Info"
}

# Call the main function.  Use Dot Sourcing to ensure executed in Script scope.

. Main

#
# End New-ScriptTemplate1.ps1
#
