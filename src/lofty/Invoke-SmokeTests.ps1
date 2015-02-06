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
        $phantomJsPath = "$phantomFolder\phantomjs.exe"
        if( -not ((netsh advfirewall firewall show rule name=all verbose) | ? {$_.Contains($phantomJsPath)} )) {
            Write-Verbose "Add firewall rule for $phantomJsPath"
            netsh advfirewall firewall add rule name="PhantomJS" dir=in action=allow program=$phantomJsPath
        }

        $env:UNIC_PHANTOMJS_PATH = $phantomFolder
        & "$ToolsLocation\Nunit\bin\nunit-console.exe" $TestDllPath
        $failed = $false
        if($LASTEXICODE -ne 1) {
            $failed = $true
        }

        $reportGenerator = ResolveBinPath "NUnitHTMLReportGenerator\NUnitHTMLReportGenerator.exe"
        & $reportGenerator ".\TestResult.xml" "TestResult.html"

        if($failed) {
            Write-Error "SmokeTests failed."
        }
    }
}
