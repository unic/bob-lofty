function Restore-UnamangedFiles
{
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$true)]
      [string] $WebPath,
      [Parameter(Mandatory=$true)]
      [string] $TempPath

    )
    Process
    {
        cp $TempPath\* $WebPath -Recurse -Force

        rm $TempPath -Recurse
    }
}
