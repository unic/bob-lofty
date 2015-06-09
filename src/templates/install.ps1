param($Silent = $false)

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$ErrorActionPreference = "Stop"
$originalVeboseColor = (Get-Host).PrivateData.VerboseForegroundColor
(Get-Host).PrivateData.VerboseForegroundColor  = (Get-Host).UI.RawUI.ForegroundColor

Import-Module "$scriptPath\lofty\lofty"

$config = ([xml](Get-Content "$scriptPath\Config.xml")).Configuration

Import-Module WebAdministration

$appPoolName = $config.ApplicationPoolName
$websiteLocation = $config.WebsiteLocation
$targetUrl = $config.Url
$itemPackages = $config.ItemPackages

if(-not $websiteLocation) {
    Write-Error "Website location is not set!"
}

if ((Get-WebAppPoolState($appPoolName)).Value -ne "Stopped"){
    Write-Host "Stopping IIS app pool $appPoolName"
    (ls "IIS:\AppPools\$appPoolName\WorkerProcesses") | % {Get-Process -Id $_.processId | Stop-Process -Force}
    Stop-WebAppPool $appPoolName
}

while((Get-WebAppPoolState($appPoolName)).Value -ne "Stopped") {
    Write-Host "Application Pool $appPoolName not yet stopped."
    sleep -Milliseconds 500
}


if(Test-Path $websiteLocation) {
    Write-Host "Backup website at $websiteLocation"
    Backup-WebRoot -Path $websiteLocation
    $unmanagedBackupLocation = (Get-Item (Backup-UnmanagedFiles -WebPath $websiteLocation -Verbose)).FullName

    Write-Host "Purge website location $websiteLocation"
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

$packages = $itemPackages.Split(";")

foreach($package in $packages) {
    $package = $package.Trim()
    $package = "$scriptPath\items\$package"

    if(Test-Path $package) {
        Install-ScSerializationPackage -Path $package -Url $targetUrl
    }
}

(Get-Host).PrivateData.VerboseForegroundColor  = $originalVeboseColor

if(-not $Silent) {
    Write-Host "Installation of Sitecore website done. Press a key to close the window..."
    Read-Host
}
