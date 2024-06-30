<# 

.SYNOPSIS 
Call VNC.Logging Log routines.

.DESCRIPTION
Used to call VNC.Logging.Log from PowerShell scripts.
		
.EXAMVNCE
Call-VNCLog -Info -Message "Message to Log goes here"
.EXAMVNCE
Call-VNCLog -Trace -Message "Doing Step One" -class "MyClass" -method "MyMethod"


.NOTES
<ScriptName - Consider Verb-Noun>.ps1


Be sure to leave two blank lines after end of block comment.
#>

param
(
	[switch] $Error,
	[switch] $Warning,
	[switch] $Info,
	[switch] $Debug,
	[switch] $Trace,
	[switch] $Trace1,
	[switch] $TestAll,
	[string] $message,
	[string] $class="",
	[string] $method=""
)

function Main
{
	if ($Error)
	{
		VNCLogError
	}
	
	if ($Warning)
	{
		VNCLogWarning
	}
	
	if ($Info)
	{
		VNCLogInfo
	}
	
	if ($Debug)
	{
		VNCLogDebug
	}
	
	if ($Trace)
	{
		VNCLogTrace
	}
	
	if ($Trace1)
	{
		VNCLogTrace1
	}
	
	if ($TestAll)
	{
		TestAll
	}
		
}

function VNCLogError()
{
	[xxx.VNCLog]::WriteLight($message, 2, "PowerShell", -1, $class, $method, $false, 0)
}
function VNCLogWarning()
{
	[xxx.VNCLog]::WriteLight($message, 4, "PowerShell", 1, $class, $method, $false, 0)
}
function VNCLogInfo()
{
	[xxx.VNCLog]::WriteLight($message, 8, "PowerShell", 100, $class, $method, $false, 0)
}
function VNCLogDebug()
{
	[xxx.VNCLog]::WriteLight($message, 16, "PowerShell", 1000, $class, $method, $false, 0)
}
function VNCLogTrace()
{
	[xxx.VNCLog]::WriteLight($message, 16, "PowerShell", 10000, $class, $method, $false, 0)
}
function VNCLogTrace1()
{
	[xxx.VNCLog]::WriteLight($message, 16, "PowerShell", 10001, $class, $method, $false, 0)
}

function TestAll()
{
	Call-VNCLog -Error -message "Error Message"
	Call-VNCLog -Warning -message "Warning Message"
	Call-VNCLog -Info    -message "Info Message"
	Call-VNCLog -Debug   -message "Debug Message"
	Call-VNCLog -Trace   -message "Trace Message" -class "MyClass" -method "MyMethod"
	Call-VNCLog -Trace1  -message "Trace1 Message"
	
}

# Call the main function.  Use Dot Sourcing to ensure executed in Script scope.

. Main
#
# End Demo-CalingVNCLog.ps1
#