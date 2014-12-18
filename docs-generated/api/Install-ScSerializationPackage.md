

# Install-ScSerializationPackage

Installs a Sitecore Package with Sitecore Ship
## Syntax

    Install-ScSerializationPackage [-Path] <String> [-Url] <String> [[-DisableIndexing] <Boolean>] [[-PackageId] <String>] [[-Description] <String>] [-Publish] [[-PublishMode] <String>] [[-PublishSource] <String>] [[-PublishTargets] <String>] [[-PublishLanugages] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


## Description

This command can be used to install a Sitecore package with the help of Sitecore Ship by specifying the location of an update package file to upload to the server. Optionaly a Publish job will be triggered after the installation.





## Parameters

    
    -Path <String>

The Path to the Sitecore update pacakge





Required?  true

Position? 1

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Url <String>

The Base-Url of the Sitecore Environment to install the package.





Required?  true

Position? 2

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -DisableIndexing <Boolean>

Required?  false

Position? 3

Default value? False

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -PackageId <String>

If recordInstallationHistory  is enabled you have to provide this parameter.





Required?  false

Position? 4

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Description <String>

If recordInstallationHistory  is enabled you have to provide this parameter.





Required?  false

Position? 5

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Publish <SwitchParameter>

If this switch is added a publish jobb will be triggered after the package install





Required?  false

Position? named

Default value? False

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -PublishMode <String>

Must be one of the following values:
 - full
 - smart
 - incremental





Required?  false

Position? 6

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -PublishSource <String>

Detault is master





Required?  false

Position? 7

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -PublishTargets <String>

Default is web





Required?  false

Position? 8

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -PublishLanugages <String>

Default is en





Required?  false

Position? 9

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -WhatIf <SwitchParameter>

Required?  false

Position? named

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Confirm <SwitchParameter>

Required?  false

Position? named

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-ScSerializationPackage -Path D:\Deployment\64-items.update -Url http://local.post.ch































