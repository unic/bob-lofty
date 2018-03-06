

# Install-LoftyEnvironment

Installs a Sitecore environment by applying role and environment specific configuration.
## Syntax

    Install-LoftyEnvironment [-WebRoot] <String> [-Environment] <String> [-Role] <String> [-BlueprintFolderPath] <String> [-ConfigFolder] <String> [[-UnmanagedXdtFile] <String>] [<CommonParameters>]


## Description

Installs a Sitecore environment by applying role and environment specific configuration.
This cmdlet expects an already prepared web-root (Sitecore and Customer files).
It then applies environment, role and server specific configuration by performing this tasks:
- Remove all files in App_Config/Include which don't match the current context.
- Copy all files from the blueprint folder to the web-root
- Apply web.config transformations





## Parameters

    
    -WebRoot <String>
_Path to the already prepared web-root_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Environment <String>
_The environment name of the instance to install._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Role <String>
_The role name of the instance to install._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -BlueprintFolderPath <String>
_The path to the blueprint folder._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    
    
    -ConfigFolder <String>
_The path the configuration folder, which is used for Bob.config and the Web.*.config transformation files._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | true |  | false | false |


----

    
    
    -UnmanagedXdtFile <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 6 | false | "$WebRoot\Web.config.xdt" | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-LoftyEnvironment -WebRoot C:\Web\Sitecore - Environment prod -Role author -BlueprintFolderPath C:\Data\template -ConfigFolder C:\Installation\Config































