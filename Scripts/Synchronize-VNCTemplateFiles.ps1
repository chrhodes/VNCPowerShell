
function WriteDelimitedMessage($msg)
{
    # $delimitS = "**********> "
    # $delimitE = " <**********"
    $delimitS = ""
    $delimitE = ""

    Write-Host -ForegroundColor Red $delimitS ("{0,-30}" -f $msg) $delimitE
}

$AB = "A"   # Set to A for ProjectTemplatesA and ItemTemplatesA, Set to B for ...

$templateFolder = "V:\Dropbox\Visual Studio\2022\Templates"

$sourceMaster = "ProjectTemplates$AB\VNC\VNC_PT_APPLICATION_PrismDxWPF_EF"

$projectTemplates = "ProjectTemplates$AB\VNC"
$itemTemplates = "ItemTemplates$AB\VNC"

$targetProjectTemplateFolders = @(
    "VNC_PT_APPLICATION_PrismDxWPF"
   , "VNC_PT_MODULE"    
)

$targetItemTemplateFolders = @(
    "VNC_IT_MVVM_All"
    , "VNC_IT_MVVM_V"
    , "VNC_IT_MVVM_V_VM"    
)

$manualProcesingRequired = @(
    #Files
    "App.Config.cs"     
    , "APPLICATION.csproj"
    , "Common.cs"
    # Presentation\Views
    , "Presentation\Views\MainDxDocLayoutManager.xaml"
    , "Presentation\Views\MainDxDocLayoutManager.xaml.cs"
    , "Presentation\Views\MainDxLayout.xaml"
    , "Presentation\Views\MainDxLayout.xaml.cs"
)

$masterFileUpdated = $false

$commonProjectFiles = @(
    # Files
    # "App.Config.cs" 
    , "App.Xaml" 
    , "App.Xaml.cs"
    # , "APPLICATION.csproj"
    # , "Common.cs"
    , "ReadMe.txt" 
    # Application
    , "Application\ReadMe.txt"
    # ApplicationServices
    , "ApplicationServices\ReadMe.txt"                 
    # DomainServices
    , "DomainServices\ReadMe.txt"    
    # Infrastructure
    , "Infrastructure\ReadMe.txt"    
    # Modules
    , "Modules\ReadMe.txt" 
    , "Modules\APPLICATIONModule.cs" 
    , "Modules\APPLICATIONServicesModule"         
    # Persistence\Database\Migrations
    , "Persistence\Database\Migrations\ReadMe.txt"
    , "Persistence\Database\Migrations\Configuration.cs"  
    # Persistence\Database
    , "Persistence\Database\ReadMe.txt" 
    , "Persistence\Database\APPLICATIONDbContext.cs" 
    , "Persistence\Database\APPLICATIONDbContextDatabaseInitializer.cs"           
    # Persistence
    , "Persistence\ReadMe.txt"  
    # Presentation\Converters
    , "Presentation\Converters\ReadMe.txt"      
    # Presentation\ModelWrappers
    , "Presentation\ModelWrappers\ReadMe.txt"  
    # Presentation\Views\Shells
    , "Presentation\Views\Shells\RibbonShell.xaml"
    , "Presentation\Views\Shells\RibbonShell.xaml.cs"
    , "Presentation\Views\Shells\Shell.xaml"
    , "Presentation\Views\Shells\Shell.xaml.cs"
    # Presentation\Views
    , "Presentation\Views\AppVersionInfo.xaml"
    , "Presentation\Views\AppVersionInfo.xaml.cs"
    , "Presentation\Views\CombinedMain.xaml"
    , "Presentation\Views\CombinedMain.xaml.cs"  
    , "Presentation\Views\CombinedNavigation.xaml"
    , "Presentation\Views\CombinedNavigation.xaml.cs"
    , "Presentation\Views\Main.xaml"
    , "Presentation\Views\Main.xaml.cs"    
    # , "Presentation\Views\MainDxDocLayoutManager.xaml"
    # , "Presentation\Views\MainDxDocLayoutManager.xaml.cs"
    # , "Presentation\Views\MainDxLayout.xaml"
    # , "Presentation\Views\MainDxLayout.xaml.cs"            
    , "Presentation\Views\Ribbon.xaml"
    , "Presentation\Views\Ribbon.xaml.cs"   
    , "Presentation\Views\StatusBar.xaml"
    , "Presentation\Views\StatusBar.xaml.cs"        
    , "Presentation\Views\ViewA.xaml"
    , "Presentation\Views\ViewA.xaml.cs"
    , "Presentation\Views\ViewB.xaml"
    , "Presentation\Views\ViewB.xaml.cs"
    , "Presentation\Views\ViewC.xaml"
    , "Presentation\Views\ViewC.xaml.cs"
    , "Presentation\Views\ViewD.xaml"
    , "Presentation\Views\ViewD.xaml.cs"
    , "Presentation\Views\ViewABCD.xaml"
    , "Presentation\Views\ViewABCD.xaml.cs"
    , "Presentation\Views\UILaunchApproaches.xaml"
    , "Presentation\Views\UILaunchApproaches.xaml.cs"    
    # Presentation\ViewModels\Shells
    , "Presentation\ViewModels\Shells\RibbonShellViewModel.cs"
    , "Presentation\ViewModels\Shells\ShellViewModel.cs"     
    # Presentation\ViewModels
    , "Presentation\ViewModels\CombinedMainViewModel.cs"
    , "Presentation\ViewModels\CombinedNavigationViewModel.cs"        
    , "Presentation\ViewModels\MainDxDocLayoutManagerViewModel.cs"
    , "Presentation\ViewModels\MainDxLayoutViewModel.cs"
    , "Presentation\ViewModels\MainViewModel.cs"
    , "Presentation\ViewModels\RibbonViewModel.cs"
    , "Presentation\ViewModels\StatusBarViewModel.cs"        
    , "Presentation\ViewModels\UILaunchApproachesViewModel.cs"            
    , "Presentation\ViewModels\ViewABCDViewModel.cs" 
    , "Presentation\ViewModels\ViewAViewModel.cs"
    , "Presentation\ViewModels\ViewBViewModel.cs" 
    , "Presentation\ViewModels\ViewCViewModel.cs" 
    , "Presentation\ViewModels\ViewDViewModel.cs"
    # Resources\Icons
    , "Resources\Icons\ReadMe.txt" 
    , "Resources\Icons\application.icon"
    , "Resources\Icons\Application-Left-Blue.icon"
    , "Resources\Icons\Application-Left-Blue.png"
    , "Resources\Icons\Application-Left-Blue.psd"
    , "Resources\Icons\Application-Right-Red.icon"
    , "Resources\Icons\Application-Right-Red.png"
    , "Resources\Icons\Application-Right-Red.psd"
    # Resources\Images
    , "Resources\Images\ReadMe.txt"
    , "Resources\Images\VNCDeveloperMotivation.png"     
    # Resources\Xmal
    , "Resources\Xaml\ReadMe.txt"
    , "Resources\Xaml\Application.xaml"
    , "Resources\Xaml\Display_StylesAndTemplates.xaml"   
    , "Resources\Xaml\Layout_Styles.xaml"                     
    # Resources
    , "Resources\ReadMe.txt"              
)

$commonItemFiles = @(
    # Domain\Lookups
    , "Domain\Lookups\LookupTYPE.cs"
    # Domain
    , "Domain\ITEM.cs"
    , "Domain\TYPE.cs"    
    , "Domain\TYPEEmailAddress.cs"    
    , "Domain\TYPEPhoneNumber.cs"
    # DomainServices\ServicesMock
    , "DomainServices\ServicesMock\TYPEDataServiceMock.cs"
    # DomainServices
    , "DomainServices\ITEMDataService.cs"   
    , "DomainServices\ITEMLookupDataService.cs"   
    , "DomainServices\TYPEDataService.cs"     
    , "DomainServices\TYPELookupDataService.cs"  
    # Modules
    , "Modules\TYPEModule.cs"
    # Presentation\Converters   
    # Presentation\ModelWrappers
    , "Presentation\ModelWrappers\ITEMWrapper.cs"
    , "Presentation\ModelWrappers\TYPEPhoneNumberWrapper.cs"  
    , "Presentation\ModelWrappers\TYPEWrapper.cs"                      
    # Presentation\Views
    , "Presentation\Views\TYPE.xaml"
    , "Presentation\Views\TYPE.xaml.cs"
    , "Presentation\Views\TYPEMain.xaml"
    , "Presentation\Views\TYPEMain.xaml.cs"
    , "Presentation\Views\TYPENavigation.xaml"
    , "Presentation\Views\TYPENavigation.xaml.cs"     
    , "Presentation\Views\TYPEDetail.xaml"
    , "Presentation\Views\TYPEDetail.xaml.cs"
    , "Presentation\Views\ITEMDetail.xaml"
    , "Presentation\Views\ITEMDetail.xaml.cs"
    # Presentation\ViewModels     
    , "Presentation\ViewModels\TYPEViewModel.cs"
    , "Presentation\ViewModels\TYPEMainViewModel.cs"
    , "Presentation\ViewModels\TYPENavigationViewModel.cs"
    , "Presentation\ViewModels\TYPEDetailViewModel.cs"            
    , "Presentation\ViewModels\ITEMViewModel.cs"
    , "Presentation\ViewModels\ITEMDetailViewModel.cs"        
)

Set-Location $templateFolder

Write-Host (Get-Location) $sourceMaster

function CompareFiles ([System.IO.FileInfo]$masterFile, [System.IO.FileInfo]$targetFile)
{
    if ($masterFile.LastWriteTime -ne $targetFile.LastWriteTime)
    {
        if ($masterFile.LastWriteTime -gt $targetFile.LastWriteTime)
        {
            $newer = "Master"
            [System.ConsoleColor]$foreGroundColor = "Green"
        }
        else 
        {
            $newer = "Target"
            [System.ConsoleColor]$foreGroundColor = "DarkYellow"
        }

        Write-Host -ForegroundColor $foreGroundColor.ToString() "    Last Write Time Different - $newer newer"

        if ($masterFile.LastWriteTime -gt $targetFile.LastWriteTime)
        {
            Write-Host -ForegroundColor Green "      master: " $masterFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
            Write-Host "      target: " $targetFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")

            while( -not ( ($choice= (Read-Host "Copy Master to Target")) -match "^(y|n)$")){ "Y or N ?"}

            if ($choice -eq "y")
            {
                Write-Host "Copying Master to Target"
                Copy-Item -Path $masterFile -Destination $targetFile
                $targetFile.LastWriteTime = $masterFile.LastWriteTime

                Write-Host -ForegroundColor Blue "      master: " $masterFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                Write-Host -ForegroundColor Blue "      target: " $targetFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")

                Read-Host "Enter to continue"             
            }   
            else
            {
                "Skipping"
            }                   
        }
        else
        {
            Write-Host -ForegroundColor DarkYellow "      target: " $targetFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
            Write-Host "      master: " $masterFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")

            while( -not ( ($choice= (Read-Host "Copy Target to Master")) -match "^(y|n)$")){ "Y or N ?"}

            if ($choice -eq "y")
            {
                Write-Host "Copying Target to Master"
                Copy-Item -Path $targetFile -Destination $masterFile
                $masterFile.LastWriteTime = $targetFile.LastWriteTime

                Write-Host -ForegroundColor Blue "      master: " $masterFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")
                Write-Host -ForegroundColor Blue "      target: " $targetFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss.fff")

                # This means masterFile may need to propagate to other places

                $script:masterFileUpdated = $true

                Read-Host "Enter to continue"
            }    
            else
            {
                "Skipping"
            }             
        }
    }
}

function UpdateMatchingFiles([string] $masterFile)
{
    if (Test-Path $sourceMaster\$masterFile)
    {
        $masterFileInfo = Get-ChildItem $sourceMaster\$masterFile
        Write-Host $masterFile $masterFileInfo.LastWriteTime $masterFileInfo.Length

        foreach ($templateFolder in $targetProjectTemplateFolders)
        {
            WriteDelimitedMessage "Checking files in $projectTemplates\$templateFolder"
    
            if (TEST-PATH $projectTemplates\$templateFolder\$masterFile)
            {
                $fileInfo = Get-ChildItem $projectTemplates\$templateFolder\$masterFile
                Write-Host " > " $fileInfo.Name $fileInfo.LastWriteTime $fileInfo.Length " in " $projectTemplates\$templateFolder

                CompareFiles $masterFileInfo $fileInfo
            }
        }

        Write-Host
    }
}

function ProcessProjectFiles()
{
    foreach ($masterFile in $commonProjectFiles)
    {
        UpdateMatchingFiles $masterFile
        # if (Test-Path $sourceMaster\$masterFile)
        # {
        #     $masterFileInfo = Get-ChildItem $sourceMaster\$masterFile
        #     Write-Host $masterFile $masterFileInfo.LastWriteTime $masterFileInfo.Length

        #     foreach ($templateFolder in $targetProjectTemplateFolders)
        #     {
        #         WriteDelimitedMessage "Checking files in $projectTemplates\$templateFolder"
        #         # Write-Host "Checking files in $projectTemplates\$templateFolder"
        
        #         if (TEST-PATH $projectTemplates\$templateFolder\$masterFile)
        #         {
        #             $fileInfo = Get-ChildItem $projectTemplates\$templateFolder\$masterFile
        #             Write-Host " > " $fileInfo.Name $fileInfo.LastWriteTime $fileInfo.Length " in " $projectTemplates\$templateFolder

        #             CompareFiles $masterFileInfo $fileInfo
        #         }
        #     }

        #     Write-Host
        # }
    }

    foreach ($masterFile in $commonItemFiles)
    {
        UpdateMatchingFiles $masterFile
        # if (Test-Path $sourceMaster\$masterFile)
        # {
        #     $masterFileInfo = Get-ChildItem $sourceMaster\$masterFile
        #     Write-Host $masterFile $masterFileInfo.LastWriteTime $masterFileInfo.Length  
    
        #     foreach ($templateFolder in $targetProjectTemplateFolders)
        #     {
        #         WriteDelimitedMessage "Checking files in $projectTemplates\$templateFolder"
        #         # Write-Host "Checking files in $projectTemplates\$templateFolder"
        
        #         if (TEST-PATH $projectTemplates\$templateFolder\$masterFile)
        #         {
        #             $fileInfo = Get-ChildItem $projectTemplates\$templateFolder\$masterFile
        #             Write-Host " > " $fileInfo.Name $fileInfo.LastWriteTime $fileInfo.Length " in " $projectTemplates\$templateFolder

        #             CompareFiles $masterFileInfo $fileInfo                  
        #         }
        #     }

        #     Write-Host
        # }
    }    
}
function ProcessItemFiles()
{
    foreach ($masterFile in $commonItemFiles)
    {
        if (Test-Path $sourceMaster\$masterFile)
        {
            $masterFileInfo = Get-ChildItem $sourceMaster\$masterFile
            Write-Host $masterFile $masterFileInfo.LastWriteTime $masterFileInfo.Length
        
            foreach ($templateFolder in $targetItemTemplateFolders)
            {
                WriteDelimitedMessage "Checking files in $itemTemplates\$templateFolder"
                # Write-Host "Checking files in $itemTemplates\$templateFolder"
        
                # Need to strip all but the last part of the name
                # as files go in the top level folder

                $masterFilePath = $masterFile.Split('\')
                $targetFile = $masterFilePath[$masterFilePath.Count-1]

                if (TEST-PATH $itemTemplates\$templateFolder\$targetFile)
                {
                    $fileInfo = Get-ChildItem $itemTemplates\$templateFolder\$targetFile
                    Write-Host " > " $fileInfo.Name $fileInfo.LastWriteTime $fileInfo.Length " in " $itemTemplates\$templateFolder

                    CompareFiles $masterFileInfo $fileInfo                 
                }
            }

            Write-Host
        }
    }
}

ProcessProjectFiles

ProcessItemFiles

if ($masterFileUpdated)
{
    Write-Host "Master file(s) updated.  Propagating changes"
    ProcessProjectFiles
    ProcessItemFiles
}

WriteDelimitedMessage "Synchronization Complete !"
Read-Host -Prompt "Press Enter to Exit"