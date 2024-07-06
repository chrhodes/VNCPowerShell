function WriteDelimitedMessage($msg)
{
    # $delimitS = "**********> "
    # $delimitE = " <**********"
    $delimitS = ""
    $delimitE = ""

    Write-Host -ForegroundColor Red $delimitS ("{0,-30}" -f $msg) $delimitE
}

$message = "ScriptBlock message"

function foo ()
{
    Write-Host "In foo before >$message<"
    # This creates $message scoped inside foo
    # and does not affect $message in Script
    $message = "foo message"
    Write-Host "In foo after >$message<"
}

function bar ()
{
    Write-Host "In bar before >$message<"
    # This updates $message in Script
    $script:message = "bar message"
    Write-Host "In bar after >$message<"
}

# WriteDelimitedMessage "Get-Variable -Scope global"
# Get-Variable -Scope global
# WriteDelimitedMessage "Get-Variable -Scope local"
# Get-Variable -Scope local

WriteDelimitedMessage "Before Calling foo() >$message<"
foo
WriteDelimitedMessage "After Calling foo() >$message<"

WriteDelimitedMessage "Before Calling bar() >$message<"
bar
WriteDelimitedMessage "After Calling bar() >$message<"