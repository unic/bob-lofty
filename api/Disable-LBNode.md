

# Disable-LBNode

Disables a node in the load balancer and waits until connections drop to specific percent.
## Syntax

    Disable-LBNode [-PoolName] <String> [-MemberName] <String> [-WaitPercent] <Single> [-TimeoutSeconds] <Int32> [<CommonParameters>]


## Description

Disables a node in the load balancer and waits until connections on the node
drop to specific percent of the original connections. So if before disabling
the node there are 100 connections and $WaitPercent is 0.15, Disable-LBNode
will wait until there are less than 15 connections left.





## Parameters

    
    -PoolName <String>
_The name of the pool containing the node to disable._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -MemberName <String>
_The name of the member to disable on the load balancer._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -WaitPercent <Single>
_After disabling the node, Disable-LBNode will wait until the connections drop
to $WaitPercent of the original connections.
The percent must be specified in decimal form. So 15% is 0.15._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true | 0 | false | false |


----

    
    
    -TimeoutSeconds <Int32>
_The maximum number of seconds to wait._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true | 0 | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Disable-LBNode -PoolName mypool -MemberName mynode -WaitPercent 0.15 -TimeoutSeconds 600































