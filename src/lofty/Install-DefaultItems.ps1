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
        Expand-RubbleArchive ".\appDefault.zip" $tempPath 
        
        $updatePackageFile =  "$tempPath\package.update"
        New-ScSerializationPackage -Source "$tempPath\appDefault" -Target $ItemReferencesPath -OutputFile $updatePackageFile -CollisionMode "Skip"
        
        Install-ScSerializationPackage -Path $updatePackageFile -Url $Url
        
        rm $tempPath -Recurse
    }
}