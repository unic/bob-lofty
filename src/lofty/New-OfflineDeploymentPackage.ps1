<#
.SYNOPSIS
Creates a new offline deployment package.

.DESCRIPTION
Creates a new deployment package which can then be transfered to a customer
and installed offline.

.PARAMETER WebsitePath
The path to the web-root which should be packed in the offline package.

.PARAMETER TargetWebsitePath
The path on the offline server where the website should be deployed to.

.PARAMETER TargetAppPoolName
The name of the application pool on the offline server.

.PARAMETER PackageName
The name without extension the created ZIP file will get.

.PARAMETER WorkingDirectory
The directory where New-OfflineDeploymentPackage should move files arround
and do its work.

.PARAMETER TargetDirectory
The folder where the package will be put at the end of package generation
process.

.PARAMETER Url
The url of the Sitecore website on the target system.
This will be used on the author system to install the items.

.PARAMETER ItemsPath
The path to the folder containing all item packages to install.

.PARAMETER ConfigsPath
The path to the folder containing the configuration files.

.PARAMETER BlueprintFolderPath
The path to the folder containing the unmanaged files.

.PARAMETER BackupDir
The path to the folder where the files will be backed up before deployment.

.PARAMETER IsDelivery
Indicates whether the package will be installed on a delivery environment. It is used to decide whether the items should be installed.

.PARAMETER AdditionalWebsites
Additional websites as array of objects providing: WebsitePath, TargetWebsitePath, TargetAppPoolName and optionally BlueprintFolderPath

.EXAMPLE
New-OfflineDeploymentPackage -WebsitePath D:\Website -TargetWebsitePath D:\webs\sitecore-website -TargetAppPoolName sitecore-website `
    -PackageName MyPackage -WorkingDirectory D:\Temp -TargetDirectory D:\Output -Url http://author.customer.com  -ItemsPath "D:\items" `
    -AdditionalWebsites @(
    @{
        WebsitePath         = "D:\offline-source\foo";
        TargetWebsitePath   = "d:\webs\foo";
        TargetAppPoolName   = "foo";
    },
    @{
        WebsitePath         = "D:\offline-source\bar";
        TargetWebsitePath   = "d:\webs\bar";
        TargetAppPoolName   = "bar";
        BlueprintFolderPath = "d:\data\bar-template"
    })

#>
function New-OfflineDeploymentPackage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $WebsitePath,
        [Parameter(Mandatory=$true)]
        [string] $TargetWebsitePath,
        [Parameter(Mandatory=$true)]
        [string] $TargetAppPoolName,
        [Parameter(Mandatory=$true)]
        [string] $PackageName,
        [Parameter(Mandatory=$true)]
        [string] $WorkingDirectory,
        [Parameter(Mandatory=$true)]
        [string] $TargetDirectory,
        [string] $Url,
        [string] $ItemsPath,
        [string] $ConfigsPath,
        [string] $BlueprintFolderPath,
        [string] $BackupDir = "C:\Backup",
        [string] $TargetItemsDirectory,
        [string] $IsDelivery,
        [string] $Environment = "",
        [string] $Role = "",
        $AdditionalWebsites
    )
    Process
    {
        function AddXmlConfigNode ($doc, $parent, $config, $nodeName) {
            $node = $doc.CreateElement($nodeName)
            $parent.AppendChild($node) | Out-Null
            foreach($key in $config.Keys) {
                $element = $doc.CreateElement($key)
                $element.InnerText = $config[$key]
                $node.AppendChild($element)
            }
            $node
        }

        $tempWorkingDirectory = ""
        while ($tempWorkingDirectory -eq "")
        {
            $testPath = "$WorkingDirectory\" + [Guid]::NewGuid().GetHashCode().toString("x")
            if(-not (Test-Path $testPath)) {
                mkdir $testPath
                $tempWorkingDirectory = $testPath
            }
        }
        
        Push-Location $tempWorkingDirectory

        cp "$PSScriptRoot\..\templates\*" .

        mkdir lofty
        cp "$PSScriptRoot\..\*" ".\lofty\" -Recurse

        $possiblePackagesFolder = "$PSScriptRoot\..\..\packages"
        write-host $possiblePackagesFolder
        if((Get-Item (Split-Path $PSScriptRoot)).Name -eq "src" -and (Test-Path $possiblePackagesFolder)) {
            cp $possiblePackagesFolder ".\lofty\tools" -Recurse
            cp "$PSScriptRoot\..\..\tools\*" ".\lofty\tools" -Recurse

        }

        mkdir website
        cp "$WebsitePath\*" .\website -Recurse

        foreach ($website in $AdditionalWebsites) {
            $folderName = "website-$($website.TargetAppPoolName)"
            mkdir $folderName
            cp "$($website.WebsitePath)\*" .\$folderName -Recurse
        }

        if($ItemsPath -and (Test-Path $ItemsPath)) {
            mkdir items
            cp "$ItemsPath\*" . -Recurse
        }
        
        if($ConfigsPath -and (Test-Path $ConfigsPath)) {
            mkdir configs
            cp "$ConfigsPath\*" .\configs -Recurse
        }
        
        $doc = New-Object System.XML.XMLDocument

        $config = @{
            "ApplicationPoolName" = $TargetAppPoolName;
            "WebsiteLocation" = $TargetWebsitePath;
            "Url" = $Url;
            "BlueprintFolderPath" = $BlueprintFolderPath;
            "BackupDir" = $BackupDir;
            "IsDelivery" = $IsDelivery;
            "ItemsDirectory" = $TargetItemsDirectory;
            "Role" = $Role;
            "Environment" = $Environment;
        }

        $docRoot = AddXmlConfigNode $doc $doc $config "configuration"

        if ($AdditionalWebsites) {
            $websitesElement = $doc.CreateElement("AdditionalWebsites")
            $docRoot.AppendChild($websitesElement) | Out-Null
            foreach ($website in $AdditionalWebsites) {
                $additionalConfig = @{
                    "ApplicationPoolName" = $website.TargetAppPoolName;
                    "WebsiteLocation" = $website.TargetWebsitePath;
                    "BlueprintFolderPath" = $website.BlueprintFolderPath;
                }
                AddXmlConfigNode $doc $websitesElement $additionalConfig "Website"
            }
        }

        $configPath = "$($pwd.Path)\config.xml"
        $doc.Save($configPath)
        Write-Host "Wrote config file at $configPath."
        
        # Sanitize package name: the "multiple role support" feature adds semicolons
        $PackageName = $PackageName.Replace(";", "_")
        Write-Host "Using \"$PackageName\" as package name."
        
        $packagesPath = $WorkingDirectory + "\$PackageName.zip"

        Write-Host "Pack content of $tempWorkingDirectory to $packagesPath"
        Add-RubbleArchiveFile -Path $tempWorkingDirectory -ArchivePath $packagesPath -RelativeToPath $tempWorkingDirectory
        
        if(-not (Test-Path $TargetDirectory)) {
            mkdir $TargetDirectory
        }

        Write-Host "Move $packagesPath $TargetDirectory"
        mv $packagesPath $TargetDirectory

        Pop-Location

        rm $tempWorkingDirectory -Recurse
    }
}
