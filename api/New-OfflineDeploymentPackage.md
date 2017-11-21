

# New-OfflineDeploymentPackage

Creates a new offline deployment package.
## Syntax

    New-OfflineDeploymentPackage [-WebsitePath] <String> [-TargetWebsitePath] <String> [-TargetAppPoolName] <String> [-PackageName] <String> [-WorkingDirectory] <String> [-TargetDirectory] <String> [[-Url] <String>] [[-ItemsPath] <String>] [[-ConfigsPath] <String>] [[-BlueprintFolderPath] <String>] [[-BackupDir] <String>] [[-TargetItemsDirectory] <String>] [[-IsDelivery] <String>] [[-Environment] <String>] [[-Role] <String>] [<CommonParameters>]


## Description

Creates a new deployment package which can then be transfered to a customer
and installed offline.





## Parameters

    
    -WebsitePath <String>
_The path to the web-root which should be packed in the offline package._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -TargetWebsitePath <String>
_The path on the offline server where the website should be deployed to._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -TargetAppPoolName <String>
_The name of the application pool on the offline server._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -PackageName <String>
_The name without extension the created ZIP file will get._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    
    
    -WorkingDirectory <String>
_The directory where New-OfflineDeploymentPackage should move files arround
and do its work._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | true |  | false | false |


----

    
    
    -TargetDirectory <String>
_The folder where the package will be put at the end of package generation
process._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 6 | true |  | false | false |


----

    
    
    -Url <String>
_The url of the Sitecore website on the target system.
This will be used on the author system to install the items._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 7 | false |  | false | false |


----

    
    
    -ItemsPath <String>
_The path to the folder containing all item packages to install._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 8 | false |  | false | false |


----

    
    
    -ConfigsPath <String>
_The path to the folder containing the configuration files._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 9 | false |  | false | false |


----

    
    
    -BlueprintFolderPath <String>
_The path to the folder containing the unmanaged files._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 10 | false |  | false | false |


----

    
    
    -BackupDir <String>
_The path to the folder where the files will be backed up before deployment._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 11 | false | C:\Backup | false | false |


----

    
    
    -TargetItemsDirectory <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 12 | false |  | false | false |


----

    
    
    -IsDelivery <String>
_Indicates whether the package will be installed on a delivery environment. It is used to decide whether the items should be installed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 13 | false |  | false | false |


----

    
    
    -Environment <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 14 | false |  | false | false |


----

    
    
    -Role <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 15 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    New-OfflineDeploymentPackage -WebsitePath D:\Website -TargetWebsitePath D:\webs\sitecore-website -TargetAppPoolName sitecore-website `

-PackageName MyPackage -WorkingDirectory D:\Temp -TargetDirectory D:\Output -Url http://author.customer.com  -ItemsPath "D:\items"





























