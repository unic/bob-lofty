

# Invoke-SmokeTests

Run smoke tests with NUnit.
## Syntax

    Invoke-SmokeTests [-ToolsLocation] <String> [-TestDllPath] <String> [<CommonParameters>]


## Description

Run smoke tests with NUnit. Before the tests are started, PhantomJS will be
configured.





## Parameters

    
    -ToolsLocation <String>
_The location to a extracted TravisRunner package. This folder must contain a
`NUnit` and a `PhantomJS` folder._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -TestDllPath <String>
_The path to the DLL to test._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Invoke-SmokeTests ../TravisRunner ./Customer.SmokeTests.dll































