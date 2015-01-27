<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

#>
function Get-LBNode
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
        Initialize-F5.iControl -HostName $BigIPHostname -Username $Username -Password $Password

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
