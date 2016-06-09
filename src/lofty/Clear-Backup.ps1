<#
.SYNOPSIS
Cleans up the backup directory.

.DESCRIPTION
Cleans up the backup directory by deleting all backups older than a specific
amount of days, but by always keeping a minimum amount of backups.

.PARAMETER BackupLocation
The backup folder to cleanup.

.PARAMETER MaximumBackupDays
The number of days to keep backups.

.PARAMETER MiniumBackups
The minimum number of backups to keep, even if they are older than the MaximumBackupDays.

.EXAMPLE
Clear-Backup

#>
function Clear-Backup
{
    [CmdletBinding()]
    Param(
        [string] $BackupLocation = "C:\Backup",
        [int] $MaximumBackupDays = 7,
        [int] $MinimumBackups = 5
    )
    Process
    {
        Get-Backup -BackupLocation $BackupLocation |
            sort {$_.LastWriteTime} -Descending |
            select -skip $MinimumBackups |
            ? {(Get-Date) - $_.LastWriteTime -gt [TimeSpan]::FromDays($MaximumBackupDays)} |
            % {Write-Verbose "Delete $($_.FullName)"; rm $_.FullName}
    }
}
