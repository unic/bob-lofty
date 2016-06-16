# Changelog

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
