<#
.SYNOPSIS
Restore all unmanaged files backed-up by `Backup-UnmanagedFiles` before.

.DESCRIPTION
Restore all unmanaged files backed-up by `Backup-UnmanagedFiles` before.
After the backup is restored, it will be deleted.

.PARAMETER WebPath
The path where the files should be restored to.

.PARAMETER TempPath
The temp path generated by `Backup-UnmanagedFiles`

.EXAMPLE
Restore-UnmanagedFiles -WebPath d:\webs\my -TempPath $backupPath

#>
function Restore-UnmanagedFiles
{
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$true)]
      [string] $WebPath,
      [Parameter(Mandatory=$true)]
      [string] $TempPath

    )
    Process
    {
        $config = Get-ScProjectConfig $WebPath
        if($config.UnmanagedFiles) {
            Copy-RubbleItem -Path $TempPath -Destination $WebPath -Pattern (Get-RubblePattern $config.UnmanagedFiles) -Verbose
        }
        else {
            Write-Warning "No UnmanagedFiles are configured."
        }

        rm $TempPath -Recurse
    }
}
