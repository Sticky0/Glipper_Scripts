Get-NetIPConfiguration |
    Where-Object { $_.NetAdapter.Status -eq "Up" } |
    Select-Object `
        @{ Name = "Adaptador"; Expression = { $_.InterfaceAlias } },
        @{ Name = "IPv4"; Expression = { $_.IPv4Address.IPAddress } },
        @{ Name = "Puerta"; Expression = { $_.IPv4DefaultGateway.NextHop } },
        @{ Name = "DNS"; Expression = { $_.DNSServer.ServerAddresses -join ", " } } |
    Format-List
