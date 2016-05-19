<#
.SYNOPSIS
Install the app items to the Sitecore website.

.DESCRIPTION
Install the app items to the Sitecore website.
The items will be taken from the ".\app.zip".

.PARAMETER Url
The url of the Sitecore website where the items should be installed.

.PARAMETER ItemReferencesPath
The path where the items should be placed on the file system.

.PARAMETER TempItemspath
A path on the file system used by the command to put temporary data.

.PARAMETER ConfigPath
The path to the folder where the Bob.config is located.

.PARAMETER WebRoot
The path to the web-root of the Sitecore website.

.EXAMPLE
Install-AppItems -Url http://local.sitecore.com -ItemReferencesPath D:\items\appItems -TempItemsPath D:\items\temp -ConfigPath D:\packages\Sitecore.Config -WebRoot D:\Webs\sitecore

#>
function Install-AppItems {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Url,
        [Parameter(Mandatory=$true)]
        [string] $ItemReferencesPath,
        [Parameter(Mandatory=$true)]
        [string] $TempItemspath,
        [string] $ConfigPath,
        [string] $WebRoot
    )
    Process
    {
        $Url = $Url.TrimEnd('/')
        
        $tempPath = "$TempItemspath\$([Guid]::NewGuid())"
        mkdir $tempPath
        $archivePath = Resolve-Path ".\app.zip"
        Write-Verbose "Extract $archivePath to $tempPath"
        Expand-RubbleArchive $archivePath "$tempPath\app" 
        
        if(Test-Path $ItemReferencesPath) {
            Write-Verbose "Move $ItemReferencesPath to $tempPath"
            mv $ItemReferencesPath  "$tempPath\backup"
        }
        
        Write-Verbose "Move $tempPath\app to $ItemReferencesPath"
        mv "$tempPath\app" $ItemReferencesPath
                
        Set-ScSerializationReference $WebRoot $ConfigPath -SerializationPath $ItemReferencesPath -SerializationTemplateKey "DeploymentSerializationReferenceTemplate"
        
        $config = Get-ScProjectConfig $ConfigPath
        $sharedSecret = $config.UnicornSharedSecret
        if(-not $sharedSecret) {
            Write-Error "You must add the UnicornSharedSecret config key to the Bob.config"
        }
        
        Sync-Unicorn "$Url/Unicorn.aspx" $sharedSecret  @()
        
        Write-Verbose "Remove $tempPath"
        rm $tempPath -Recurse
    }
}