<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

#>
function Cleanup-Backup
{
    [CmdletBinding()]
    Param(
        [string] $BackupLocation = "D:\Backup\OctopusDeploy",
        [int] $MaximumBackupDays = 7
    )
    Process
    {
        Get-Backup | ? {(Get-Date) - $_.LastWriteTime -gt [TimeSpan]::FromDays($MaximumBackupDays)} | % {rm $_.FullName}
         #? {(Get-Date) - $_.LastWriteTime -gt $MaximumBackupDays} | % {rm $_.FullName}
    }
}
