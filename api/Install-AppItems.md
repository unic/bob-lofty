

# Install-AppItems

Install the app items to the Sitecore website.
## Syntax

    Install-AppItems [-Url] <String> [-ItemReferencesPath] <String> [-TempItemspath] <String> [[-ConfigPath] <String>] [[-WebRoot] <String>] [[-AppItemsZipPath] <String>] [[-GenerateSerializationConfig] <Boolean>] [<CommonParameters>]


## Description

Install the app items to the Sitecore website.
The items will be taken from the ".\app.zip".





## Parameters

    
    -Url <String>
_The url of the Sitecore website where the items should be installed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -ItemReferencesPath <String>
_The path where the items should be placed on the file system._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -TempItemspath <String>
_A path on the file system used by the command to put temporary data._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -ConfigPath <String>
_The path to the folder where the Bob.config is located._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false |  | false | false |


----

    
    
    -WebRoot <String>
_The path to the web-root of the Sitecore website._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | false |  | false | false |


----

    
    
    -AppItemsZipPath <String>
_The path to the zip file containing the serialized items._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 6 | false | .\app.zip | false | false |


----

    
    
    -GenerateSerializationConfig <Boolean>
_Switch to either generate the serialization-configfile as part of this command or not. Defaults to true._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 7 | false | True | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-AppItems -Url http://local.sitecore.com -ItemReferencesPath D:\items\appItems -TempItemsPath D:\items\temp -ConfigPath D:\packages\Sitecore.Config -WebRoot D:\Webs\sitecore































