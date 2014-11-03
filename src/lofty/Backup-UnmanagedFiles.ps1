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
