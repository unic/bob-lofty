<#
.SYNOPSIS
Get all backup files in a specific folder.

.DESCRIPTION
Get all backup files in a specific folder.

.PARAMETER BackupFolder
The folder containing all backups.

.EXAMPLE
Get-Backup D:\Backup\OctopusDeploy

#>
function Get-Backup
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $BackupLocation
    )
    Process
    {
        ls "$BackupLocation\*.zip"
    }
}
