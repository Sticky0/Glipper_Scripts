param(
    [string]$OutFile
)

$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

$report = [ordered]@{
    Equipo      = $env:COMPUTERNAME
    Usuario     = $env:USERNAME
    Sistema     = $os.Caption
    Version     = $os.Version
    UltimoInicio = $os.LastBootUpTime
    CPU         = $cpu.Name
    RAM_GB      = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    Discos      = ($disks | ForEach-Object {
        "{0}: {1} GB libres de {2} GB" -f $_.DeviceID, [math]::Round($_.FreeSpace / 1GB, 1), [math]::Round($_.Size / 1GB, 1)
    }) -join "; "
}

$lines = $report.GetEnumerator() | ForEach-Object { "{0,-13}: {1}" -f $_.Key, $_.Value }

if ($OutFile) {
    $lines | Set-Content -Path $OutFile -Encoding UTF8
    Write-Host "Informe guardado en $OutFile"
} else {
    $lines
}
