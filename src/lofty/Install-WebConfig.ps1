<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER 

.EXAMPLE

#>
function Install-LoftyWebConfig
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $ConfigPath,
        [Parameter(Mandatory=$true)]
        [string] $WebConfigPath,
        [Parameter(Mandatory=$true)]
        [string] $Environment = "local",
        [Parameter(Mandatory=$true)]
        [string] $role = "author"
    )
    Process
    {
        $folders = ls $ConfigPath | where {$_.PSIsContainer } | % {$_.FullName}
        
        Install-WebConfigByFolders $folders $WebConfigPath $Environment $role
    }
}