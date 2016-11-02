<#
.SYNOPSIS
Install the default items to the Sitecore website.

.DESCRIPTION
Install the default items to the Sitecore website.
The items will be taken from the ".\appDefault.zip"

.PARAMETER Url
The url of the Sitecore website where the items should be installed.

.PARAMETER ItemReferencesPath
The path on the file system to the folder, where the items are located 
which were installed during the last deployment. 
Note that this command will copy all installed items to this location when the items were installed 

.PARAMETER TempItemspath
A path on the file system used by the command to put temporary data.


.EXAMPLE
Install-DefaultItems

#>
function Install-DefaultItems {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Url,
        [Parameter(Mandatory=$true)]
        [string] $ItemReferencesPath,
        [Parameter(Mandatory=$true)]
        [string] $TempItemspath,
        [string] $DefaultItemsZipPath = ".\appDefault.zip"
    )
    Process
    {
        $Url = $Url.TrimEnd('/')
        
        $tempPath = "$TempItemspath\$([Guid]::NewGuid())"
        mkdir $tempPath
        $archivePath = Resolve-Path $DefaultItemsZipPath
        Write-Verbose "Extract $archivePath to $tempPath"
        Expand-RubbleArchive $archivePath $tempPath 
        
        $updatePackageFile =  "$tempPath\package.update"
        New-ScSerializationPackage -Source $ItemReferencesPath -Target "$tempPath\appDefault" -OutputFile $updatePackageFile -CollisionMode "Skip"
        
        Write-Verbose "Install item package $updatePackageFile to $Url"
        Install-ScSerializationPackage -Path $updatePackageFile -Url $Url
        
        Write-Verbose "Move $ItemReferencesPath to $tempPath"
        mv $ItemReferencesPath  "$tempPath\"
        
        Write-Verbose "Move $tempPath\appDefault to $ItemReferencesPath"
        mv "$tempPath\appDefault" $ItemReferencesPath
         
        try  {
            Write-Verbose "Remove $tempPath"
            rm $tempPath -Recurse -Force
        }
        catch {
            Write-Warning "Could not remove $tempPath. Error: $($_.Exception.Message)"
        }    }
}