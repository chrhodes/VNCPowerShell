
function EnableVNCDNS {
    $interfaceIndex = (get-netipconfiguration -InterfaceAlias 'Wi-Fi').InterfaceIndex
    $dnsParams = @{
        InterfaceIndex = $interfaceIndex
        ServerAddresses = ("192.168.100.1", "192.168.100.3")
    }

    "Current Setting ..."
    Get-NetIPConfiguration -InterfaceAlias Wi-Fi

    "Using new DNS Parameters"
    $dnsParams

    Set-DnsClientServerAddress @dnsParams

    "New Setting ...`n"
    Get-NetIPConfiguration -InterfaceAlias Wi-Fi
}

EnableVNCDNS

Write-Host "Press Enter to exit ..."
Read-Host