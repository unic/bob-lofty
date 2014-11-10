$Invocation = (Get-Variable MyInvocation -Scope 1).Value
$PSScriptRoot = Split-Path $Invocation.MyCommand.Path

$paketFolder = "$PSScriptRoot\.paket"
$paketBoot = "$paketFolder\paket.bootstrapper.exe"

& $paketBoot
& "$paketFolder\paket.exe" restore
