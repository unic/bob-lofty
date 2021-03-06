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

.PARAMETER AppItemsZipPath
The path to the zip file containing the serialized items.

.PARAMETER GenerateSerializationConfig
Switch to either generate the serialization-configfile as part of this command or not. Defaults to true.

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
        [string] $WebRoot,
        [string] $AppItemsZipPath = ".\app.zip",
        [bool] $GenerateSerializationConfig = $true
    )
    Process
    {
        $Url = $Url.TrimEnd('/')
        
        $tempPath = "$TempItemspath\$([Guid]::NewGuid())"
        mkdir $tempPath
        $archivePath = Resolve-Path $AppItemsZipPath
        Write-Verbose "Extract $archivePath to $tempPath"
        Expand-RubbleArchive $archivePath "$tempPath\app" 
        
        if(Test-Path $ItemReferencesPath) {
            Write-Verbose "Move $ItemReferencesPath to $tempPath"
            mv $ItemReferencesPath  "$tempPath\backup"
        }
        
        Write-Verbose "Move $tempPath\app to $ItemReferencesPath"
        mv "$tempPath\app" $ItemReferencesPath
                
        if ($GenerateSerializationConfig) {
            Set-ScSerializationReference $WebRoot $ConfigPath -SerializationPath $ItemReferencesPath -SerializationTemplateKey "DeploymentSerializationReferenceTemplate"
        }

        $config = Get-ScProjectConfig $ConfigPath

        if($config.UnicornSharedSecretFile -and (Test-Path $config.UnicornSharedSecretFile)) {
            $sharedSecret = Get-Content $config.UnicornSharedSecretFile
        }

        if(-not $sharedSecret) {
            $sharedSecret = $config.UnicornSharedSecret
        }

        if(-not $sharedSecret) {
            Write-Error "You must add the UnicornSharedSecretFile or UnicornSharedSecret config key to the Bob.config"
        }
        
        # Ignore SSL check
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
        Sync-Unicorn "$Url/Unicorn.aspx" $sharedSecret  @()
        
        try  {
            Write-Verbose "Remove $tempPath"
            rm $tempPath -Recurse -Force
        }
        catch {
            Write-Warning "Could not remove $tempPath. Error: $($_.Exception.Message)"
        }
        
    }
}