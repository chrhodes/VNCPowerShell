Install-module ImportExcel

cd C:\xxx\ClientApps

get-childitem -recurse frm*.vb | export-excel

get-childitem -recurse frmabout.* 
get-childitem -recurse frmapprovers.*
get-childitem -recurse frm*.vb | export-excel -Path frm.xlsx -Show
get-childitem -recurse mod*.vb | export-excel -Path mod.xlsx -Show
get-childitem -recurse std*.vb | export-excel -Path stdmod.xlsx -Show

cd C:\xxx\WebApps

get-childitem -recurse *.vb | export-excel -Path WebShared.xlsx -Show

cd C:\xxx\ClientApps

get-childitem -recurse stdmod*.vb

cd C:\xxx8\ClientApps

get-childitem -recurse stdmod*.vb
get-childitem -recurse modEmail.vb
