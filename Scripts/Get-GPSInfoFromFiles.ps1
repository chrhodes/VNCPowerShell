Clear-Host

$FolderPath = "V:\Photos & Video & Audio\Phone\CHR Phone\2023\2023-09"

Get-ChildItem $FolderPath -Filter "2023-09-25*".heic | where { ! $_.PSIsContainer } | 
Foreach-Object {
    # Get the file name and path, write it out to screen
    $FileName = $_.FullName
    # Write-Host "$FileName"

    # Create an ImageFile object and load an image file
    $image = New-Object -ComObject Wia.ImageFile
    $image.LoadFile($FileName)

    # Read your desirered metadata, if it doesn't contain any, say NONE
    try
    {
        #Clear variables for Lat and Lon
        Clear-Variable Lat*
        Clear-Variable Lon*
        $LatDEG = $image.Properties.Item('GpsLatitude').Value[1].Value
        $LatMIN = $image.Properties.Item('GpsLatitude').Value[2].Value
        $LatSEC = $image.Properties.Item('GpsLatitude').Value[3].Value 
        $LatREF = $image.Properties.Item('GpsLatitudeRef').Value
        $LonDEG = $image.Properties.Item('GpsLongitude').Value[1].Value
        $LonMIN = $image.Properties.Item('GpsLongitude').Value[2].Value
        $LonSEC = $image.Properties.Item('GpsLongitude').Value[3].Value 
        $LonREF = $image.Properties.Item('GpsLongitudeRef').Value

        # Convert them to Degrees Minutes Seconds Ref
        $LatSTR = "$LatDEG$([char]176) $LatMIN$([char]39) $LatSEC$([char]34) $LatREF"
        $LonSTR = "$LonDEG$([char]176) $LonMIN$([char]39) $LonSEC$([char]34) $LonREF"

        # Write the full coordinates out
        Write-Host "$_    > $LatSTR $LonSTR"
    }
    catch
    {
        Write-Host "NONE"
    }
}