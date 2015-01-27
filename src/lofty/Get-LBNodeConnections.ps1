<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

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
