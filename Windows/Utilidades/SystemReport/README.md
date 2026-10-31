# Get-SystemReport

Muestra un resumen del equipo: sistema operativo, CPU, RAM, último arranque y espacio libre en discos.

Solo lee información del sistema. No modifica nada.

## Uso

```powershell
.\Get-SystemReport.ps1                          # muestra el informe en pantalla
.\Get-SystemReport.ps1 -OutFile informe.txt     # lo guarda en un archivo
```

Requiere PowerShell 5.1 o superior.
