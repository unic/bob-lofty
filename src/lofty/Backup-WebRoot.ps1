<#
.SYNOPSIS
Backup the whole WebRoot.

.DESCRIPTION
Backup the whole WebRoot to a ZIP file in D:\backup or a specified location.


.PARAMETER Path
The folder to backup.

.PARAMETER BackupLocation
The folder where the backup ZIP file should be placed.

.PARAMETER BackupFileName
The name of the ZIP file.
If a combination of folder-name, computer name and date will be used.

.EXAMPLE

#>
function Backup-WebRoot
{
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$true)]
      [string] $Path,
      [string] $BackupLocation = "D:\Backup\OctopusDeploy",
      [string] $BackupFileName
    )
    Process
    {
        if(-not (Test-Path $BackupLocation)) {
            mkdir $BackupLocation | Out-Null
        }
        if(-not $BackupFileName) {
            $name = (Get-Item $Path).Name
            $date = (Get-Date -f "yyyy-MM-dd-hhmm")
            $BackupFileName = "$name-$($env:COMPUTERNAME)-$date.zip"
        }

        $oldBackups = ls $BackupLocation
        Write-RubbleArchive -Path $Path -OutputLocation (Join-Path $BackupLocation $BackupFileName)

    }
}
