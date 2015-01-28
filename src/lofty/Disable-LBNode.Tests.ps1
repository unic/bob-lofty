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

        Mock Start-Sleep {} -Verifiable

        Disable-LBNode dummy dummy dummy dummy dummy 0.15 5

        It "Should have finished immediately" {
        }
    }

    Context "When connections drops by 50% every second" {
        $global:connections = 200;

        function Get-LBNodeConnections {
            $global:connections = $global:connections * 0.5
            $global:connections
        }

        Mock Sleep {} -Verifiable

        Disable-LBNode dummy dummy dummy dummy dummy 0.15 5

        It "Should take 2 seconds to fall under 15%" {
            Assert-MockCalled Start-Sleep -Times 2
        }
    }

    Context "When connections never drops" {

        function Get-LBNodeConnections {
            100
        }

        $global:sleepTime = 0
        Mock Sleep {$global:sleepTime += $Seconds * 1000 + $Milliseconds} -Verifiable
        Mock Get-Date {
            (New-Object DateTime).AddMilliseconds($global:sleepTime);
        }

        Disable-LBNode dummy dummy dummy dummy dummy 0.15 5

        It "Should have finished after 5 seconds" {
            Assert-MockCalled Start-Sleep -Times 5
        }
    }


    Context "When no connections are here" {

        function Get-LBNodeConnections {
            0
        }

        Mock Start-Sleep {} -Verifiable

        Disable-LBNode dummy dummy dummy dummy dummy 0.15 5

        It "Should have finished immidiately" {
            Assert-MockCalled Start-Sleep -Times 0
        }
    }
}
