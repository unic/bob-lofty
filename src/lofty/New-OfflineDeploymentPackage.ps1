<#
.SYNOPSIS
Creates a new offline deployment package.

.DESCRIPTION
Creates a new deploymnet package which can then be transfered to a customer
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

.PARAMETER TargetUrl
The url of the Sitecore website on the target system.
This will be used on the author system to install the items.

.PARAMETER ItemsPath
The path to the folder containing all item packages to install.

.PARAMETER ItemPackages
A list of file names of item packages which must be in the `ItemsPath`.
All file names must be separated by a `;`.

.EXAMPLE
New-OfflineDeploymentPackage -WebsitePath D:\Website -TargetWebsitePath D:\webs\sitecore-website -TargetAppPoolName sitecore-website `
    -PackageName MyPackage -WorkingDirectory D:\Temp -TargetDirectory D:\Output -TargetUrl http://author.customer.com  -ItemsPath "D:\items" `
    -ItemPackages items.update

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
        [string] $TargetUrl,
        [string] $ItemsPath,
        [string] $ItemPackages
    )
    Process
    {
        $tempDirectory = "$WorkingDirectory\" + [Guid]::NewGuid()
        $tempWorkingDirectory = "$tempDirectory\$PackageName"
        mkdir $tempWorkingDirectory
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

        if($ItemsPath -and (Test-Path $ItemsPath)) {
            mkdir items
            cp "$ItemsPath\*" .\items -Recurse
        }

        $doc = New-Object System.XML.XMLDocument
        $docRoot = $doc.CreateElement("configuration")
        $doc.AppendChild($docRoot) | Out-Null

        $config = @{
            "ApplicationPoolName" = $TargetAppPoolName;
            "WebsiteLocation" = $TargetWebsitePath;
            "TargetUrl" = $TargetUrl;
            "ItemPackages" = $ItemPackages;
        }
        foreach($key in $config.Keys) {
            $element = $doc.CreateElement($key)
            $element.InnerText = $config[$key]
            $docRoot.AppendChild($element)
        }

        $configPath = "$($pwd.Path)\config.xml"
        $doc.Save($configPath)
        Write-Host "Wrote config file at $configPath."

        $packagesPath = (Resolve-Path . ).Path + "\$PackageName.zip"
        Write-Host "Pack content of $tempWorkingDirectory to $packagesPath"
        Add-RubbleArchiveFile -Path $tempWorkingDirectory -ArchivePath $packagesPath
        if(-not (Test-Path $TargetDirectory)) {
            mkdir $TargetDirectory
        }

        Write-Host "Move $packagesPath $TargetDirectory"
        mv $packagesPath $TargetDirectory

        Pop-Location

        rm $tempWorkingDirectory -Recurse


    }
}
