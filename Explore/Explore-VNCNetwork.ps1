# https://woshub.com/powershell-configure-windows-networking/
Get-NetAdapter

Get-NetAdapter -Physical | ? {$_.Status -eq "Up"}

Get-NetAdapter | Get-Member
Get-NetAdapter | Select-Object `
    name, LinkSpeed, InterfaceOperationalStatus,MacAddress

Get-NetAdapter | Select-Object NetworkAddresses | Get-Member

Get-NetAdapter -IncludeHidden

Get-NetAdapter -Name Wi-Fi
Get-NetAdapter -Name "vEthernet (nat)"

Get-NetIPConfiguration -InterfaceAlias Wi-Fi

Get-NetIPConfiguration -InterfaceAlias Wi-Fi -Detailed

Set-DnsClientServerAddress -InterfaceIndex 3 `
    -ServerAddresses 192.168.100.1, 192.168.100.3

Get-NetIPConfiguration -InterfaceAlias Wi-Fi -Detailed    

$dnsParams = @{
    InterfaceIndex = 3
    ServerAddresses = ("192.168.100.1", "192.168.100.3")
}

Set-DnsClientServerAddress @dnsParams

Set-NetIPInterface -InterfaceAlias Wi-Fi -Dhcp Enabled

Set-DnsClientServerAddress –InterfaceAlias Wi-Fi -ResetServerAddresses