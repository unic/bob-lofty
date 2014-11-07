function Remove-EnvironmentFiles
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [string] $WebRoot,
    [Parameter(Mandatory=$true)]
    [string] $Environment,
    [Parameter(Mandatory=$true)]
    [string] $Role

  )
  Process
  {
    $config  = Get-ScProjectConfig $WebRoot
    $pattern = Get-RubblePattern -Pattern $config.KeepAppConfigIncludes -Replacement @{'$Envrionemnt'= $Environment; '$Role' = $Role }

    Remove-RubbleItem -Folder "$WebRoot\App_Config\Include" -Pattern $pattern
  }
}
