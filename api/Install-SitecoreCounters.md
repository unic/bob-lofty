

# Install-SitecoreCounters

Installs the specified Sitecore performance counters, and adds the IIS user to the
correct group.
## Syntax

    Install-SitecoreCounters [-Files] <String> [-AppPoolName] <String> [[-PerformanceGroup] <String>] [<CommonParameters>]


## Description

Installs the Sitecore performance counters specified in the passed XML files.
Addionally the user of the specified IIS AppPool will be added to the
Performance Monitor Users group.
The SitecoreCounter console application from https://kb.sitecore.net/articles/404548
will be used to install the counters.





## Parameters

    
    -Files <String>
_A semicolon separated list of XML file-names, containing the counters to install.
Possible files are:
- Sitecore.Analytics.Counters.xml
- Sitecore.Analytics.MongoDB.Counters.xml
- Sitecore.Automation.Counters.xml
- Sitecore.Kernel.Counters.xml_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -AppPoolName <String>
_The name of the Sitecore application pool. The application pool user will be
added to the _Performance Monitor Users_ group._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -PerformanceGroup <String>
_The name of the Performance Monitor Users group._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false | Performance Monitor Users | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-SitecoreCounters -Files "Sitecore.Analytics.Counters.xml;Sitecore.Automation.Counters.xml" `

-AppPoolName "sitecore-live"





























