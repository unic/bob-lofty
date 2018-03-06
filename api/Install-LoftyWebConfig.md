

# Install-LoftyWebConfig

Transforms all Web.*.config with the Sitecore web.config.
## Syntax

    Install-LoftyWebConfig [-ConfigPath] <String> [-WebConfigPath] <String> [-Environment] <String> [-Role] <String> [[-UnmanagedXdtFile] <String>] [<CommonParameters>]


## Description

Transforms all Web.*.config of the *.Config NuGet package
with the provided Web.config.





## Parameters

    
    -ConfigPath <String>
_The folder where the *.Config NuGet package was extracted_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -WebConfigPath <String>
_The path to the Web.config on which the transforms should be applied._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Environment <String>
_The environment for which the web-configs should be transformed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -Role <String>
_The role for which the web-configs should be transformed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    
    
    -UnmanagedXdtFile <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-LoftyWebConfig -ConfigPath D:\MyProject.Config\ -WebConfigPath D:\Web\mywebsite\Web.config -Environment dev -role delivery































