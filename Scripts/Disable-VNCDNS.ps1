
function DisableVNCDNS {
    "Current Setting ..."

    Get-NetIPConfiguration -InterfaceAlias Wi-Fi

    Set-DnsClientServerAddress –InterfaceAlias Wi-Fi -ResetServerAddresses
    
    "New Setting ...`n"
    
    Get-NetIPConfiguration -InterfaceAlias Wi-Fi
}

DisableVNCDNS