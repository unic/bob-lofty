<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

#>
function Get-Backup
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $BackupFolder
    )
    Process
    {
        ls $BackupFolder -Include *.zip
    }
}
