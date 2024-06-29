﻿get-content source.txt | % {$_.Split('|') | select -last 1 }

# Start in folder containing files to process

cd C:\temp\xxxWI\2017.09.06
cd C:\temp\xxxWI\2017.09.06
cd C:\temp\xxxWI\xxxWI_13Sep2017
cd C:\temp\xxxWI\xxxWI1_13Sep2017

cd Z:\241427


# Select individual log file to process

$logfile = "xxxWI.log"
$logfile = "xxxWI0001.log"
$logfile = "xxxWI.2017-09-09.log"

$logfile = "xxxWI.2017-09-150001.log"

$logfile = "AMLViewEASE10001.log"

$logfile

# Search for a pattern

select-string -path $logfile -Pattern '7.7.14.9'

select-string -path $logfile -Pattern 1002 | % { $_.Split('|') }

# Split the line at the '|' character

get-content $Logfile | % { $_.Split('|') }

# Get the last three fields
# Which should be Method,Time,Message

get-content $Logfile | % { $_.Split('|') | select -last 3 }

get-content $Logfile | % { $_.Split("|") | select -last 1 } | select-string -Pattern "strSQL" | select-string -Pattern "select"

get-content $logfile | % { $_.Split("|").GetType() } | select -last 2 } | select-string -Pattern "^strSQL" | select-string -Pattern "select" | Out-File -Width 1000 SQLStatements.txt

# Get log entries where loglevel = 1002

# Error
$loglevel = "-1"
# Info
$loglevel = "100"
# SQL
$loglevel = "1002"
$sqlLogLevel = "1002"

Get-Content $logfile | % { if ($_.Split("|")[2] -eq $loglevel) { $_; }} | % { $_.Split("|")  | select -last 3 }

select-string -path $logfile -Pattern "CheckEngineAbstractTable"

# Get SQL Calls (1002) that take longer than duration Seconds

$duration = 0.5

Get-Content $logfile | % { if ($_.Split("|")[2] -eq $sqlLogLevel) { $_; }} | % { if ($_.Split("|")[11] -gt $duration) { $_; }} | % { $_.Split("|")  | select -last 3 }

Get-Content $logfile | % { if ($_.Split("|")[2] -eq $sqlLogLevel) { $_; }} | % { if ($_.Split("|")[11] -gt $duration) { $_; }} | % { $_.Split("|")  | select -first 1 -last 3 }

Get-Content $logfile | % { if ($_.Split("|")[2] -eq $sqlLogLevel) { $_; }} | % { if ($_.Split("|")[11] -gt $duration) { $_; }} | % { $_.Split("|")  | select -index 0, 6, 8, 9, 10, 11, 12 }

get-content 

Get-ChildItem -Path C:\Source-Ease-Main -Recurse -Include "frmMessageBox.vb" | select-string -Pattern "Const LOG_APPNAME"
Get-ChildItem -Path C:\Source-Ease-Main -Recurse -Include "*.vb" | select-string -Pattern "Const LOG_APPNAME"

Get-Content $logfile | % { if ($_.Split("|")[11] -gt 5.0) { $_; }} 

Get-Content $logfile | % { if ($_.Split("|")[2] -eq "1002" -or $_.Split("|")[11] -gt 0.1) { $_; } } 

Get-Content $logfile | % { if ($_.Split("|")[2] -eq "1002" -or $_.Split("|")[11] -gt 0.1) { $_; } } 

# Look for Errors

Get-Content $logfile | % { if ($_.Split("|")[2] -eq "-1") { $_; } } 

# Look for Debug2 lines

Get-Content $logfile | % { if ($_.Split("|")[2] -eq "1002") { $_; } }

# Look for ApplicationStart lines

Get-Content $logfile | % { if ($_.Split("|")[10] -eq "modxxx1.ApplicationStart") { $_; } }


# Look for SessionStart lines

Get-Content $logfile | % { if ($_.Split("|")[10] -eq "modxxx1.SessionStart") { $_; } }

# Get a list of logfiles to process

$logfiles = Get-ChildItem xxxWI0[0-9][0-9][0-9].log

$logfiles = Get-ChildItem xxxWI*.log


$logfiles = Get-ChildItem *xxxWI*.log

$logfiles = Get-ChildItem xxxWI.2017-09-[0-9][0-9].log

$logfiles = Get-ChildItem xxxWI.log

$logfiles = Get-ChildItem *xxxWI.log

$logfiles = Get-ChildItem xxxWI.2017-09-150001.log
$logfiles = Get-ChildItem xxxWI1.2017-09-15.log

$logfiles = Get-ChildItem AMLViewEASE*.log

# Get SQL Calls taking longer than duration

$duration = 0.5
$sqlLogLevel = "1002"
$outputFile = "LongDurationSQLCalls.txt"

foreach ($file in $logFiles)
{
    "Processing $file"
    $file >> $outputFile

    Get-Content $logfile | 
        % { if ($_.Split("|")[2] -eq $sqlLogLevel) { $_; }} | 
        % { if ($_.Split("|")[11] -gt $duration) { $_; }} | 
        % { $_.Split("|") | 
        select -index 0, 6, 8, 9, 10, 11, 12 }  >> $outputFile
}

# Get Errors

$logLevel = "-1"
$outputFile = "Errors.txt"

foreach ($file in $logFiles)
{
    "Processing $file"
    $file >> $outputFile

    Get-Content $file |
        % { if ($_.Split("|")[2] -eq $logLevel ) { $_; } } >> $outputFile
}

foreach ($file in $logFiles)
{
    "Processing $file"

    "  Gathering Debug2"
    Get-Content $file | % { if ($_.Split("|")[2] -eq "1002") { $_; } } > "$file - Debug2.log"

    "  Gathering Error"
    Get-Content $file | % { if ($_.Split("|")[2] -eq "-1") { $_; } } > "$file - Error.log"
}

foreach ($file in $logFiles)
{
    "Processing $file"

    "  Gathering SessionStart"
    Get-Content $file | % { if ($_.Split("|")[10] -eq "modxxx1.SessionStart") { $_; } } > "$file - SesionStart.log"
    # Get-Content $file | % { if ($_.Split("|")[10] -eq "modxxx1.SessionStart") { $_; } } | Out-File "$file - SesionStart.log" -Encoding utf7

    "  Gathering ApplicationStart"
    Get-Content $file | % { if ($_.Split("|")[10] -eq "modxxx1.ApplicationStart") { $_; } } > "$file - ApplicationStart.log"

    "  Gathering RestartAPP"
    Get-Content $file | % { if ($_.Split("|")[10] -eq "modxxx1.RestartAPP") { $_; } } > "$file - RestartAPP.log"
}

foreach ($file in $logFiles)
{
    "Processing $file"

    "  Gathering modxxxMRC.GetFirstStationInLine"
    Get-Content $file | % { if ($_.Split("|")[10] -eq "modxxxMRC.GetFirstStationInLine") { $_; } } > "$file - GetFirstStationInLine.log"
}

foreach ($file in $logFiles)
{
    Get-Content $file | % { if ($_.Split("|")[10] -eq "modxxx1.ApplicationStart") { $_; } } > "$file - ApplicationStart.log"
}


foreach ($file in $logFiles)
{
    Get-Content $file | % { if ($_.Split("|")[10] -eq "modxxx1.RestartAPP") { $_; } } > "$file - RestartAPP.log"
}

foreach ($file in $logFiles)
{
    Get-Content $file | % { if ($_.Split("|")[10] -eq "frmEngineUpdate.Page_Load") { $_; } } > "$file - frmEngineUpdate.log"
}

foreach ($file in $logFiles)
{
    "Processing $file"

    "  Gathering SlowCalls"
    Get-Content $logfile | % { if ($_.Split("|")[11] -gt 5.0) { $_; } } > "$file - SlowCalls.log"
}


$debuglogfiles = Get-ChildItem xxxWI0[0-9][0-9][0-9]*debug*.log
foreach ($file in $debuglogFiles)
{
    Get-Content $file >> "xxx-Debug2.log"
}

$errorlogfiles = Get-ChildItem xxxWI0[0-9][0-9][0-9]*error*.log
foreach ($file in $errorlogFiles)
{
    Get-Content $file >> "xxx-Error.log"
}

cd "D:\xxx Logs\xxxWI.2017-09-15\"
$logfiles = Get-ChildItem xxxWI.2017-09-15.log

cd "C:\temp\xxxWI\xxxWI.2017-09-15\"

cd "C:\temp\xxxWI\xxxWI_2017Sep26\"
cd "C:\temp\xxxWI\xxxWI1_2017Sep26\"
$logfiles = Get-ChildItem xxxWI*.log


foreach ($file in $logFiles)
{
    Get-Content $file | % { if ($_.Split("|")[10] -ne "stdMod3.CheckForErrors") { $_; } } > "$file - NoCheckForErrors.log"
}

foreach ($file in $logFiles)
{
    "Processing $file"

    "  Gathering frmEngineUpdate.CheckEngineStationRecordExist"
    Get-Content $file | % { if ($_.Split("|")[10] -eq "frmEngineUpdate.CheckEngineStationRecordExist") { $_; } } > "$file - frmEngineUpdate.CheckEngineStationRecordExist.log"
}

CD 'C:\Customers\xxx\Log Files'
cd xxxWI_16Nov2017
$logfile = "xxxWI.log"
$logfile = "xxxWI.log"

$pattern = "modxxx3.DisableMenuButton"
$pattern = "modCDC.WriteToLogFile"
$pattern = "modxxx1.GetStationRangeFromMemory"
$pattern = "mod_GenlFunctions.GettheValueFromCookie"
#$pattern = "modxxx3.DisableMenuButton"
#$pattern = "modxxx3.DisableMenuButton"
#$pattern = "modxxx3.DisableMenuButton"
#$pattern = "modxxx3.DisableMenuButton"

$logfile = "xxxWI.log"
$pattern = "modxxx1.GetStationRangeFromMemory"

Get-Content $logfile | % { if ($_.Split("|")[10] -ne $pattern) { $_; } } > "$logfile - A1"

$logfile = "xxxWI.log - A1"
$pattern = "mod_GenlFunctions.GettheValueFromCookie"
Get-Content $logfile | % { if ($_.Split("|")[10] -ne $pattern) { $_; } } > "$logfile - A2"