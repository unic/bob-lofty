<#
.SYNOPSIS
Moves files and folders to specified locations.

.DESCRIPTION
Moves files and folders inside the `$BaseFolder` to specified locations.
Files and folders must be specified with a special format with the `$Actions` parameter.

.PARAMETER Actions
A list of move actions to perform:
- Each line must contain one move action
- The format of a move action is `source -> target`
- The target and source must be relativee to `$BaseFolder`

.EXAMPLE
Move-LoftyFiles -Actions "start\file -> end\file" -BaseFolder D:\example

#>
function Move-LoftyFiles
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Actions,
        [Parameter(Mandatory=$true)]
        [string] $BaseFolder
    )
    Process
    {

        $moveLines = $Actions.Split("`n")
        foreach($moveLine in $moveLines) {
            $moveLine = $moveLine.Trim()
            if($moveLine) {
                $moveLineParts = $moveLine -split "->";
                if($moveLineParts.Count -ne 2) {
                    Write-Error "Could not parse MoveFiles line: '$($moveLine)'"
                    return
                }
                $source = Join-Path $BaseFolder $moveLineParts[0].Trim()
                $target = Join-Path $BaseFolder $moveLineParts[1].Trim()
                if(Test-Path $source) {
                    Write-Verbose "Moving '$Source' to '$Target'"
                    mv $source $target -Force
                }
                else {
                    Write-Verbose "Path $source not found, nothing will be done."
                }
            }
        }
    }
}
