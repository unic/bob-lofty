<#
.SYNOPSIS
Install the default items to the Sitecore website.

.DESCRIPTION
Install the default items to the Sitecore website

.PARAMETER Url

.PARAMETER ItemReferencesPath


.PARAMETER TempItemspath



.EXAMPLE

#>
function Install-DefaultItems {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Url,
        [Parameter(Mandatory=$true)]
        [string] $ItemReferencesPath,
        [Parameter(Mandatory=$true)]
        [string] $TempItemspath
    )
    Process
    {
        $tempPath = "$TempItemspath\$([Guid]::NewGuid())"
        mkdir $tempPath
        $archivePath = Resolve-Path ".\appDefault.zip"
        Write-Verbose "Extract $archivePath to $tempPath"
        Expand-RubbleArchive $archivePath $tempPath 
        
        $updatePackageFile =  "$tempPath\package.update"
        New-ScSerializationPackage -Source "$tempPath\appDefault" -Target $ItemReferencesPath -OutputFile $updatePackageFile -CollisionMode "Skip"
        
        Write-Verbose "Install item package $updatePackageFile to $Url"
        Install-ScSerializationPackage -Path $updatePackageFile -Url $Url
        
        Write-Verbose "Move $ItemReferencesPath to $tempPath"
        mv $ItemReferencesPath  "$tempPath\"
        
        Write-Verbose "Move $tempPath\appDefaul to $ItemReferencesPath"
        mv "$tempPath\appDefault" $ItemReferencesPath
         
        Write-Verbose "Remove $tempPath"
        rm $tempPath -Recurse
    }
}