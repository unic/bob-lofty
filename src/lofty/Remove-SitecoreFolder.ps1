<#
.SYNOPSIS
Removes the "/sitecore" folder except the files specified with the PathsToKeep parameter.

.DESCRIPTION
Removes the "/sitecore" folder except the files specified with the PathsToKeep parameter.

.PARAMETER WebRoot
The path to the WebRoot.

.PARAMETER PathsToKeep
A list of files or folders which should not be deleted. They should be separated with a ";"

.EXAMPLE
Remove-SitecoreFolder -WebRoot D:\webs\customer-website -PathsToKeep "shell\sitecore.version.xml;shell\Applications\FXM\EmptyLayout.aspx"

#>
function Remove-SitecoreFolder
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $WebRoot,
        [Parameter(Mandatory=$true)]
        [string] $PathsToKeep
    )
    Process
    { 
        Remove-RubbleItem -Folder "$WebRoot\sitecore" -Pattern $PathsToKeep.Split(";") -Files
    }
}
