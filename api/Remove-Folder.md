

# Remove-Folder

Removes the "/$PathToFolder" folder except for the files specified with the PathsToKeep parameter.
## Syntax

    Remove-Folder [-WebRoot] <String> [[-PathToFolder] <String>] [[-FilesToKeep] <String>] [<CommonParameters>]


## Description

Removes the "/$PathToFolder" folder except for the files specified with the PathsToKeep parameter.





## Parameters

    
    -WebRoot <String>
_The path to the WebRoot._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -PathToFolder <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false | sitecore | false | false |


----

    
    
    -FilesToKeep <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Remove-Folder -WebRoot D:\webs\customer-website -PathToFolder "sitecore" -PathsToKeep "shell\sitecore.version.xml;shell\Applications\FXM\EmptyLayout.aspx"































