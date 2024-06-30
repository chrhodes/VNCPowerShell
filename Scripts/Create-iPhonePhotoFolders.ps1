
<# 

.SYNOPSIS 
Creates folders for iPhone photos

.DESCRIPTION
Creates YYYY\ folder 
and month folders YYYY-01\ ... YYYY-12\
and DNG\, MOV\, PNG\ subfolders in each month folder
		
.PARAMETER year
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
Create-iPhonePhotoFolders YYYY

.INPUTS
Inputs to this cmdlet (if any)

.OUTPUTS
Output from this cmdlet (if any)


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


Create-iPhonePhotoFolders.ps1

Be sure to leave two blank lines after end of block comment.
#>

##############################################    
# Script Level Parameters.
##############################################

param
(
    [Parameter(Mandatory=$true)][string] $year
)


function CreateMonthFolders([string]$year)
{
    for ($i = 1; $i -le 12 ; $i++)
    {
        $folder = "$($year)-" + ('{0:d2}' -f $i)

        New-Item -Path $year -Name $folder -ItemType Directory

        CreateSubFolders("$year\$folder")
    }
}

$SubFolders = @("DNG", "MOV", "PNG")

function CreateSubFolders ([string]$monthFolder)
{
    foreach ($folder in $SubFolders)
    {
        New-Item -Path $monthFolder -Name $folder -ItemType Directory
    }    
}

if (! (Test-Path -Path .\$year))
{
    New-Item -Path . -Name $year -ItemType Directory

    CreateMonthFolders $year
}
else
{
    "$year already exists, aborting"
}

