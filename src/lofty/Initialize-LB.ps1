<#
.SYNOPSIS
Logs in globally to the load balancer.

.DESCRIPTION
Logs in globally to the load balancer.

.PARAMETER HostName
The host name of the load balancer.

.PARAMETER Username
The username to log in at the load balancer.

.PARAMETER Password
The password to log in at the load balancer.


.EXAMPLE

#>
function Initialize-LB
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $HostName,
        [Parameter(Mandatory=$true)]
        [string] $Username,
        [Parameter(Mandatory=$true)]
        [string] $Password,
        [string] $Partition
    )
    Process
    {
        if(Initialize-F5.iControl -HostName $HostName -Username $Username -Password $Password) {
            if($Partition) {
                $ctrl = (Get-F5.iControl)
                $ctrl.ManagementPartition.set_active_partition($Partition)
            }
            Write-Verbose "Connected to $HostName"
        }
        else {
            Write-Error "There was an error when connecting to $HostName with username $UserName"
        }
    }
}
