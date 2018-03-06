

# Remove-EnvironmentFiles

Removes all App_Config\Include folders which don't match the current environment and role.
## Syntax

    Remove-EnvironmentFiles [-WebRoot] <String> [-Environment] <String> [-Role] <String> [-ConfigPath] <String> [<CommonParameters>]


## Description

Removes all App_Config\Include folders which don't match the current environment and role.
The exact pattern of folders, which should not be deleted can be configured in **KeepAppConfigIncludes**





## Parameters

    
    -WebRoot <String>
_The path to the WebRoot._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Environment <String>
_The current envrionment._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Role <String>
_The current role._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -ConfigPath <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Remove-EnvironmentFiles -WebRoot D:\webs\my -Environment dev -Role author































