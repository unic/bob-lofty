# Lofty - API

##  Backup-UnmanagedFiles
    Backup-UnmanagedFiles [-WebPath] <string> [-ConfigPath] <string> [<CommonParameters>]


 [Read more](Backup-UnmanagedFiles.md)
##  Backup-WebRoot
    Backup-WebRoot [-Path] <string> [[-BackupLocation] <string>] [[-BackupFileName] <string>] [<CommonParameters>]


 [Read more](Backup-WebRoot.md)
##  Copy-RubbleItem
    Copy-RubbleItem [-Path] <string> [-Destination] <string> [[-Pattern] <string[]>] [<CommonParameters>]


 [Read more](Copy-RubbleItem.md)
##  Get-RubblePattern
    Get-RubblePattern [-Pattern] <string> [[-Replacement] <hashtable>] [<CommonParameters>]


 [Read more](Get-RubblePattern.md)
##  Get-ScProjectConfig
Reads the BOB configuration files and returns it as a hashtable    
    
    Get-ScProjectConfig [[-ProjectPath] <String>] [[-ConfigFilePath] <String>] [[-ConfigFileName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]


 [Read more](Get-ScProjectConfig.md)
##  Get-ScProjectPath
    Get-ScProjectPath [[-ProjectPath] <string>] [[-ConfigFilePath] <string>] [[-ConfigFileName] <string[]>] [<CommonParameters>]


 [Read more](Get-ScProjectPath.md)
##  Install-ScSerializationPackage
Installs a Sitecore Package with Sitecore Ship    
    
    Install-ScSerializationPackage [-Path] <String> [-Url] <String> [[-DisableIndexing] <Boolean>] [[-PackageId] <String>] [[-Description] <String>] [-Publish] [[-PublishMode] <String>] [[-PublishSource] <String>] [[-PublishTargets] <String>] [[-PublishLanugages] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


 [Read more](Install-ScSerializationPackage.md)
##  Publish-ScSerializationPackage
Triggers a remote publishing job.    
    
    Publish-ScSerializationPackage [-Url] <String> [-Mode] <String> [[-Source] <String>] [[-Targets] <String>] [[-Languages] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]


 [Read more](Publish-ScSerializationPackage.md)
##  Remove-EnvironmentFiles
    Remove-EnvironmentFiles [-WebRoot] <string> [-Environment] <string> [-Role] <string> [<CommonParameters>]


 [Read more](Remove-EnvironmentFiles.md)
##  Remove-RubbleItem
    Remove-RubbleItem [-Folder] <string> [-Pattern] <string[]> [<CommonParameters>]


 [Read more](Remove-RubbleItem.md)
##  ResolvePath
    ResolvePath [[-PackageId] <Object>] [[-RelativePath] <Object>]


 [Read more](ResolvePath.md)
##  Restore-UnmanagedFiles
    Restore-UnmanagedFiles [-WebPath] <string> [-TempPath] <string> [<CommonParameters>]


 [Read more](Restore-UnmanagedFiles.md)
##  Set-ScUserConfigValue
    Set-ScUserConfigValue [-Key] <string> [-Value] <string> [[-ProjectPath] <string>] [[-ConfigFilePath] <string>] [[-ConfigFileName] <string[]>] [<CommonParameters>]


 [Read more](Set-ScUserConfigValue.md)
##  Write-RubbleArchive
    Write-RubbleArchive [-Path] <string> [-OutputLocation] <string> [<CommonParameters>]


 [Read more](Write-RubbleArchive.md)

