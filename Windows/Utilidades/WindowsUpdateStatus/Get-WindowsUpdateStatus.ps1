# Muestra la última actualización instalada según el historial de Windows Update.
# Las pendientes requieren el módulo PSWindowsUpdate, que no se instala aquí.

$session = New-Object -ComObject Microsoft.Update.Session
$searcher = $session.CreateUpdateSearcher()
$historyCount = $searcher.GetTotalHistoryCount()

$history = if ($historyCount -gt 0) {
    $searcher.QueryHistory(0, [math]::Min($historyCount, 10))
} else {
    @()
}

"Últimas entradas del historial:"
$history |
    Where-Object { $_.Title } |
    Select-Object @{ Name = "Fecha"; Expression = { $_.Date } }, @{ Name = "Resultado"; Expression = { $_.ResultCode } }, Title |
    Format-Table -AutoSize -Wrap

if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
    "Pendientes (PSWindowsUpdate):"
    Get-WindowsUpdate
} else {
    "Pendientes: instala el módulo PSWindowsUpdate para verlas (no se instala automáticamente)."
}
