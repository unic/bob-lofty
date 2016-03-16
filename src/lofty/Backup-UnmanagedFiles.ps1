<#
.SYNOPSIS
Backup all unmanaged files inside a folder to a temp location.

.DESCRIPTION
Backup all unmanaged files inside a folder to a temp location.
The pattern of the unmanaged files is taken from the Bob.config files.

.PARAMETER WebPath
The path containing the unmanaged files.

.EXAMPLE
Backup-UnmanagedFiles -WebPath D:\webs\myweb

#>
function Backup-UnmanagedFiles
{
  [CmdletBinding()]
  Param(
      [Parameter(Mandatory=$true)]
      [string] $WebPath
  )
  Process
  {
    $tempBackup = Join-Path $env:TEMP ([GUID]::NewGuid())
    mkdir $tempBackup | Out-Null

    cp $WebPath\* $tempBackup -Recurse

    $tempBackup
  }
}
