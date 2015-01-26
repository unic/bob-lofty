<#
.SYNOPSIS
Installs the specified Sitecore performance counters adds the IIS user to the
correct group.

.DESCRIPTION
Installs the Sitecore performance counters specified in the passed XML files.
Addionally the user of the specified IIS AppPool will be added to the
Performance Monitor Users group.

.PARAMETER Files
A semicolon separated list of XML file-names, containing the counters to install.
Possible files are:
- Sitecore.Analytics.Counters.xml
- Sitecore.Analytics.MongoDB.Counters.xml
- Sitecore.Automation.Counters.xml
- Sitecore.Kernel.Counters.xml

.PARAMETER AppPoolName
The name of the Sitecore application pool wo grant access to the Performance
Monitor counters.

.PARAMETER PerformanceGroup
The name of the Performance Monitor Users group.

.EXAMPLE
Install-SitecoreCounters -Files "Sitecore.Analytics.Counters.xml;Sitecore.Automation.Counters.xml" `
                         -AppPoolName "sitecore-live" 

#>
function Install-SitecoreCounters
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Files,
        [Parameter(Mandatory=$true)]
        [string] $AppPoolName,
        [string] $PerformanceGroup = "Performance Monitor Users"
    )
    Process
    {
        if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).
                    IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
            Write-Error "PowerShell is not running as administrator. Sitecore Counters can only be installed as administrator."
        }

        if(-not ("SitecoreCounters.Counters" -as [Type])) {
            $scCountersExe = ResolveBinPath "SitecoreCounters\SitecoreCounters.exe"
            $bytes = [System.IO.File]::ReadAllBytes($scCountersExe)
            [System.Reflection.Assembly]::Load($bytes)
        }

        $Files.Split(";") | % {$_.Trim()} | ? {$_} | % {
            $countersPath = ResolveBinPath "SitecoreCounters"
            $counter = New-Object SitecoreCounters.Counters (Join-Path $countersPath $_)
            $counter.Execute()
        }

        $VerbosePreference = "SilentlyContinue"
        Import-Module WebAdministration
        $VerbosePreference = "Continue"
        $appPool = Get-Item IIS:\AppPools\$AppPoolName

        $user = switch($appPool.processModel.identityType) {
            "NetworkService" {
                @{Name = "Network Service"; ID = "Network Service"}
            }
            "LocalService" {
                @{Name = "Local Service"; ID = "Local Service"}
            }
            "LocalSystem" {
                @{Name = "System"; ID = "System"}
            }
            "ApplicationPoolIdentity" {
                $ntAccount = New-Object System.Security.Principal.NTAccount("IIS APPPOOL\" + $appPool.Name)
                $id = $ntAccount.Translate([System.Security.Principal.SecurityIdentifier]).ToString()
                @{Name = $appPool.Name; ID = $id}
            }
            default {
                @{Name = $appPool.processModel.userName; ID = $appPool.processModel.userName}
            }
        }

        $group = [ADSI]"WinNT://./$PerformanceGroup,group"
        $members = $group.psbase.Invoke("Members")
        $isMember = $members | % {$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)} | ? {$_.ToUpper() -eq $user.Name.ToUpper()}
        if(-not $isMember) {
            Write-Verbose "Add $($user.Name) to $PerformanceGroup"
            $group.psbase.Invoke("Add",([ADSI]"WinNT://$($user.ID)").path)
        }

    }
}
