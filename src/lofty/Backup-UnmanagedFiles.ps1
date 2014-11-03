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

    Copy-RubbleItem -Path $webPath -Destination $tempBackup -Pattern (Get-RubblePattern $config.UnmanagedFiles) -Verbose

    $tempBackup
  }
}
