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
    Write-Verbose "Backup unamnaged files $webPath allready exists and Force is true. Backup and delete web folder."

    $config = Get-ScProjectConfig $WebPath

    Copy-RubbleItem -Path $webPath -Destination $tempBackup -Pattern (Get-RubblePattern $config.UnmanagedFiles) -Verbose

    $tempBackup
  }
}
