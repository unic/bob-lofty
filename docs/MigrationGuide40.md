# Migration Guide 3.x => 4.0

As the version 4.0 introduces couple of breaking changes, it cannot be upgrade without manual changes. 
This guide shows steps which are needed to update a typical customer solution using Lofty.

All neccesarry changes needs to be done in Octopus Deploy.

## Step "Deploy Website"

Edit the step "Deploy Website". Under "Post-deployment script" you will find some PowerShell.
If the script looks like this, you can completely remove the script.
```
Import-Module $LoftyPath

Remove-EnvironmentFiles -WebRoot $WebsiteDirectory `
-Environment $Environment -Role $Role `
-ConfigPath $ConfigFolder

Install-LoftyWebConfig `
    -ConfigPath $ConfigFolder `
    -WebConfigPath "$WebsiteDirectory\Web.config" `
    -Environment $Environment `
    -Role $Role
```

If you have additional commands, the calls to `Remove-EnvironmentFiles` and `Install-LoftyWebConfig` must be deleted, 
while the rest can be kept.

## Step "Copy unmanaged files"
If the step "Copy unmanaged files" only contains a script similar to the following, you should completly delete the step.
```
cp "$BlueprintFolderPath/*" $WebsiteDirectory -Force -Recurse
```

## New Step "Install-LoftyEnvironment (Web.config, Unmanaged files,  App_Config)"
Create a new step (type: "Run a Script") directly after "Deploy Website" with the following configuration:

**Step name**

```Install-LoftyEnvironment (Web.config, Unmanaged files,  App_Config)```

**Runs on targets in roles**

```sitecore```

**Script**

```
Import-Module $LoftyPath

Install-LoftyEnvironment -WebRoot $WebsiteDirectory - Environment $Environment -Role $Role -BlueprintFolderPath $BlueprintFolderPath -ConfigFolder $ConfigFolder

```

## Step "Create offline package"
If you are using offline deployments, you need to change something in the step "Create offline package" step too.
Edit the step and under "script" add this two parameters to the call to `New-OfflineDeploymentPackage`:
```
-Environment $Environment `
-Role $Role
```

Don't forget to add a backtick (`) after the parameter ```-TargetItemsDirectory $ItemsDirectory```. 
