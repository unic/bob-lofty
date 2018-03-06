

# Backup-UnmanagedFiles

Backup all unmanaged files inside a folder to a temp location.
## Syntax

    Backup-UnmanagedFiles [-WebPath] <String> [<CommonParameters>]


## Description

Backup all unmanaged files inside a folder to a temp location.
The pattern of the unmanaged files is taken from the Bob.config files.





## Parameters

    
    -WebPath <String>
_The path containing the unmanaged files._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Backup-UnmanagedFiles -WebPath D:\webs\myweb































