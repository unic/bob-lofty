<#
.SYNOPSIS
Disable anonymous authentication on sensitive directories in Sitecore.

.DESCRIPTION
Disable anonymous authentication on sensitive directories in Sitecore.

.PARAMETER SiteName
The name of the IIS site where anonymous authentication should be disabled.

.PARAMETER Paths
A list of folders where anonymous authentication should be disabled.

.EXAMPLE
Disable-ScAnonymousAuth myIISSiteName

#>
function Disable-ScAnonymousAuth
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $SiteName,
        [string[]] $Paths = @("App_Config", "sitecore/admin", "sitecore/debug", "sitecore/shell/WebService")
    )
    Process
    {
        $VerbosePreference = "SilentlyContinue"
        Import-Module WebAdministration
        $VerbosePreference = "Continue"

        foreach($path in $Paths) {
            Write-Verbose "Disable anonymous authentication on site $SiteName on path $path"
            Set-WebConfigurationProperty -Filter /system.WebServer/security/authentication/AnonymousAuthentication -PSPath IIS:\ `
                -Location "$SiteName/$path" -Name enabled -Value false

        }
    }
}
