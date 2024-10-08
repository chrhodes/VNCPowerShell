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


New-ContentEditorFiles.ps1

Be sure to leave two blank lines after end of block comment.
#>

##############################################    
# Script Level Parameters.
##############################################

param
(
# <TODO: Add script level parameters>
    [string] $Level       = "L0",
    [string] $Name        = "XX-YY",
    [string] $OutputPath  = "C:\temp",
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

$UsePLLog = $false

$SCRIPTNAME = $myInvocation.InvocationName
$SCRIPTPATH = & { $myInvocation.ScriptName }

##############################################
# Main function
##############################################

function Main
{

    if ($SCRIPT:Verbose)
    {
        "SCRIPTNAME         = $SCRIPTNAME"
		"SCRIPTPATH         = $SCRIPTPATH"
        "Level              = $Level"
        "Name               = $Name"
        ""
		"`$Verbose = $Verbose"
    }
    
    if ( ! (VerifyPrerequisites))
    {
        LogMessage "Error Verifying Prerequisites" "Main" "Error"
        exit
    }
    else
    {
        LogMessage "Prerequisites OK" "Main"
    }

    $message = "Beginning " + $SCRIPTNAME + ": " + (Get-Date)
    LogMessage $message "Main" "Info"
    
# <TODO: Add code, functional calls here to do something cool>

    CreateNavigationLinkFile

    CreateInputFile
    
    CreateOutputFile
    
    CreateWorkDeliveryFile
    
    CreateWorkManagementFile

    CreateReferenceArtifactsFile

    CreateMetricsFile

    $message = "Ending   " + $SCRIPTNAME + ": " + (Get-Date)
    LogMessage $message "Main" "Info"
}

##############################
# Internal Functions
##############################

function CreateNavigationLinkFile()
{
    $outputfilename = $Name + "-NavLinks.txt"

    $message = "Creating $OutputPath\$OutputFileName"
    LogMessage $message "CreateInputFile" "Info"
    
    $body = @"
<p class="faNavLinks">$Name NavLinks</h1>
<div>
<a href="../Pages/L0%20Icon.aspx">
<img src="../SiteAssets/Framework%20Link%20Levels/L0-Icon.png" alt="L0 Link" />
</a>
<a href="../Pages/L1.aspx">
<img src="../SiteAssets/Framework%20Link%20Levels/L1-Icon.png" alt="L1 Link" />
</a>
</div>
"@

    $body | Out-file $OutputPath\$outputfilename
}

function CreateInputFile()
{
    $outputfilename = $Name + "-Inputs.txt"

    $message = "Creating $OutputPath\$OutputFileName"
    LogMessage $message "CreateInputFile" "Info"
    
    $body = @"
<div>
<a href="../Pages/Sample-Artifact-Page.aspx">
<img src="../SiteAssets/Artifacts/Artifact-Base.png" alt="Sample Artifact" /></a>
<p>Text goes here</p>

</div>
"@

    $body | Out-file $OutputPath\$outputfilename
}

function CreateOutputFile()
{
    $Outputfilename = $Name + "-Outputs.txt"

    $message = "Creating $OutputPath\$OutputFileName"
    LogMessage $message "CreateOutputFile" "Info"

    $body = @"
<div>
<a href="../Pages/Sample-Artifact-Page.aspx">
<img src="../SiteAssets/Artifacts/Artifact-Base.png" alt="Sample Artifact" /></a>

<p>Text goes here</p>

</div>
"@

    $body | Out-file $OutputPath\$Outputfilename
}

function CreateWorkDeliveryFile()
{
    $Outputfilename = $Name + "-Work-Delivery.txt"

    $message = "Creating $OutputPath\$OutputFileName"
    LogMessage $message "CreateWorkDeliveryFile" "Info"

    $body = @"
<div>
<a href="../Pages/Sample-Team-Page.aspx">
<img src="../SiteAssets/People/Team-Base%2096x96.png" alt="Sample Team" /></a>

<p>L3- Activities</p>
<ul>
	<li>Do this</li>
	<li>And this</li>
	<li>And this</li>
</ul>

<p>L3- Activities</p>
<ul>
	<li>Do this</li>
	<li>And this</li>
	<li>And this</li>
</ul>

<p>General Notes</p>
</div>
"@

    $body | Out-file $OutputPath\$Outputfilename
}

function CreateWorkManagementFile()
{
    $Outputfilename = $Name + "-Work-Management.txt"

    $message = "Creating $OutputPath\$OutputFileName"
    LogMessage $message "CreateWorkManagementFile" "Info"

    $body = @"
<div>
<a href="../Pages/Sample-Team-Page.aspx">
<img src="../SiteAssets/People/Team-Base%2096x96.png" alt="Sample Team" /></a>

<p>L3- Management Activities</p>
<ul>
	<li>Do this</li>
	<li>And this</li>
	<li>And this</li>
</ul>

<p>General Notes</p>
</div>
"@

    $body | Out-file $OutputPath\$Outputfilename
}

function CreateReferenceArtifactsFile()
{
    $Outputfilename = $Name + "-Reference.txt"

    $message = "Creating $OutputPath\$OutputFileName"
    LogMessage $message "CreateReferenceFile" "Info"

    $body = @"
<div>
<a href="../Pages/Sample-Artifact-Page.aspx">
<img src="../SiteAssets/Artifacts/Artifact-Base.png" alt="Sample Artifact" /></a>

<p>General Notes</p>
</div>
"@

    $body | Out-file $OutputPath\$Outputfilename
}

function CreateMetricsFile()
{
    $Outputfilename = $Name + "-Metrics.txt"

    $message = "Creating $OutputPath\$OutputFileName"
    LogMessage $message "CreateMetricsFile" "Info"

    $body = @"
<div>
<a href="../Pages/Sample-Metric-Page.aspx">
<img src="../SiteAssets/Metrics/Balanced-Scorecard.png" alt="Balanced Scorecard" /></a>

<p>General Notes</p>
</div>
"@

    $body | Out-file $OutputPath\$Outputfilename
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
            if ($SCRIPT:UsePLLog) { Call-PLLog -Trace   -message $message -class "Process-DLPFiles" -method $method }
            break
        }    
        
        "Info"
        { 
            # if ($SCRIPT:Verbose) { Write-Host $message }   
			Write-Host $message
            if ($SCRIPT:UsePLLog) { Call-PLLog -Info    -message $message -class "Process-DLPFiles" -method $method }
            break
        }
        
        "Warning"
        { 
            Write-Host $message
            if ($SCRIPT:UsePLLog) { Call-PLLog -Warning -message $message -class "Process-DLPFiles" -method $method }
            break
        }
        "Error"
        { 
            Write-Host $message
            if ($SCRIPT:UsePLLog) { Call-PLLog -Error   -message $message -class "Process-DLPFiles" -method $method }
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
            if ($SCRIPT:UsePLLog) {  Call-PLLog -Error "Unexpected log level" + $logLevel -class "Process-DLPFiles" -method "LogMessage" }
            break
        }
    }
}

function VerifyFunc1()
{

    $message = "  VerifyFunc1()"
    LogMessage $message "VerifyFunc1" "Trace"

    # Verify something
    
    # if ( ! (Test-Path $InputFolder))
    # {
        # $message = "InputFolder: " + $InputFolder + " does not exist"
        # LogMessage $message "VerifyInputFiles" "Error"

        # return $false
    # }
    # else
    # {
        # foreach ($file in $EDMFileNames)
        # {
            # $inputFile = ($InputFolder + "\" + $file + ".csv")
            
            # if ( ! (Test-Path $inputFile))
            # {
                # $message = "    Missing Input file: " + $inputFile
                # LogMessage $message "VerifyInputFiles" "Error"

                # return $false
            # }
        # }
    # }
    
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
# End New-ScriptTemplate1.ps1
#