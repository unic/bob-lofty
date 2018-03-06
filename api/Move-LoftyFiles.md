

# Move-LoftyFiles

Moves files and folders to specified locations.
## Syntax

    Move-LoftyFiles [-Actions] <String> [-BaseFolder] <String> [<CommonParameters>]


## Description

Moves files and folders inside the `$BaseFolder` to specified locations.
Files and folders must be specified with a special format with the `$Actions` parameter.





## Parameters

    
    -Actions <String>
_A list of move actions to perform:
- Each line must contain one move action
- The format of a move action is `source -> target`
- The target and source must be relativee to `$BaseFolder`_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -BaseFolder <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    end\file" -BaseFolder D:\example































