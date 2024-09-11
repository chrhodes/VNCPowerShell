<# 

.SYNOPSIS 
Update VNCNuget Package

.DESCRIPTION
Update VNCNuget Package.
Remove any existing matching package in <user>\.nuget\packages
Remove any existing package in VNCNuget
Copy target package to VNCNuget
		
.PARAMETER firstNamedArgument
The description of a parameter. You can include a Parameter keyword for
each parameter in the function or script syntax.

The Parameter keywords can appear in any order in the comment block, but
the function or script syntax determines the order in which the parameters
(and their descriptions) appear in Help topic. To change the order,
change the syntax.
 
You can also specify a parameter description by placing a comment in the
function or script syntax immediately before the parameter variable name.
If you use both a syntax comment and a Parameter keyword, the description
associated with the Parameter keyword is used, and the syntax comment is
ignored.

.PARAMETER secondNamedArgument
blah blah about secondNamedArgument

.EXAMPLE
A sample command that uses the function or script, optionally followed
by sample output and a description. Repeat this keyword for each example.
.EXAMPLE
Example2

.INPUTS
Inputs to this cmdlet (if any)

.OUTPUTS
Output from this cmdlet (if any)

.NOTES
Additional information about the function or script.

.LINK
The name of a related topic. Repeat this keyword for each related topic.

This content appears in the Related Links section of the Help topic.

The Link keyword content can also include a Uniform Resource Identifier
(URI) to an online version of the same Help topic. The online version 
opens when you use the Online parameter of Get-Help. The URI must begin
with "http" or "https".

.COMPONENT
The technology or feature that the function or script uses, or to which
it is related. This content appears when the Get-Help command includes
the Component parameter of Get-Help.

.ROLE
The user role for the Help topic. This content appears when the Get-Help
command includes the Role parameter of Get-Help.

.FUNCTIONALITY
The intended use of the function. This content appears when the Get-Help
command includes the Functionality parameter of Get-Help.


<ScriptName - Consider Verb-Noun>.ps1


Be sure to leave two blank lines after end of block comment.
#>

##############################################    
# Script Level Parameters.
##############################################

param
(
# <TODO: Add script level parameters>
    # [switch] $SwitchArg1,
    # [switch] $SwitchArg2,
    [string] $nugetPackage = "VNC.WPF.Presentation.Dx",
    [string] $packageVersion = "3.0.0",    
    # [string] $StringArg2 = "DefaultValueStringArg12,
	[switch] $Contents,
    [switch] $Verbose
)

##############################################    
# Script Level Variables
##############################################

$nugetPackagesFolder = "C:\users\crhodes\.nuget\packages"
$vncNugetPackagesFolder = "B:\VNCNuget"
# $ScriptVar2 = 42
# $ScriptVar3 = @(
#     ("Apple")
#     ,("Pear")
#     ,("Yoghurt")
# )

$UseVNCLog = $false

$SCRIPTNAME = $myInvocation.InvocationName
$SCRIPTPATH = & { $myInvocation.ScriptName }

##############################################
# Main function
##############################################

function Main
{    
    #$Verbose = $false

    if ($SCRIPT:Verbose)
    {
        "SCRIPTNAME         = $SCRIPTNAME"
		"SCRIPTPATH         = $SCRIPTPATH"
        # "SwitchArg1         = $SwitchArg1"
        # "SwitchArg2         = $SwitchArg2"
        "nugetPackage         = $nugetPackage"
        "packageVersion         = $packageVersion"
        # "StringArg2         = $StringArg2"
        "nugetPackagesFolder         = $nugetPackagesFolder"
        "vncNugetPackagesFolder         = $vncNugetPackagesFolder"
        # "ScriptVar3         = $ScriptVar3"
        ""
		"`$Verbose          = $Verbose"
    }
    
    $message = "Beginning " + $SCRIPTNAME + ": " + (Get-Date)
    LogMessage $message "Main" "Info"
    
    $sourceNugetPackage = "$($nugetPackage).$($packageVersion).nupkg"

    if ( ! (VerifySourcePackageExists $sourceNugetPackage))
    {
        LogMessage "Error VerifySourcePackageExists()" "Main" "Error"
        exit
    }
    else
    {
        RemoveExistingPackage $nugetPackage $packageVersion

        RemoveExistingVNCPackage $sourceNugetPackage

        Copy-Item -Path $sourceNugetPackage -Destination "$($vncNugetPackagesFolder)\$($sourceNugetPackage)"
    }
    
    $message = "Ending   " + $SCRIPTNAME + ": " + (Get-Date)
    LogMessage $message "Main" "Info"
}

function VerifySourcePackageExists([string] $nugetPackage)
{
    $message = "  VerifySourcePackageExists()"
    LogMessage $message "VerifySourcePackageExists" "Trace"

    # Verify something
    
    if ( ! (Test-Path $nugetPackage))
    {
        $message = "Source Nuget Package: " + $nugetPackage + " does not exist"
        LogMessage $message "VerifySourcePackageExists" "Error"

        return $false
    }
    # else
    # {
    #     foreach ($file in $EDMFileNames)
    #     {
    #         $inputFile = ($InputFolder + "\" + $file + ".csv")
            
    #         if ( ! (Test-Path $inputFile))
    #         {
    #             $message = "    Missing Input file: " + $inputFile
    #             LogMessage $message "VerifyInputFiles" "Error"

    #             return $false
    #         }
    #     }
    # }
    
    LogMessage "Source Nuget Package: " + $nugetPackage + " exists"

    return $true
}

function RemoveExistingPackage([string]$packageName, [string]$packageVersion)
{
    $message = "  PackageExists()"
    LogMessage $message "PackageExists" "Trace"

    # Verify something

    $packageFolder = "$($nugetPackagesFolder)\$($packageName)"
    $existingPackageFolder = (Get-Item $packageFolder)


    if ($null -eq $existingPackageFolder)
    {
        $message = "No Existing Packages"
        LogMessage $message
    }
    else
    {
        $existingPackageVersion = (Get-Item $packageFolder\$packageVersion)

        if ($null -eq $existingPackageVersion)
        {
            $message = "$($packageFolder) Version:$($packageVersion) does not exist"
            LogMessage $message
        }
        else
        {
            LogMessage "Removing existing Nuget Package Version"
            LogMessage "$($existingPackageVersion.Name) $($existingPackageVersion.LastWriteTime)"
    
            Remove-Item $($existingPackageVersion.FullName) -Recurse
        }
    }
}
function RemoveExistingVNCPackage([string]$vncPackage)
{
    $existingVNCPackage = (Get-Item "$($vncNugetPackagesFolder)\$($vncPackage)")

    if ($null -eq $existingVNCPackage)
    {
        $message = "No Existing VNC Packages"
        LogMessage $message
    }
    else
    {
        LogMessage "Removing existing VNC Nuget Package Version"
        LogMessage "$($existingVNCPackage.Name) $($existingVNCPackage.LastWriteTime)"

        Remove-Item $existingVNCPackage.FullName
    }
}
    
function VerifyFunc2()
{
    $message = "  VerifyFunc2()"
    LogMessage $message "VerifyFunc2" "Trace"

    return $true
}

function VerifyPrerequisites()
{
    $message = "VerifyPrerequisites()"
    LogMessage $message "VerifyPrerequisites" "Trace"

    if ( ! (VerifyFunc1))
    {
        return $false
    }
    
    if ( ! (VerifyFunc2))
    {
        return $false
    }
            
    return $true
}

if ($SCRIPT:Contents)
{
	$myInvocation.MyCommand.ScriptBlock
	exit
}

##############################
# Internal Support Functions
##############################

function LogMessage()
{
    param
    (
        [string] $message,
        [string] $method,
        [string] $logLevel
    )
    
	# <TODO: Each case can be modified to do the appropriate type of console/PLLog logging.
 
    switch ($logLevel)
    {
        "Trace"
        { 
            if ($SCRIPT:Verbose) { Write-Host $message }
            if ($SCRIPT:UseVNCLog) { Call-PLLog -Trace   -message $message -class "Process-DLPFiles" -method $method }
            break
        }    
        
        "Info"
        { 
            # if ($SCRIPT:Verbose) { Write-Host $message }   
			Write-Host $message
            if ($SCRIPT:UseVNCLog) { Call-PLLog -Info    -message $message -class "Process-DLPFiles" -method $method }
            break
        }
        
        "Warning"
        { 
            Write-Host -ForegroundColor Yellow $message
            if ($SCRIPT:UseVNCLog) { Call-PLLog -Warning -message $message -class "Process-DLPFiles" -method $method }
            break
        }
        "Error"
        { 
            Write-Host -ForegroundColor Red $message
            if ($SCRIPT:UseVNCLog) { Call-PLLog -Error   -message $message -class "Process-DLPFiles" -method $method }
            break
        }
        
        "None"
        { 
            if ($SCRIPT:Verbose) { Write-Host $message }        
            break
        }
        
        default
        {
            Write-Host $message        
            if ($SCRIPT:UseVNCLog) {  Call-PLLog -Error "Unexpected log level" + $logLevel -class "Process-DLPFiles" -method "LogMessage" }
            break
        }
    }
}

# Call the main function.  Use Dot Sourcing to ensure executed in Script scope.

. Main