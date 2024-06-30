<# 

.SYNOPSIS 
A brief description of the function or script. 
This keyword can be used only once in each topic.

.DESCRIPTION
A detailed description of the function or script.
This keyword can be used only once in each topic
		
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
	[switch] $DebugConfig,
	[switch] $ReleaseConfig,

    [switch] $Verbose
)

##############################################    
# Script Level Variables
##############################################

$ScriptVar1 = "Foo"
$ScriptVar2 = 42
$ScriptVar3 = @(
    ("Apple")
    ,("Pear")
    ,("Yoghurt")
)

$clientApplications = @(
	#
	# Client Applications
	#
    "AutoUpdate"
	"ClientEditor"
	"DataLoader"
	"EASEBatch"
	"ElementGenerator"
	"eStart"
	"MassUpdate"
	"MDMEditor"
	"ProcessPlan"
	"TimeDatabase"
	"ToolManagement"
	"Update7"
)

$UseVNCLog = $false

$SCRIPTNAME = $myInvocation.InvocationName
$SCRIPTPATH = & { $myInvocation.ScriptName }

##############################################
# Main function
##############################################

function Main
{ 
    if ($SCRIPT:Verbose)
    {
        "`$SCRIPTNAME        = $SCRIPTNAME"
		"`$SCRIPTPATH        = $SCRIPTPATH"
		"`$DebugConfig       = $DebugConfig"
		"`$ReleaseConfig     = $ReleaseConfig"
        ""
		"`$Verbose           = $Verbose"
    }
    
    if ( ! (VerifyPrerequisites))
    {
        LogMessage "Error Verifying Prerequisites" "Main" "Error"
        exit
    }
    else
    {
        LogMessage "Prerequisites OK" "Main" "Trace"
    }

    $message = "Beginning " + $SCRIPTNAME + ": " + (Get-Date)
    LogMessage $message "Main" "Trace"

 # <TODO: Add code, functional calls here to do something cool>   

	if ($DebugConfig) { SwitchConfiguration "-Dev" }

	if ($ReleaseConfig) { SwitchConfiguration "-Rel" }
   
    $message = "Ending   " + $SCRIPTNAME + ": " + (Get-Date)
    LogMessage $message "Main" "Trace"
}

##############################
# Internal Functions
##############################

function SwitchConfiguration($from, $to)
{
	if($from -eq "-Dev")
	{
		LogMessage "  --> Moving web.config to Web-Rel.config" "SwitchConfiguration" "Info"
		Move-Item "web.config" "Web-Rel.config" -Force
		
		LogMessage "  --> Moving Web-Dev.config to web.config" "SwitchConfiguration" "Info"	
		Move-Item "Web-Dev.config" "web.config" -Force
	}
	elseif($from -eq "-Rel")
	{
		LogMessage "  --> Moving web.config to Web-Dev.config" "SwitchConfiguration" "Info"
		Move-Item "web.config" "Web-Dev.config" -Force
		
		LogMessage "  --> Moving Web-Rel.config to web.config" "SwitchConfiguration" "Info"	
		Move-Item "Web-Rel.config" "web.config" -Force
	}
	else
	{
		LogMessage "Unexpected $from"
	}
}

function VerifyFilesExist($appConfig, $sourceConfig)
{
	$result = $true

	Foreach ($file in @($appConfig, $sourceConfig))
	{
		LogMessage "Test-Path $file" "VerifyFilesExist" "Trace"

		if ( ! (Test-Path -Path "$file" -PathType Leaf))
		{
			LogMessage "$file does not exist.  Aborting"
			$result = $false
		}
	}

	return $result
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
    
	$className = "Switch-ClientConfigFiles"

	# <TODO: Each case can be modified to do the appropriate type of console/VNCLog logging.
	
    
    switch ($logLevel)
    {
        "Trace"
        { 
            if ($SCRIPT:Verbose) { Write-Host $message }
            if ($SCRIPT:UseVNCLog) { Call-VNCLog -Trace   -message $message -class $className -method $method }
            break
        }    
        
        "Info"
        { 
            # if ($SCRIPT:Verbose) { Write-Host $message }   
			Write-Host $message
            if ($SCRIPT:UseVNCLog) { Call-VNCLog -Info    -message $message -class  $className -method $method }
            break
        }
        
        "Warning"
        { 
            Write-Host $message
            if ($SCRIPT:UseVNCLog) { Call-VNCLog -Warning -message $message -class  $className -method $method }
            break
        }
        "Error"
        { 
            Write-Host $message
            if ($SCRIPT:UseVNCLog) { Call-VNCLog -Error   -message $message -class  $className -method $method }
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
            if ($SCRIPT:UseVNCLog) {  Call-VNCLog -Error "Unexpected log level" + $logLevel -class  $className -method "LogMessage" }
            break
        }
    }
}

function VerifyFunc1()
{

    $message = "  VerifyFunc1()"
    LogMessage $message "VerifyFunc1" "Trace"

	if ($DebugConfig -and $ReleaseConfig)
	{
		LogMessage "Cannot pick DebugConfig and ReleaseConfig together" "VerifyFunc1" "Error"
		return $false
	}

	if (! $DebugConfig -and ! $ReleaseConfig)
	{
		LogMessage "Must pick DebugConfig or ReleaseConfig" "VerifyFunc1" "Error"
		return $false
	}
    
    return $true
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
	
# Call the main function.  Use Dot Sourcing to ensure executed in Script scope.

. Main

#
# End Switch-ClientConfigurationFiles.ps1
#