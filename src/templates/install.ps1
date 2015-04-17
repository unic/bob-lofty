$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$ErrorActionPreference = "Stop"

Import-Module "$scriptPath\lofty\lofty"

$config = ([xml](Get-Content "$scriptPath\Config.xml")).Configuration

Import-Module WebAdministration

$appPoolName = $config.ApplicationPoolName
$websiteLocation = $config.WebsiteLocation

if(-not $websiteLocation) {
    Write-Error "Website location is not set!"
}

if ((Get-WebAppPoolState($appPoolName)).Value -ne "Stopped"){
    Write-Host "Stopping IIS app pool $appPoolName"
    Stop-WebAppPool $appPoolName
}

while((Get-WebAppPoolState($appPoolName)).Value -ne "Stopped") {
    Write-Host "Application Pool $appPoolName not yet stopped."
    sleep -Milliseconds 500
}


if(Test-Path $websiteLocation) {
    Backup-WebRoot -Path $websiteLocation
    $unmanagedBackupLocation = Backup-UnmanagedFiles -WebPath $websiteLocation -Verbose

    Write-Host "Purge Website location $websiteLocation"
    rm "$websiteLocation\*" -Recurse -Force
}
else {
    mkdir $websiteLocation
}


Write-Host "Copy content of $scriptPath\website to  $websiteLocation"
cp  "$scriptPath\website\*" "$websiteLocation\" -Recurse


Write-host "Restore unmanaged files from $BackupPath to $websiteLocation"
if($unmanagedBackupLocation) {
    Restore-UnmanagedFiles -WebPath $websiteLocation -TempPath $unmanagedBackupLocation
}

Write-host "Starting IIS app pool $appPoolName"
Start-WebAppPool $appPoolName
