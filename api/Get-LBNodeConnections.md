

# Get-LBNodeConnections

Returns the number of current connections on a specific pool member.
## Syntax

    Get-LBNodeConnections [-Pool] <String> [-IPPortDefinition] <CommonIPPortDefinition> [<CommonParameters>]


## Description

Returns the number of current connections on a specific pool member.





## Parameters

    
    -Pool <String>
_The full name of the pool containing the member._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -IPPortDefinition <CommonIPPortDefinition>
_The iControl.CommonIPPortDefinition representing the node._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    $node = Get-LBNode mynode mypool

Get-LBNodeConnections $node.Pool $node.IPPortDefinition





























