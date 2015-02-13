<#
.SYNOPSIS
Run smoke tests with NUnit.

.DESCRIPTION
Run smoke tests with NUnit. Before the tests are started, PhantomJS will be
configured.

.PARAMETER ToolsLocation
The location to a extracted TravisRunner package. This folder must contain a
`NUnit` and a `PhantomJS` folder.

.PARAMETER TestDllPath
The path to the DLL to test.

.EXAMPLE
Invoke-SmokeTests ../TravisRunner ./Customer.SmokeTests.dll

#>
function Invoke-SmokeTests
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $ToolsLocation,
        [Parameter(Mandatory=$true)]
        [string] $TestDllPath
    )
    Process
    {
        $phantomJsPath = "$ToolsLocation\PhantomJS\bin"
        $phantomJsExe = "$phantomJsPath\phantomjs.exe"
        if( -not ((netsh advfirewall firewall show rule name=all verbose) | ? {$_.Contains($phantomJsExe)} )) {
            Write-Verbose "Add firewall rule for $phantomJsExe"
            netsh advfirewall firewall add rule name="PhantomJS" dir=in action=allow program=$phantomJsExe
        }

        $env:UNIC_PHANTOMJS_PATH = $phantomJsPath
        & "$ToolsLocation\Nunit\bin\nunit-console.exe" $TestDllPath
        $failed = $false
        if($LASTEXITCODE -ne 0) {
            $failed = $true
        }

        $reportGenerator = ResolveBinPath "NUnitHTMLReportGenerator\NUnitHTMLReportGenerator.exe"
        & $reportGenerator ".\TestResult.xml" "TestResult.html"

        if($failed) {
            Write-Error "SmokeTests failed."
        }
    }
}
