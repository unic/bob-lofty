# Lofty - API

##  Backup-UnmanagedFiles
Backup all unmanaged files inside a folder to a temp location.    
    
    Backup-UnmanagedFiles [-WebPath] <String> [<CommonParameters>]


 [Read more](Backup-UnmanagedFiles.md)
##  Backup-WebRoot
Backup the whole WebRoot.    
    
    Backup-WebRoot [-Path] <String> [[-BackupLocation] <String>] [[-BackupFileName] <String>] [<CommonParameters>]


 [Read more](Backup-WebRoot.md)
##  Clear-Backup
Cleans up the backup directory.    
    
    Clear-Backup [[-BackupLocation] <String>] [[-MaximumBackupDays] <Int32>] [[-MinimumBackups] <Int32>] [<CommonParameters>]


 [Read more](Clear-Backup.md)
##  Clear-Folders
Clears the content of all folders provided.    
    
    Clear-Folders [[-Folders] <String>] [[-Website] <String>] [<CommonParameters>]


 [Read more](Clear-Folders.md)
##  Disable-LBNode
Disables a node in the load balancer and waits until connections drop to specific percent.    
    
    Disable-LBNode [-PoolName] <String> [-MemberName] <String> [-WaitPercent] <Single> [-TimeoutSeconds] <Int32> [<CommonParameters>]


 [Read more](Disable-LBNode.md)
##  Disable-ScAnonymousAuth
Disable anonymous authentication on sensitive directories in Sitecore.    
    
    Disable-ScAnonymousAuth [-SiteName] <String> [[-Paths] <String[]>] [<CommonParameters>]


 [Read more](Disable-ScAnonymousAuth.md)
##  Enable-LBNode
Enables a node on the load balancer.    
    
    Enable-LBNode [-PoolName] <String> [-MemberName] <String> [<CommonParameters>]


 [Read more](Enable-LBNode.md)
##  Get-Backup
Get all backup files in a specific folder.    
    
    Get-Backup [-BackupLocation] <String> [<CommonParameters>]


 [Read more](Get-Backup.md)
##  Get-LBNode
Returns informations about a specific node in the load balancer.    
    
    Get-LBNode [-PoolName] <String> [-MemberName] <String> [<CommonParameters>]


 [Read more](Get-LBNode.md)
##  Get-LBNodeConnections
Returns the number of current connections on a specific pool member.    
    
    Get-LBNodeConnections [-Pool] <String> [-IPPortDefinition] <CommonIPPortDefinition> [<CommonParameters>]


 [Read more](Get-LBNodeConnections.md)
##  Initialize-LB
Logs in globally to the load balancer.    
    
    Initialize-LB [-HostName] <String> [-Username] <String> [-Password] <String> [[-Partition] <String>] [<CommonParameters>]


 [Read more](Initialize-LB.md)
##  Install-AppItems
Install the app items to the Sitecore website.    
    
    Install-AppItems [-Url] <String> [-ItemReferencesPath] <String> [-TempItemspath] <String> [[-ConfigPath] <String>] [[-WebRoot] <String>] [[-AppItemsZipPath] <String>] [[-GenerateSerializationConfig] <Boolean>] [<CommonParameters>]


 [Read more](Install-AppItems.md)
##  Install-DefaultItems
Install the default items to the Sitecore website.    
    
    Install-DefaultItems [-Url] <String> [-ItemReferencesPath] <String> [-TempItemspath] <String> [[-DefaultItemsZipPath] <String>] [<CommonParameters>]


 [Read more](Install-DefaultItems.md)
##  Install-LoftyEnvironment
Installs a Sitecore environment by applying role and environment specific configuration.    
    
    Install-LoftyEnvironment [-WebRoot] <String> [-Environment] <String> [-Role] <String> [-BlueprintFolderPath] <String> [-ConfigFolder] <String> [[-UnmanagedXdtFile] <String>] [<CommonParameters>]


 [Read more](Install-LoftyEnvironment.md)
##  Install-LoftyWebConfig
Transforms all Web.*.config with the Sitecore web.config.    
    
    Install-LoftyWebConfig [-ConfigPath] <String> [-WebConfigPath] <String> [-Environment] <String> [-Role] <String> [[-UnmanagedXdtFile] <String>] [<CommonParameters>]


 [Read more](Install-LoftyWebConfig.md)
##  Install-ScSerializationPackage
Installs a Sitecore Package with Sitecore Ship    
    
    Install-ScSerializationPackage [-Path] <String> [-Url] <String> [[-DisableIndexing] <Boolean>] [[-PackageId] <String>] [[-Description] <String>] [-Publish] [[-PublishMode] <String>] [[-PublishSource] <String>] [[-PublishTargets] <String>] [[-PublishLanugages] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


 [Read more](Install-ScSerializationPackage.md)
##  Install-SitecoreCounters
Installs the specified Sitecore performance counters, and adds the IIS user to the
correct group.    
    
    Install-SitecoreCounters [-Files] <String> [-AppPoolName] <String> [[-PerformanceGroup] <String>] [<CommonParameters>]


 [Read more](Install-SitecoreCounters.md)
##  Invoke-SmokeTests
Run smoke tests with NUnit.    
    
    Invoke-SmokeTests [-ToolsLocation] <String> [-TestDllPath] <String> [<CommonParameters>]


 [Read more](Invoke-SmokeTests.md)
##  Move-LoftyFiles
Moves files and folders to specified locations.    
    
    Move-LoftyFiles [-Actions] <String> [-BaseFolder] <String> [<CommonParameters>]


 [Read more](Move-LoftyFiles.md)
##  New-OfflineDeploymentPackage
Creates a new offline deployment package.    
    
    New-OfflineDeploymentPackage [-WebsitePath] <String> [-TargetWebsitePath] <String> [-TargetAppPoolName] <String> [-PackageName] <String> [-WorkingDirectory] <String> [-TargetDirectory] <String> [[-Url] <String>] [[-ItemsPath] <String>] [[-ConfigsPath] <String>] [[-BlueprintFolderPath] <String>] [[-BackupDir] <String>] [[-TargetItemsDirectory] <String>] [[-IsDelivery] <String>] [[-Environment] <String>] [[-Role] <String>] [<CommonParameters>]


 [Read more](New-OfflineDeploymentPackage.md)
##  New-ScSerializationPackage
Builds a Sitecore Update packages automatically with the help of Sitecore Courier, by analyzing two Sitecore packages and packaging only changed items.    
    
    New-ScSerializationPackage [-Source] <String> [-Target] <String> [-OutputFile] <String> [[-CollisionMode] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


 [Read more](New-ScSerializationPackage.md)
##  Remove-EnvironmentFiles
Removes all App_Config\Include folders which don't match the current environment and role.    
    
    Remove-EnvironmentFiles [-WebRoot] <String> [-Environment] <String> [-Role] <String> [-ConfigPath] <String> [<CommonParameters>]


 [Read more](Remove-EnvironmentFiles.md)
##  Remove-Folder
Removes the "/$PathToFolder" folder except for the files specified with the PathsToKeep parameter.    
    
    Remove-Folder [-WebRoot] <String> [[-PathToFolder] <String>] [[-FilesToKeep] <String>] [<CommonParameters>]


 [Read more](Remove-Folder.md)
##  Restore-UnmanagedFiles
Restore all unmanaged files backed-up by `Backup-UnmanagedFiles` before.    
    
    Restore-UnmanagedFiles [-WebPath] <String> [-TempPath] <String> [-ConfigPath] <String> [<CommonParameters>]


 [Read more](Restore-UnmanagedFiles.md)
##  Set-LoftyTasksEnabled
Sets the status of windows scheduled tasks.    
    
    Set-LoftyTasksEnabled [-Tasks] <String> [-Enabled] [<CommonParameters>]


 [Read more](Set-LoftyTasksEnabled.md)
##  Set-ScSerializationReference
Sets the SerializationReference path of the current project.    
    
    Set-ScSerializationReference [[-WebPath] <String>] [[-ProjectPath] <String>] [[-SerializationPath] <String>] [[-SerializationTemplateKey] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


 [Read more](Set-ScSerializationReference.md)
##  Upload-OfflineDeploymentPackage
It lets upload the generated offline package to Nexus. The script is based on the blog post published by Sonatype: http://www.sonatype.org/nexus/2016/04/14/uploading-artifacts-into-nexus-repository-via-powershell/.    
    
    Upload-OfflineDeploymentPackage [-EndpointUrl] <String> [-Repository] <String> [-Group] <String> [-Artifact] <String> [-Version] <String> [-Packaging] <String> [-PackagePath] <String> [-Username] <String> [-Password] <String> [<CommonParameters>]


 [Read more](Upload-OfflineDeploymentPackage.md)

