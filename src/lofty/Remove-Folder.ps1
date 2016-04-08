<#
.SYNOPSIS
Removes the "/$PathToFolder" folder except for the files specified with the PathsToKeep parameter.

.DESCRIPTION
Removes the "/$PathToFolder" folder except for the files specified with the PathsToKeep parameter.

.PARAMETER WebRoot
The path to the WebRoot.

.PARAMETER PathsToKeep
A list of files or folders which should not be deleted. They should be separated with a ";"

.EXAMPLE
Remove-Folder -WebRoot D:\webs\customer-website -PathToFolder "sitecore" -PathsToKeep "shell\sitecore.version.xml;shell\Applications\FXM\EmptyLayout.aspx"

#>
function Remove-Folder 
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $WebRoot,
        [string] $PathToFolder = "sitecore",
        [string] $FilesToKeep
    )
    Process
    { 
        $folder = "$WebRoot\$PathToFolder"
        write-host $folder
        if($FilesToKeep) {
            Remove-RubbleItem -Folder $folder -Pattern $FilesToKeep.Split(";") -Files
        }
        else {
            rm $folder -Recurse
        }
    }
}
