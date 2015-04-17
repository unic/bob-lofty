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
        [string] $WorkingDirectory
    )
    Process
    {
        $tempDirectory = "$WorkingDirectory\" + [Guid]::NewGuid()
        $tempWorkingDirectory = "$tempDirectory\$PackageName"
        mkdir $tempWorkingDirectory
        Push-Location $tempWorkingDirectory

        cp "$PSScriptRoot\..\templates\install.ps1" .

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

        $doc = New-Object System.XML.XMLDocument
        $docRoot = $doc.CreateElement("configuration")
        $doc.AppendChild($docRoot)

        $config = @{
            "ApplicationPoolName" = $TargetAppPoolName;
            "WebsiteLocation" = $TargetWebsitePath
        }
        foreach($key in $config.Keys) {
            $element = $doc.CreateElement($key)
            $element.InnerText = $config[$key]
            $docRoot.AppendChild($element)
        }

        $doc.Save("$($pwd.Path)\config.xml")

        Pop-Location

        Add-RubbleArchiveFile -Path $tempWorkingDirectory -ArchivePath ".\$PackageName.zip"
        rm $tempDirectory -Recurse
        New-OctopusArtifact (Resolve-Path ".\$PackageName.zip")


    }
}
