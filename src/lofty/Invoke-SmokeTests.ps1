<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

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
        $phantomFolder = "$ToolsLocation\PhantomJS\bin"
        $phantomJsExe = "$phantomFolder\phantomjs.exe"
        if( -not ((netsh advfirewall firewall show rule name=all verbose) | ? {$_.Contains($phantomJsExe)} )) {
            Write-Verbose "Add firewall rule for $phantomJsExe"
            netsh advfirewall firewall add rule name="PhantomJS" dir=in action=allow program=$phantomJsExe
        }

        $env:UNIC_PHANTOMJS_PATH = $phantomFolder
        & "$ToolsLocation\Nunit\bin\nunit-console.exe" $TestDllPath
        $failed = $false
        if($$LASTEXITCODE -ne 0) {
            $failed = $true
        }

        $reportGenerator = ResolveBinPath "NUnitHTMLReportGenerator\NUnitHTMLReportGenerator.exe"
        & $reportGenerator ".\TestResult.xml" "TestResult.html"

        if($failed) {
            Write-Error "SmokeTests failed."
        }
    }
}
