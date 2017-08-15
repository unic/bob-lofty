# Changelog

## 4.0
* Offline Deployments: Moved Web.config transformation and App_Config/Include from Splasher to install.ps1 ([SCMBOB-703](https://jira.unic.com/browse/SCMBOB-703))
* Introduced new command `Install-LoftyEnvironment` which wraps the code for App_Config, Web.config and unmanaged files management
* Added the possibility to put a file `Web.config.xdt` to the root of the blueprint folder. This file will then be applied as transformation to the Web.config ([SCMBOB-704](https://jira.unic.com/browse/SCMBOB-704))
* [Migration Guide](MigrationGuide40.md)

## 3.2
* Enhanced Install-AppItems by providing a possibility to skip the creation of the serialization config file.
* Export Set-ScSerializationReference as module cmdlet.

## 3.1
* fix items path for offline deployments
* Update to Scoop 2.5 to reduce the package size

## 3.0
* Enhanced lofty with the possibility to upload files to Nexus thanks to the `Upload-OfflineDeploymentPackage` method
* Unified the naming. The `TargetUrl` is `Url` and the `UnmanagedFilesPath` is `BlueprintFolderPath` now
* Bugfix: In offline deployment `install.bat` can now be double-clicked and doesn't need to be run with CMD.exe anymore.

## 2.3
* Fix filename generation in case of multiple roles (replace `;` with `_`)
* Improve path-length usage during offline package generation by switching from GUID to HashCode of GUID for temp folders
* Updated the theme & GitBook
* Dehardcoded the backup directory (it now defaults to c:\Backup)
* Fixed unwanted item installation on delivery servers by adding a property called `isDelivery` (defaults to `false`) to disable item installation  

## 2.2
* Added support for offline deployments

## 2.1
* Implemented removing trailing slashes in the Url variable

## 2.0
* Added support for Bob 2.0

## 1.2.2
* Removed Keith and Pester from Nuget package

## 1.2.1
* Updated dependent machines Scoop and Wendy.

## 1.2
* Enhanced output of log file in offline deployments
* Fixed small bugs with offline deployments

## 1.1
* Support for offline deployments

## 1.0
* Initital version
