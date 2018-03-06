

# Backup-WebRoot

Backup the whole WebRoot.
## Syntax

    Backup-WebRoot [-Path] <String> [[-BackupLocation] <String>] [[-BackupFileName] <String>] [<CommonParameters>]


## Description

Backup the whole WebRoot to a ZIP file in D:\backup or a specified location.





## Parameters

    
    -Path <String>
_The folder to backup._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -BackupLocation <String>
_The folder where the backup ZIP file should be placed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false | C:\Backup | false | false |


----

    
    
    -BackupFileName <String>
_The name of the ZIP file.
If a combination of folder-name, computer name and date will be used._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    































