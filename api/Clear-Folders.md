

# Clear-Folders

Clears the content of all folders provided.
## Syntax

    Clear-Folders [[-Folders] <String>] [[-Website] <String>] [<CommonParameters>]


## Description

Clears the content of all folders provided.





## Parameters

    
    -Folders <String>
_A semicolon separated list of folders to delete. If the $Website is specified
relative paths must be relative to this, else from the current working
directory._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | false |  | false | false |


----

    
    
    -Website <String>
_If specified, this is the starting point of all relative folders._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Clear-Folders -Folders "..\relativePath;D:\data\absolute\path"































