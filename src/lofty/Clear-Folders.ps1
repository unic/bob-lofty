<#
.SYNOPSIS
Clears the content of all folders provided.

.DESCRIPTION
Clears the content of all folders provided.

.PARAMETER Folders
A semicolon separated list of folders to delete. If the $Website is specified
relative paths must be relative to this, else from the current working
directory.

.PARAMETER Website
If specified, this is the starting point of all relative folders.

.EXAMPLE
Clear-Folders -Folders "..\relativePath;D:\data\absolute\path"

#>
function Clear-Folders
{
    [CmdletBinding()]
    Param(
        [string] $Folders,
        [string] $Website
    )
    Process
    {
        $normalFolders = $Folders.Split(";")
        if($Website) {
            Push-Location $Website
        }
        foreach($folder in $normalFolders) {
            if($folder) {
                if(Test-Path $folder) {
                    $folder = Resolve-Path $folder
                    Write-Verbose "Delete content of $folder"
                    rm "$folder\*" -Recurse
                }
            }
        }
        if($Website) {
            Pop-Location
        }
    }
}
