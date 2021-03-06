<#
.SYNOPSIS
Removes all App_Config\Include folders which don't match the current environment and role.

.DESCRIPTION
Removes all App_Config\Include folders which don't match the current environment and role.
The exact pattern of folders, which should not be deleted can be configured in **KeepAppConfigIncludes**

.PARAMETER WebRoot
The path to the WebRoot.

.PARAMETER Environment
The current envrionment.

.PARAMETER Role
The current role.


.EXAMPLE
Remove-EnvironmentFiles -WebRoot D:\webs\my -Environment dev -Role author

#>
function Remove-EnvironmentFiles
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [string] $WebRoot,
    [Parameter(Mandatory=$true)]
    [string] $Environment,
    [Parameter(Mandatory=$true)]
    [string] $Role,
    [Parameter(Mandatory=$true)]
    [string] $ConfigPath

  )
  Process
  {
    $roles = $role.Split(";")
    $config  = Get-ScProjectConfig $ConfigPath
    
    $pattern = Get-RubblePattern -Pattern $config.KeepAppConfigIncludes -Replacement @{'$Environment'= $Environment; '$Role' = $Roles }
    
    Remove-RubbleItem -Folder "$WebRoot\App_Config\Include" -Pattern $pattern
  }
}
