

# Get-LBNode

Returns informations about a specific node in the load balancer.
## Syntax

    Get-LBNode [-PoolName] <String> [-MemberName] <String> [<CommonParameters>]


## Description

Returns informations about a specific node (pool member) in the load balancer.
The return value will be an object with the following properties:
* Pool: The full name of to pool, including the partition
* AddressPort: The iControl.CommonAddressPortDefinition object representing the node.
               This must be used in the newer iControl functions.
* IPPortDefinition: The iControl.CommonIPPortDefinition object representing the node.
                    This must be used in the older iControl functions.





## Parameters

    
    -PoolName <String>
_The name of the pool containing the node to get._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -MemberName <String>
_The name of the member to get from the load balancer._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-LBNode mypool mynode































