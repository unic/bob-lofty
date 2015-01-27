<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

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
        [string] $BigIPHostname,
        [Parameter(Mandatory=$true)]
        [string] $Username,
        [Parameter(Mandatory=$true)]
        [string] $Password,
        [Parameter(Mandatory=$true)]
        [float] $WaitPerCent,
        [Parameter(Mandatory=$true)]
        [int] $TimeoutSeconds
    )
    Process
    {
        $node = Get-LBNode $PoolName $MemberName $BigIPHostname $Username $Password
        $startConnections = Get-LBNodeConnections $node.Pool $node.IPPortDefinition
        $ctrl = Get-F5.iControl
        $ctrl.LocalLBPool.set_member_session_enabled_state($node.Pool, $node.AddressPort, "STATE_DISABLED")

        if($startConnections -ne 0) {
            $connections = Get-LBNodeConnections $node.Pool $node.IPPortDefinition
            $connectionPerCent = $connections / $startConnections
            $startTime = Get-Date
            while($connectionPerCent -gt $WaitPerCent -and ((Get-Date) - $startTime).Seconds -lt $TimeoutSeconds) {
                sleep -s 1
                $connections = Get-LBNodeConnections $node.Pool $node.IPPortDefinition
                $connectionPerCent = $connections / $startConnections
            }
        }

    }
}
