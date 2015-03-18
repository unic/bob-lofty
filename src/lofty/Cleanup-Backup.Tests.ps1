$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Backup-WebRoot" {
    Context "When the backups are older than seven days" {
        "" > TestDrive:\1
        "" > TestDrive:\2
        "" > TestDrive:\3
        "" > TestDrive:\4
        "" > TestDrive:\5

        function Get-Backup {
            @((New-Object PSObject -Property @{"LastWriteTime"= [datetime]"2015-03-9"; "FullName" = "TestDrive:\1"}),
            (New-Object PSObject -Property @{"LastWriteTime"= [datetime]"2015-03-10"; "FullName" = "TestDrive:\2"}),
            (New-Object PSObject -Property @{"LastWriteTime"= [datetime]"2015-03-11"; "FullName" = "TestDrive:\3"}),
            (New-Object PSObject -Property @{"LastWriteTime"= [datetime]"2015-03-12"; "FullName" = "TestDrive:\4"}),
            (New-Object PSObject -Property @{"LastWriteTime"= [datetime]"2015-03-13"; "FullName" = "TestDrive:\5"}))
        }

        Cleanup-Backup

        It "Should have delete the backups older than 7 days" {
            Test-Path TestDrive:\1 | Should Be $false
            Test-Path TestDrive:\2 | Should Be $false
            Test-Path TestDrive:\3 | Should Be $false
        }

        It "Should have kept the newer backups" {
            Test-Path TestDrive:\4 | Should Be $true
            Test-Path TestDrive:\5 | Should Be $true
        }
    }
}
