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
        [int] $MaximumBackupDays = 7,
        [int] $MinimumBackups = 5
    )
    Process
    {
        Get-Backup |
            sort {$_.LastWriteTime} -Descending |
            select -skip $MinimumBackups |
            ? {(Get-Date) - $_.LastWriteTime -gt [TimeSpan]::FromDays($MaximumBackupDays)} |
            % {Write-Verbose "Delete $($_.FullName)"; rm $_.FullName}
    }
}
