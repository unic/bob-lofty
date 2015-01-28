<#
.SYNOPSIS
Disables a node in the load balancer and waits until connections drops to specific per-cent.

.DESCRIPTION
Disables a node in the load balancer and waits until connections on the node
falls to specific percent of the original connections. So if before disabling
the node there are 100 connections and $WaitPerCent is 0.15, Disable-LBNode
will wait until there are only 15 connections left.

.PARAMETER PoolName

.EXAMPLE

#>
function Disable-LBNode
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $PoolName,
        [Parameter(Mandatory=$true)]
        [string] $MemberName,
        [Parameter(Mandatory=$true)]
        [float] $WaitPerCent,
        [Parameter(Mandatory=$true)]
        [int] $TimeoutSeconds
    )
    Process
    {
        $node = Get-LBNode $PoolName $MemberName
        $startConnections = Get-LBNodeConnections $node.Pool $node.IPPortDefinition
        $ctrl = Get-F5.iControl
        Write-Verbose "Disable node $($node.AddressPort.Address) in pool $($node.Pool)"
        $ctrl.LocalLBPool.set_member_session_enabled_state($node.Pool, $node.AddressPort, "STATE_DISABLED")

        if($startConnections -ne 0) {
            [int]$targetConnections = $startConnections * $WaitPerCent
            Write-Verbose "Node had $startConnections connections. Waiting until they drop below $targetConnections"
            $connections = Get-LBNodeConnections $node.Pool $node.IPPortDefinition
            $startTime = Get-Date
            while($connections -gt $targetConnections -and ((Get-Date) - $startTime).Seconds -lt $TimeoutSeconds) {
                sleep -s 1
                $connections = Get-LBNodeConnections $node.Pool $node.IPPortDefinition
                Write-Verbose "There are $connections connections after waiting $(((Get-Date) - $startTime).Seconds) seconds."
            }
        }
        else {
            Write-Verbose "Node had no connections."
        }

    }
}
