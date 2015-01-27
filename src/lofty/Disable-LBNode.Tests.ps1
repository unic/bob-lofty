$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"



function Get-LBNode { }
function Get-F5.iControl {
    $ctrl = @{"LocalLBPool" = @{}}
    $ctrl.LocalLBPool | Add-Member ScriptMethod set_member_session_enabled_state {}
    $ctrl
}

Describe "Disable-LBNode" {
    Context "When connections drops immediately" {
        $global:firstGetStatistics = $true;

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
        It "Should have finished immediately" {
          ($endTime - $startTime).Seconds | Should Be 0
        }
    }

    Context "When connections drops by 50% every second" {
        $global:connections = 200;

        function Get-LBNodeConnections {
            $global:connections = $global:connections * 0.5
            $global:connections
        }

        $startTime = Get-Date
        Disable-LBNode dummy dummy dummy dummy dummy 0.15 5
        $endTime = Get-Date
        It "Should take 2 seconds to fall under 15%" {
          ($endTime - $startTime).Seconds | Should Be 2
        }
    }

    Context "When connections never drops" {

        function Get-LBNodeConnections {
            100
        }

        $startTime = Get-Date
        Disable-LBNode dummy dummy dummy dummy dummy 0.15 1
        $endTime = Get-Date
        It "Should have finished after 1 seconds" {
          ($endTime - $startTime).Seconds | Should Be 1
        }
    }


    Context "When no connections are here" {

        function Get-LBNodeConnections {
            0
        }

        $startTime = Get-Date
        Disable-LBNode dummy dummy dummy dummy dummy 0.15 5
        $endTime = Get-Date
        It "Should have finished immidiately" {
          ($endTime - $startTime).Seconds | Should Be 0
        }
    }
}
