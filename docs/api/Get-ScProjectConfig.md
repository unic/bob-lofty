

# Get-ScProjectConfig

Reads the BOB configuration files and returns it as a hashtable
## Syntax

    Get-ScProjectConfig [[-ProjectPath] <String>] [[-ConfigFilePath] <String>] [[-ConfigFileName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]


## Description

Reads the BOB configuration files and returns it as a hashtable
Per default the config file is taken from the App_Config/Bob.config file in the current Visual Studio project. If there is a App_Config/Bob.config.user values will be overriden.





## Parameters

    
    -ProjectPath <String>

The path of the project for which the config shoud be readed.





Required?  false

Position? 1

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -ConfigFilePath <String>

The folder in which the config file is located. The path must be relative to the project path.





Required?  false

Position? 2

Default value? App_Config

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -ConfigFileName <String[]>

The names of the config files





Required?  false

Position? 3

Default value? @("Bob.config", "Bob.config.user")

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -WhatIf <SwitchParameter>

Required?  false

Position? named

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Confirm <SwitchParameter>

Required?  false

Position? named

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-ScProjectConfig






























### -------------------------- EXAMPLE 2 --------------------------
    Get-ScProjectConfig -ProjectPath D:\projects\Spider\src\Spider.Website































