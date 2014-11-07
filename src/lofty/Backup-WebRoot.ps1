function Backup-WebRoot
{
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$true)]
      [string] $Path,
      [string] $BackupLocation,
      [string] $BackupFileName
    )
    Process
    {
        if(-not $BackupLocation) {
            $BackupLocation = "D:\backup"
            if(-not (Test-Path $BackupLocation)) {
                mkdir $BackupLocation | Out-Null
            }
        }
        if(-not $BackupFileName) {
            $name = (Get-Item $Path).Name
            $date = (Get-Date -f "yyyy-MM-dd-hhmm")
            $BackupFileName = "$name-$($env:COMPUTERNAME)-$date.zip"
        }

        Write-RubbleArchive -Path $Path -OutputLocation (Join-Path $BackupLocation $BackupFileName)
    }
}
