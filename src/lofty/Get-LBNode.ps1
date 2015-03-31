<#
.SYNOPSIS
Returns informations about a specific node in the load balancer.

.DESCRIPTION
Returns informations about a specific node (pool member) in the load balancer.
The return value will be an object with the following properties:
* Pool: The full name of to pool, including the partition
* AddressPort: The iControl.CommonAddressPortDefinition object representing the node.
               This must be used in the newer iControl functions.
* IPPortDefinition: The iControl.CommonIPPortDefinition object representing the node.
                    This must be used in the older iControl functions.

.PARAMETER PoolName
The name of the pool containing the node to get.

.PARAMETER MemberName
The name of the member to get from the load balancer.

.EXAMPLE
Get-LBNode mypool mynode

#>
function Get-LBNode
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $PoolName,
        [Parameter(Mandatory=$true)]
        [string] $MemberName
    )
    Process
    {
        $ctrl = (Get-F5.iControl)
        $pools = $ctrl.LocalLBPool.get_list() | ? {$_ -like "/*/$PoolName"}

        if(-not $pools) {
            Write-Error "No pools found with the name '$PoolName'"
        }
        if($pools.Count -and $pools.Count -gt 1) {
            Write-Error "More than one pool with name '$PoolName' found: $pools"
        }

        $pool = $pools

        $members = $ctrl.LocalLBPool.get_member_v2($pool) | % {$_ | ? {$_.address -like "/*/$MemberName"}}
        if(-not $members) {
            Write-Error "No member found with the name '$MemberName' in the pool $Pool"
        }

        if($members.Count -and $members.Count -gt 1) {
            Write-Error "Multiple members found with the name '$MemberName' in the pool ${Pool}: $members"
        }

        $member = $members

        $ipPort = New-Object iControl.CommonIPPortDefinition
        $ipPort.address = $ctrl.LocalLBPooL.get_member_address($pool, $member)[0]
        $ipPort.port = $member.port

        @{"Pool"= $pool;"AddressPort" = $member; "IPPortDefinition" = $ipPort}
    }
}
