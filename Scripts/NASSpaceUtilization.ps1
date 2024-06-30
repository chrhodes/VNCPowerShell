################################################################################
#
# NASSpaceUtilization.ps1
#
#
# Script to automate the collection of space utilized by folders on a NAS share.
#
# TODO:
#	Need to auto-discover folders.
#	Need to handle case where no access on sub-folder
#
################################################################################

# This needs to be first.
# Get command line arguments

param(
	[string] $NASShare=$(throw 'Need NAS Share as \\ShareName')
	)

# For now the list of shares on each NAS drive are hard coded in this program.  
# A future release may make this discoverable at runtime

$IndFTP01 = "ADMSSQL", "DCM", "DCM_SUPPORT", "DCMCorr", "DCMCorrStg", "DCMProd", `
		"DCMProdDataSets", "DCMstage", "DCMStgDatasets", "ExtAdj", "FieldFin", `
		"FTPPROD", "ftproot", "ftptest", "Helpdesk", "LAWSON", "LegacyDataDelivery", `
		"LogShare", "LogShareStg", "NDM2", "NDMTEST", "netsec", "NTI", "PBSRPTS", `
		"Pivotal", "PLCWS", "PLDocuMaker", "PLDocumakerStg", "RCExtAdj", "SDD", `
		"STG_Helpdesk", "wwwroot", "xlr750"
		
$xxxExtFil02 = "AWDTempFiles", "CaptivaAWD", "CaptivaIAC", "CaptivaIAS", "CSDFORMS", `
		"DataFeeds", "DSTO", "IWMClientLogs", "IWMLogs", "MCR", "MoveItDMZ", `
		"NavigatorOutput", "NavPPTAutomationFiles", "PLCWS", "PPT", "PPTIllustrationOutputs", `
		"PPTReportsOutput", "root", "Webtrends", "Z"
		
$xxxNas115 = "BizApps", "BizDeploy", "ClientServices", "CDSFORMS", "DataDelivery", `
		"DCM Logs", "DSTO", "xxxNas115", "xxxRptSvc_FundXferAudit", "SQLDumps", `
		"STGCSDFORMS", "TRNCSDFORMS", "Z"
		
$xxxWeb27 = "ALIS"	, "bowne", "Client_Services_Reports", "DailyUnitValues", `
		"DataDelivery", "DataServices", "DUV_in", "LabOne", "MCR", "MCRReports", `
		"NDM", "Reports", "temp", "UsageOutput", "VITs", "WF_Reins"

# Display space used by NAS Share

function DisplayNASFolderUsage($folders)
{
	echo "Space Utilization on $NASShare"
	
	foreach ($folder in $folders)
	{
		# Verify there is access to the folder
		Get-Item $NASShare\$folder > $null 2> $null
		
		if ($?)
		{
			$results = (Get-ChildItem $NASShare\$folder -recurse -ea silentlycontinue | Measure-Object -property length -sum)		
			# 10 is length of " <No Access>"
			"{0,10:N2}" -f ($results.Sum / 1MB) + " MB" + " : \" + $folder		
		}
		else
		{
			" <No Access>" + " : \" + $folder
		}
	}
}

################################################################################
#
# Main script
#
################################################################################

switch ($NASShare)
{
	'\\Ind-Ftp-01'
	{
		DisplayNASFolderUsage($IndFTP01)
	}
	
	'\\xxxExtFil02'
	{
		DisplayNASFolderUsage($xxxExtFil02)
	}
	
	'\\xxxNas115'
	{
		DisplayNASFolderUsage($xxxNas115)
	}
	
	'\\xxxWeb27'
	{
		DisplayNASFolderUsage($xxxWeb27)
	}	
}

################################################################################
#
# End NASSpaceUtilization.ps1
#
################################################################################




