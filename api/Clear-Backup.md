

# Clear-Backup

Cleans up the backup directory.
## Syntax

    Clear-Backup [[-BackupLocation] <String>] [[-MaximumBackupDays] <Int32>] [[-MinimumBackups] <Int32>] [<CommonParameters>]


## Description

Cleans up the backup directory by deleting all backups older than a specific
amount of days, but by always keeping a minimum amount of backups.





## Parameters

    
    -BackupLocation <String>
_The backup folder to cleanup._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | false | C:\Backup | false | false |


----

    
    
    -MaximumBackupDays <Int32>
_The number of days to keep backups._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false | 7 | false | false |


----

    
    
    -MinimumBackups <Int32>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false | 5 | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Clear-Backup































