<#
.SYNOPSIS
Backup all unmanaged files inside a folder to a temp location.

.DESCRIPTION
Backup all unmanaged files inside a folder to a temp location.
The pattern of the unmanaged files is taken from the Bob.config files.

.PARAMETER WebPath
The path containing the unmanaged files.

.PARAMETER ConfigPath
The path containing App_Config\Bob.config

.EXAMPLE
Backup-UnmanagedFiles -WebPath D:\webs\myweb -ConfigPath D:\webs\myweb

#>
function Backup-UnmanagedFiles
{
  [CmdletBinding()]
  Param(
      [Parameter(Mandatory=$true)]
      [string] $WebPath,
      [Parameter(Mandatory=$true)]
      [string] $ConfigPath

  )
  Process
  {
    $tempBackup = Join-Path $env:TEMP ([GUID]::NewGuid())
    mkdir $tempBackup | Out-Null

    $config = Get-ScProjectConfig $ConfigPath
    if($config.UnmanagedFiles) {
        Copy-RubbleItem -Path $webPath -Destination $tempBackup -Pattern (Get-RubblePattern $config.UnmanagedFiles) -Verbose

    }
    else {
        Write-Warning "No UnmanagedFiles are configured."
    }

    $tempBackup
  }
}
