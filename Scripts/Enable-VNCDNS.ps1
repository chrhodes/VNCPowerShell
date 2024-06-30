
function EnableVNCDNS {
    $dnsParams = @{
        InterfaceIndex = 3
        ServerAddresses = ("192.168.100.1", "192.168.100.3")
    }

    "Current Setting ..."
    Get-NetIPConfiguration -InterfaceAlias Wi-Fi

    Set-DnsClientServerAddress @dnsParams

    "New Setting ...`n"
    Get-NetIPConfiguration -InterfaceAlias Wi-Fi
}

EnableVNCDNS