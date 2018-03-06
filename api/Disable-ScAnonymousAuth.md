

# Disable-ScAnonymousAuth

Disable anonymous authentication on sensitive directories in Sitecore.
## Syntax

    Disable-ScAnonymousAuth [-SiteName] <String> [[-Paths] <String[]>] [<CommonParameters>]


## Description

Disable anonymous authentication on sensitive directories in Sitecore.





## Parameters

    
    -SiteName <String>
_The name of the IIS site where anonymous authentication should be disabled._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Paths <String[]>
_A list of folders where anonymous authentication should be disabled._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false | @("App_Config", "sitecore/admin", "sitecore/debug", "sitecore/shell/WebService") | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Disable-ScAnonymousAuth myIISSiteName































