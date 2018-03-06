

# New-ScSerializationPackage

Builds a Sitecore Update packages automatically with the help of Sitecore Courier, by analyzing two Sitecore packages and packaging only changed items.
## Syntax

    New-ScSerializationPackage [-Source] <String> [-Target] <String> [-OutputFile] <String> [[-CollisionMode] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


## Description

Builds a Sitecore Update packages automatically with the help of Sitecore Courier, by analyzing two Sitecore packages and packaging only changed items.





## Parameters

    
    -Source <String>
_Path, which should point to the baseline serialization folder (this is the older version of the serialized item tree). If this path points to an empty folder, an update package with all serialized items in the target folder will be generated
The path must be either absolute or relative to the current working directory._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Target <String>
_Path, which should point to the latest (target) version of the serialized folder.
The path must be either absolute or relative to the current working directory._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -OutputFile <String>
_The file wheree the Update Package should be written to_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -CollisionMode <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false | Undefined | false | false |


----

    
    
    -WhatIf <SwitchParameter>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false |  | false | false |


----

    
    
    -Confirm <SwitchParameter>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-ScSerializationPackage -Source D:\sourceSerialization -Target D:\targetSerialization -OutputFile D:\package.update































