$ErrorActionPreference = "Stop"

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1| Foreach-Object{ . $_.FullName }
Export-ModuleMember -Function * -Alias *

# TODO comment
function ResolvePath() {
  param($PackageId, $RelativePath)
  $paths = @("$PSScriptRoot\..\..\packages", "$PSScriptRoot\..\..\paket-files", "$PSScriptRoot\..\..\tools", "$PSScriptRoot\..\tools")
  
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

Import-Module (ResolvePath "UnicornPS" "Unicorn.psm1")
Import-Module (ResolvePath -PackageId "Unic.Bob.Wendy" -RelativePath "tools\Wendy")
Import-Module (ResolvePath -PackageId "Unic.Bob.Rubble" -RelativePath "tools\Rubble")
Import-Module (ResolvePath -PackageId "Unic.Bob.Scoop" -RelativePath "tools\Scoop")
Export-ModuleMember -Function Install-ScSerializationPackage
Export-ModuleMember -Function Set-ScSerializationReference


$WarningPreference = "SilentlyContinue"
Import-Module (ResolveBinPath "iControl\iControlSnapIn.dll")
$WarningPreference = "Continue"

$VerbosePreference = "Continue"
