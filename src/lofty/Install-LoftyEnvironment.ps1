<#
.SYNOPSIS
Installs a Sitecore environemnt by applying role and environemnt specific configuration.

.DESCRIPTION
Installs a Sitecore environemnt by applying role and environemnt specific configuration.
This cmdlet expects a already prepared web-root (Sitecore and Customer files).
In then applies environemnt, role and server specific configuration by performing this tasks:
- Remove all files in App_Config/Include which doesn't match the current context.
- Copy all files from the blueprint folder to the web-root
- Apply web.config transformations

.PARAMETER WebRoot
Path to the already prepared web-root

.PARAMETER Environment
The environemnt name of the instance to install.

.PARAMETER Role
The role name of the instance to install.

.PARAMETER BlueprintFolderPath
The path to the blueprint folder.

.PARAMETER ConfigFolder
The path the configuration folder, which is used for Bob.config and the Web.*.config transformation files.

.EXAMPLE
Install-LoftyEnvironment -WebRoot C:\Web\Sitecore - Environment prod -Role author -BlueprintFolderPath C:\Data\template -ConfigFolder C:\Installation\Config

#>
function Install-LoftyEnvironment {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $WebRoot,
        [Parameter(Mandatory=$true)]
        [string] $Environment,
        [Parameter(Mandatory=$true)]
        [string] $Role,
        [Parameter(Mandatory=$true)]
        [string] $BlueprintFolderPath,
        [Parameter(Mandatory=$true)]
        [string] $ConfigFolder
    )
    Process
    {
        Remove-EnvironmentFiles -WebRoot $WebRoot `
            -Environment $Environment -Role $Role `
            -ConfigPath $configFolder

        if($blueprintFolderPath) {
            Write-Output "Restore unmanaged files from $blueprintFolderPath to $WebRoot"
            cp  "$blueprintFolderPath\*" "$WebRoot\" -Recurse -Force
        }

        $unmanagedXdtFile = "$WebRoot\Web.config.xdt"

        Install-LoftyWebConfig `
            -ConfigPath $configFolder `
            -WebConfigPath "$WebRoot\Web.config" `
            -Environment $Environment `
            -Role $Role `
            -UnmanagedXdtFile $unmanagedXdtFile

        if(Test-Path $unmanagedXdtFile) {
            rm $unmanagedXdtFile
        } 
    }
        
}