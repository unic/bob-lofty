$nuget = "$PSScriptRoot\nuget.exe"

if(-not (Test-Path $nuget)) {
  Invoke-WebRequest "https://nuget.org/nuget.exe" -OutFile $nuget
}

& $nuget install packages.config -o packages -ExcludeVersion
