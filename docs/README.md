<div class="chapterlogo">![Lofty](Lofty.jpg)</div>
# Lofty

Lofty is the toolset for performing deployments. Basically it is a PowerShell module which is used during deployment (i.e. installation) on the web server.


## Specify Version in Project
To secify the version of Lofty to use in a project add LoftyVersion key to Bob.config:

    <LoftyVersion>0.1</LoftyVersion>


## Octopus Deploy  Integration
To integrate Lofty on Octopus Deploy add a NuGet step at the beginning of the deployment process with the package "Unic.Bob.Lofty". All features of this step can be deactivated.

In further steps you can then use the following snippet to use Loftys features.

    Import-Module "$($OctopusParameters['Octopus.Action[Lofty].Output.Package.InstallationDirectoryPath'])\Lofty"
