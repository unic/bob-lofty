

# Upload-OfflineDeploymentPackage

It lets upload the generated offline package to Nexus. The script is based on the blog post published by Sonatype: http://www.sonatype.org/nexus/2016/04/14/uploading-artifacts-into-nexus-repository-via-powershell/.
## Syntax

    Upload-OfflineDeploymentPackage [-EndpointUrl] <String> [-Repository] <String> [-Group] <String> [-Artifact] <String> [-Version] <String> [-Packaging] <String> [-PackagePath] <String> [-Username] <String> [-Password] <String> [<CommonParameters>]


## Description

It lets upload the generated offline package to Nexus. The script is based on the blog post published by Sonatype: http://www.sonatype.org/nexus/2016/04/14/uploading-artifacts-into-nexus-repository-via-powershell/.





## Parameters

    
    -EndpointUrl <String>
_Address of your Nexus server._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Repository <String>
_Name of your repository in Nexus._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Group <String>
_Group Id._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -Artifact <String>
_The artifact name. It is a folder name put between the group and version._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    
    
    -Version <String>
_Artifact version._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | true |  | false | false |


----

    
    
    -Packaging <String>
_Packaging type (at ex. jar, war, ear, rar, etc.)._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 6 | true |  | false | false |


----

    
    
    -PackagePath <String>
_Full, literal path pointing to your Artifact._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 7 | true |  | false | false |


----

    
    
    -Username <String>
_The username to Nexus._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 8 | true |  | false | false |


----

    
    
    -Password <String>
_The password to Nexus._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 9 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Upload-OfflineDeploymentPackage -EndpointUrl "https://nexus.unic.com/nexus/service/local/artifact/maven/content" -Repository "unic-ecs-releases" -Group "LLB" -Artifact "Release" -Version "1.0" -Packaging "zip" -PackagePath "D:\MyDeployment.zip" -Username "test.username" -Password "SecurePassword"































