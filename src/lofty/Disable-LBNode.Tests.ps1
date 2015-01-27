$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Disable-LBNode" {
    Context "When connections drops fast" {
        $global:firstGetStatistics = $true;

        function Get-LBNode { }
        function Get-LBNodeConnections {
            if($global:firstGetStatistics) {
                $global:firstGetStatistics = $false
                100
            }
            else {
                14
            }
        }

        $startTime = Get-Date
        Disable-LBNode dummy dummy dummy dummy dummy 0.15 5
        $endTime = Get-Date
        It "Should " {
          ($endTime - $startTime).Seconds | Should Be 0
        }
    }
}
