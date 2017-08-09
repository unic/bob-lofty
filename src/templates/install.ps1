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

& "$scriptPath\lofty\tools\streams\streams" -d "$scriptPath\lofty\tools\iControl\iControl.dll" /accepteula | Out-Null
& "$scriptPath\lofty\tools\streams\streams" -d "$scriptPath\lofty\tools\iControl\iControlSnapIn.dll" /accepteula | Out-Null

Import-Module "$scriptPath\lofty\lofty"

$config = ([xml](Get-Content "$scriptPath\Config.xml")).Configuration

Import-Module WebAdministration

$appPoolName = $config.ApplicationPoolName
$websiteLocation = $config.WebsiteLocation
$url = $config.Url
$blueprintFolderPath = $config.BlueprintFolderPath
$backupDir = $config.BackupDir
$itemsDirectory = $config.ItemsDirectory
$configFolder = "$scriptPath\configs"
$role = $config.Role
$environment = $config.Environment
$isDelivery = $config.IsDelivery.ToLower() -eq "true"

if(-not $websiteLocation) {
    Write-Error "Website location is not set!"
}

if (-not $backupDir) {
    Write-Error "The backup dir is not set!"
}

if (-not $isDelivery)
{
    if(-not $itemsDirectory) {
        Write-Error "itemsDirectory in config is mandatory"
    }
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
    Write-Output "Backup website at $websiteLocation to $backupDir"
    Backup-WebRoot -Path $websiteLocation -BackupLocation $backupDir

    Write-Output "Purge website location $websiteLocation"
    rm "$websiteLocation\*" -Recurse -Force
}
else {
    mkdir $websiteLocation
}


Write-Output "Copy content of $scriptPath\website to  $websiteLocation"
cp "$scriptPath\website\*" "$websiteLocation\" -Recurse


Remove-EnvironmentFiles -WebRoot $websiteLocation `
    -Environment $Environment -Role $Role `
    -ConfigPath $configFolder

if($blueprintFolderPath) {
    Write-Output "Restore unmanaged files from $blueprintFolderPath to $websiteLocation"
    cp  "$blueprintFolderPath\*" "$websiteLocation\" -Recurse -Force
}

$unmanagedXdtFile = "$websiteLocation\Web.config.xdt"

Install-LoftyWebConfig `
    -ConfigPath $configFolder `
    -WebConfigPath "$websiteLocation\Web.config" `
    -Environment $Environment `
    -Role $Role `
    -UnmanagedXdtFile $unmanagedXdtFile

if(Test-Path $unmanagedXdtFile) {
    rm $unmanagedXdtFile
}

Write-Output "Starting IIS app pool $appPoolName"
Start-WebAppPool $appPoolName

if (-not $isDelivery)
{
    Install-AppItems $url "$itemsDirectory\items" "$scriptPath\tempAppItems" $configFolder $websiteLocation -AppItemsZipPath "$scriptPath\app.zip" 
    Install-DefaultItems $url "$itemsDirectory\defaultItems" "$scriptPath\tempDefaultItems" -DefaultItemsZipPath "$scriptPath\appDefault.zip"
}

(Get-Host).PrivateData.VerboseForegroundColor  = $originalVeboseColor

if(-not $Silent) {
    Write-Output "Installation of Sitecore website done. Press a key to close the window..."
    Read-Host
}

Stop-Transcript
