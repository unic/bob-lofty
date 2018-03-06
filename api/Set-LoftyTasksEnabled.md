

# Set-LoftyTasksEnabled

Sets the status of windows scheduled tasks.
## Syntax

    Set-LoftyTasksEnabled [-Tasks] <String> [-Enabled] [<CommonParameters>]


## Description

Enables or disables a set of windows scheduled tasks.





## Parameters

    
    -Tasks <String>
_A list of windows scheduled tasks. Each task must be separated by a line break._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Enabled <SwitchParameter>
_If $true it will enable the specified tasks, else it will disable them._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false | True | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Set-LoftyTasksEnabled -Tasks "Task1" -Enabled:$false































