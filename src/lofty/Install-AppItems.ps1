<#
.SYNOPSIS
Install the app items to the Sitecore website.

.DESCRIPTION
Install the app items to the Sitecore website




.EXAMPLE

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
        $tempPath = "$TempItemspath\$([Guid]::NewGuid())"
        mkdir $tempPath
        $archivePath = Resolve-Path ".\app.zip"
        Write-Verbose "Extract $archivePath to $tempPath"
        Expand-RubbleArchive $archivePath $tempPath 
        
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