

# Install-DefaultItems

Install the default items to the Sitecore website.
## Syntax

    Install-DefaultItems [-Url] <String> [-ItemReferencesPath] <String> [-TempItemspath] <String> [[-DefaultItemsZipPath] <String>] [<CommonParameters>]


## Description

Install the default items to the Sitecore website.
The items will be taken from the ".\appDefault.zip"





## Parameters

    
    -Url <String>
_The url of the Sitecore website where the items should be installed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -ItemReferencesPath <String>
_The path on the file system to the folder, where the items are located 
which were installed during the last deployment. 
Note that this command will copy all installed items to this location when the items were installed_

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

    
    
    -DefaultItemsZipPath <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false | .\appDefault.zip | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-DefaultItems































