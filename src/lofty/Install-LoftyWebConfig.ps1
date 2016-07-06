<#
.SYNOPSIS
Transforms all Web.*.config with the Sitecore web.config.

.DESCRIPTION
Transforms all Web.*.config of the *.Config NuGet package
with the provided Web.config.

.PARAMETER ConfigPath
The folder where the *.Config NuGet package was extracted

.PARAMETER WebConfigPath
The path to the Web.config on which the transforms should be applied.

.PARAMETER Environment
The environment for which the web-configs should be transformed.

.PARAMETER Role
The role for which the web-configs should be transformed.

.EXAMPLE
Install-LoftyWebConfig -ConfigPath D:\MyProject.Config\ -WebConfigPath D:\Web\mywebsite\Web.config -Environment dev -role delivery

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
        [string] $Environment,
        [Parameter(Mandatory=$true)]
        [string] $role
    )
    Process
    {
        $folders = ls $ConfigPath | where {$_.PSIsContainer } | % {$_.FullName}
        
        Install-WebConfigByFolders $folders $WebConfigPath $Environment $role.Split(";")
    }
}