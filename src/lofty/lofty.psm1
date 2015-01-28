$ErrorActionPreference = "Stop"

# TODO comment
function ResolvePath() {
  param($PackageId, $RelativePath)
  $paths = @("$PSScriptRoot\..\..\packages", "$PSScriptRoot\..\tools")
  foreach($packPath in $paths) {
    $path = Join-Path $packPath "$PackageId\$RelativePath"
    if((Test-Path $packPath) -and (Test-Path $path)) {
      Resolve-Path $path
      return
    }
  }
  Write-Error "No path found for $RelativePath in package $PackageId"
}

function ResolveBinPath() {
    param($Path)

    $paths = @("$PSScriptRoot\..\..\tools", "$PSScriptRoot\..\tools")
    foreach($toolPath in $paths ) {
        $binPath = Join-Path $toolPath $Path
        if(Test-Path $binPath) {
            Resolve-Path $binPath
            return
        }
    }

    Write-Error "No bin path found for $Path"
}

Import-Module (ResolvePath -PackageId "Unic.Bob.Config" -RelativePath "tools\BobConfig")
Import-Module (ResolvePath -PackageId "Unic.Bob.Rubble" -RelativePath "tools\Rubble")
$WarningPreference = "SilentlyContinue"
Import-Module (ResolveBinPath "iControl\iControlSnapIn.dll")
$WarningPreference = "Continue"
Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1| Foreach-Object{ . $_.FullName }
Export-ModuleMember -Function * -Alias *

$VerbosePreference = "Continue"
