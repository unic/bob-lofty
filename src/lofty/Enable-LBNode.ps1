<#
.SYNOPSIS
Enables a node on the load balancer.

.DESCRIPTION
Enables a previously disabled node on the load balancer.

.PARAMETER PoolName
The name of the pool containing the node to enable.

.PARAMETER MemberName
The name of the member to enable on the load balancer.

.EXAMPLE

#>
function Enable-LBNode
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
        $node = Get-LBNode $PoolName $MemberName
        $ctrl = Get-F5.iControl
        $ctrl.LocalLBPool.set_member_session_enabled_state($node.Pool, $node.AddressPort, "STATE_ENABLED")

    }
}
