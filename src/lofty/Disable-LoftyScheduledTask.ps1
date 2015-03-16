<#
.SYNOPSIS
Sets the status of windows scheduled tasks.

.DESCRIPTION
Enables or disables a set of windows scheduled tasks.

.PARAMETER Tasks
A list of windows scheduled tasks. Each task must be separated by a line break.

.PARAMETER Enabled
If $true it will enable the specified tasks, else it will disable them.

.EXAMPLE
Set-LoftyTasksEnabled -Tasks "Task1" -Enabled:$false

#>
function Set-LoftyTasksEnabled
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Tasks,
        [switch] $Enabled = $True
    )
    Process
    {
        ($TaskScheduler = New-Object -ComObject Schedule.Service).Connect("localhost")
        $tasksArray = $Tasks.Split("`n")
        foreach($task in $tasksArray) {
            $task = $task.Trim()
            if($task) {
                 $myTask = $TaskScheduler.GetFolder('\').GetTask($task)
                 $myTask.Enabled = $Enabled
            }
        }
    }
}
