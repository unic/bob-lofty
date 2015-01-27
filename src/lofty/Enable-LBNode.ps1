<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

#>
function Enable-LBNode
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
        [string] $Password
    )
    Process
    {
        $node = Get-LBNode $PoolName $MemberName $BigIPHostname $Username $Password
        $ctrl = Get-F5.iControl
        $ctrl.LocalLBPool.set_member_session_enabled_state($node.Pool, $node.AddressPort, "STATE_ENABLED")

    }
}
