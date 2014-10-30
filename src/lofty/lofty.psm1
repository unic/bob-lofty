function ResolvePath() {
  param($PackageId, $RelativePath)
  $paths = @("$PSScriptRoot\..\..\packages", "$PSScriptRoot\..\packages")
  foreach($packPath in $paths) {
    $path = Join-Path $packPath "$PackageId\$RelativePath"
    if((Test-Path $packPath) -and (Test-Path $path)) {
      Resolve-Path $path
      return
    }
  }
  Write-Error "No path found for $RelativePath in package $PackageId"
}

Import-Module (ResolvePath "Unic.Bob.Config" "tools\BobConfig")

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1| Foreach-Object{ . $_.FullName }
Export-ModuleMember -Function * -Alias *
