<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

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
        [string] $Password
    )
    Process
    {
        if(Initialize-F5.iControl -HostName $HostName -Username $Username -Password $Password) {
            Write-Verbose "Connected to $HostName"
        }
        else {
            Write-Error "There was an error when connecting to $HostName with username $UserName"
        }
    }
}
