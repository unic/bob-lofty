<div class="chapterlogo"><img src="./Lofty.jpg" /></div>

# Lofty

Lofty is the toolset for performing deployments. Basically it is a PowerShell module which is used during deployment (i.e. installation) on the web server.


## Specify Version in Project
To secify the version of Lofty to use in a project add LoftyVersion key to Bob.config:

    <LoftyVersion>1.1.0</LoftyVersion>


## Octopus Deploy  Integration
To integrate Lofty on Octopus Deploy add a NuGet step at the beginning of the deployment process with the package "Unic.Bob.Lofty". All features of this step can be deactivated.

In further steps you can then use the following snippet to use Loftys features.

    Import-Module "$($OctopusParameters['Octopus.Action[Lofty].Output.Package.InstallationDirectoryPath'])\Lofty"

## Nexus Integration

To integrate Lofty with Nexus and upload the zip file generated during the offline deployment use the following Powershell command. Remember to adjust the parameters to your needs.

    $releaseNumber = $OctopusParameters['Octopus.Release.Number']
    Upload-OfflineDeploymentPackage `
    -EndpointUrl $NexusEndpointUrl `
    -Repository $NexusRepository `
    -Group $NexusGroup `
    -Artifact $NexusArtifact `
    -Version $releaseNumber `
    -Packaging $NexusPackaging `
    -PackagePath "$OfflinePackageTargetDirectory\$Environment.$Role.$releaseNumber.zip" `
    -Username $NexusUsername `
    -Password $NexusPassword

To get the latest package from Nexus with curl use the following statement:

    curl –u [username]:[password] –L https://<host>/nexus/service/local/artifact/maven/redirect?r=<repository>&g=<group>&a=<artifact>&e=zip&v=LATEST

where `r` represents the repository name, `g` is a group, `a` is an artifact, `e` extension and `v=LATEST` instructs nexus to grab for the latest version. Remember to replace the [username] and [password] with valid credentials.

## Load balancer integration

Before using one of the `*-LB*` cmdlet, you need to connect to the load balancer. This can be achieved by running the following command:

    Initialize-F5.iControl -HostName $BigIPHostname -Username $Username -Password $Password
