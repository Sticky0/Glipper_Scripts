$runKeys = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
)

$registry = foreach ($key in $runKeys) {
    if (Test-Path $key) {
        (Get-ItemProperty -Path $key).PSObject.Properties |
            Where-Object { $_.Name -notlike "PS*" } |
            ForEach-Object {
                [pscustomobject]@{
                    Origen  = $key
                    Nombre  = $_.Name
                    Comando = $_.Value
                }
            }
    }
}

$folders = foreach ($folder in @([Environment]::GetFolderPath("Startup"), [Environment]::GetFolderPath("CommonStartup"))) {
    Get-ChildItem -Path $folder -ErrorAction SilentlyContinue |
        ForEach-Object {
            [pscustomobject]@{
                Origen  = $folder
                Nombre  = $_.Name
                Comando = $_.FullName
            }
        }
}

@($registry) + @($folders) | Format-Table -AutoSize
