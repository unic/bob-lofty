<#
.SYNOPSIS
Returns the number of current connections on a specific pool member.

.DESCRIPTION
Returns the number of current connections on a specific pool member.

.PARAMETER Pool
The full name of the pool containing the member.

.PARAMETER IPPortDefinition
The iControl.CommonIPPortDefinition representing the node.

.EXAMPLE
$node = Get-LBNode mynode mypool
Get-LBNodeConnections $node.Pool $node.IPPortDefinition


#>
function Get-LBNodeConnections
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Pool,
        [Parameter(Mandatory=$true)]
        [iControl.CommonIPPortDefinition] $IPPortDefinition
    )
    Process
    {
        $ctrl = (Get-F5.iControl)
        $stats = $ctrl.LocalLBPoolMember.get_statistics($Pool, $IPPortDefinition)
        ($stats.statistics.statistics | ? {$_.Type -eq "STATISTIC_SERVER_SIDE_CURRENT_CONNECTIONS"}).value.low

    }
}
