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
        $connectionPerCent = 100
        while($connectionPerCent -gt $WaitPerCent) {
            $connections = Get-LBNodeConnections $node.Pool $node.IPPortDefinition
            $connectionPerCent = $connections / $startConnections
            Write-Host ($WaitPerCent)
            sleep -s 1
        }
        $startConnections
        #$ctrl.LocalLBPool.set_member_session_enabled_state($pool, $member, "STATE_DISABLED")
    }
}
