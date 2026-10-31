param(
    [int]$Top = 10
)

Get-Process |
    Sort-Object WorkingSet64 -Descending |
    Select-Object -First $Top `
        @{ Name = "Proceso"; Expression = { $_.ProcessName } },
        @{ Name = "PID"; Expression = { $_.Id } },
        @{ Name = "RAM_MB"; Expression = { [math]::Round($_.WorkingSet64 / 1MB, 1) } },
        @{ Name = "CPU_s"; Expression = { [math]::Round($_.CPU, 1) } } |
    Format-Table -AutoSize
