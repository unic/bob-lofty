

# Publish-ScSerializationPackage

Triggers a remote publishing job.
## Syntax

    Publish-ScSerializationPackage [-Url] <String> [-Mode] <String> [[-Source] <String>] [[-Targets] <String>] [[-Languages] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


## Description

Triggers a remote publishing job with Sitecore Ship.





## Parameters

    
    -Url <String>

The Base-Url of the Sitecore Environment to install the package.





Required?  true

Position? 1

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Mode <String>

Must be one of the following values:
 - full
 - smart
 - incremental





Required?  true

Position? 2

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Source <String>

Detault is master





Required?  false

Position? 3

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Targets <String>

Default is web





Required?  false

Position? 4

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Languages <String>

Default is en





Required?  false

Position? 5

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
    Publish-ScSerializationPackage -Url http://local.post.ch































