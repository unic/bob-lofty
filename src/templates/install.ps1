param($Silent = $false)

trap {
    Write-Output ($_ | Out-String) -ForegroundColor Red

    if(-not $Silent) {
        Write-Output "An error occured during the installation of the website. Press enter to close the window..." -ForegroundColor Red
        Read-Host
        Stop-Transcript
        return
    }
}


$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$ErrorActionPreference = "Stop"
$originalVeboseColor = (Get-Host).PrivateData.VerboseForegroundColor
(Get-Host).PrivateData.VerboseForegroundColor  = (Get-Host).UI.RawUI.ForegroundColor

Start-Transcript "$scriptPath\$((Get-Date).ToString("yyyy-MM-dd-HH-mm")).log"

& "$scriptPath\lofty\tools\streams\streams" -d "$scriptPath\lofty\tools\iControl\iControl.dll"
& "$scriptPath\lofty\tools\streams\streams" -d "$scriptPath\lofty\tools\iControl\iControlSnapIn.dll"

Import-Module "$scriptPath\lofty\lofty"

$config = ([xml](Get-Content "$scriptPath\Config.xml")).Configuration

Import-Module WebAdministration

$appPoolName = $config.ApplicationPoolName
$websiteLocation = $config.WebsiteLocation
$targetUrl = $config.TargetUrl
$itemPackages = $config.ItemPackages

if(-not $websiteLocation) {
    Write-Error "Website location is not set!"
}

if ((Get-WebAppPoolState($appPoolName)).Value -ne "Stopped"){
    Write-Output "Stopping IIS app pool $appPoolName"
    (ls "IIS:\AppPools\$appPoolName\WorkerProcesses") | % {Get-Process -Id $_.processId | Stop-Process -Force}
    Stop-WebAppPool $appPoolName
}

while((Get-WebAppPoolState($appPoolName)).Value -ne "Stopped") {
    Write-Output "Application Pool $appPoolName not yet stopped."
    sleep -Milliseconds 500
}


if(Test-Path $websiteLocation) {
    Write-Output "Backup website at $websiteLocation"
    Backup-WebRoot -Path $websiteLocation
    $unmanagedBackupLocation = (Get-Item (Backup-UnmanagedFiles -WebPath $websiteLocation -Verbose)).FullName

    Write-Output "Purge website location $websiteLocation"
    rm "$websiteLocation\*" -Recurse -Force
}
else {
    mkdir $websiteLocation
}


Write-Output "Copy content of $scriptPath\website to  $websiteLocation"
cp  "$scriptPath\website\*" "$websiteLocation\" -Recurse


Write-Output "Restore unmanaged files from $unmanagedBackupLocation to $websiteLocation"
if($unmanagedBackupLocation) {
    Restore-UnmanagedFiles -WebPath $websiteLocation -TempPath $unmanagedBackupLocation
}

Write-Output "Starting IIS app pool $appPoolName"
Start-WebAppPool $appPoolName

$packages = $itemPackages.Split(";")

foreach($package in $packages) {
    $package = $package.Trim()
    $package = "$scriptPath\items\$package"

    if(Test-Path $package) {
        Write-Output "Installing items package $package to $targetUrl. This will take a moment..."
        Install-ScSerializationPackage -Path $package -Url $targetUrl
    }
}

(Get-Host).PrivateData.VerboseForegroundColor  = $originalVeboseColor

if(-not $Silent) {
    Write-Output "Installation of Sitecore website done. Press a key to close the window..."
    Read-Host
}

Stop-Transcript
