<div class="chapterlogo">![Lofty](Lofty.jpg)</div>
# Lofty

Lofty is the toolset for performing deployments. Basically it is a PowerShell module which is used during deployment (i.e. installation) on the web server.


## Specify Version in Project
To secify the version of Lofty to use in a project add LoftyVersion key to Bob.config:

    <LoftyVersion>1.1.0</LoftyVersion>


## Octopus Deploy  Integration
To integrate Lofty on Octopus Deploy add a NuGet step at the beginning of the deployment process with the package "Unic.Bob.Lofty". All features of this step can be deactivated.

In further steps you can then use the following snippet to use Loftys features.

    Import-Module "$($OctopusParameters['Octopus.Action[Lofty].Output.Package.InstallationDirectoryPath'])\Lofty"

## Load balancer integration
Before using one of the `*-LB*` cmdlet, you need to connect to the load balancer. This can be achieved by running the following command:

    Initialize-F5.iControl -HostName $BigIPHostname -Username $Username -Password $Password

E.g:

    Initialize-F5.iControl -HostName unic-dev-bigip1.p.unic24.net -Username octopus -Password $Password

The urls and username of the different load balancer systems can be taken from the table below.
The passwords are stored in BU ECS password manager.

| System | Url | User |
| --- | --- | --- |
| Dev/Test LB (**Note:** this server is not always running. So you may call the BU IS so that they start it.) | https://unic-dev-bigip1.p.unic24.net | octopus |
| Prod LB | https://unic-prd-lb1.m.unic24.net | api-octopusdeploy |

In order to be able to reach this servers from your local machine you must be connected to VPN
and you may need to add some routes to the servers:
Get the index of your network interface by running `Get-NetRoute`.
There should be a lot of entries in a 172.2* network. Note down the "ifIndex"
value for this route. Then perform an nslookup for the wished system to get his IP.
You can then run the following command to add the route, where "[IP of the load balancer]" is the
nslookuped value and "[interface index]" the value you got from `Get-NetRoute`:
```
New-NetRoute -DestinationPrefix [IP of the load balancer]/32 -InterfaceIndex [interface index]
```
