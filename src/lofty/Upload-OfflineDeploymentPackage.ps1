<#
.SYNOPSIS
It lets upload the generated offline package to Nexus. The script is based on the blog post published by Sonatype: http://www.sonatype.org/nexus/2016/04/14/uploading-artifacts-into-nexus-repository-via-powershell/.

.DESCRIPTION
It lets upload the generated offline package to Nexus. The script is based on the blog post published by Sonatype: http://www.sonatype.org/nexus/2016/04/14/uploading-artifacts-into-nexus-repository-via-powershell/.

.PARAMETER EndpointUrl
Address of your Nexus server.

.PARAMETER Repository
Name of your repository in Nexus.

.PARAMETER Group
Group Id.

.PARAMETER Artifact
The artifact name. It is a folder name put between the group and version.

.PARAMETER Version
Artifact version.

.PARAMETER Packaging
Packaging type (at ex. jar, war, ear, rar, etc.).

.PARAMETER PackagePath
Full, literal path pointing to your Artifact.

.PARAMETER Username
The username to Nexus.

.PARAMETER Password
The password to Nexus.

.EXAMPLE
Upload-OfflineDeploymentPackage -EndpointUrl "https://nexus.unic.com/nexus/service/local/artifact/maven/content" -Repository "unic-ecs-releases" -Group "LLB" -Artifact "Release" -Version "1.0" -Packaging "zip" -PackagePath "D:\MyDeployment.zip" -Username "test.username" -Password "SecurePassword" 

#>
function Upload-OfflineDeploymentPackage()
{
    [CmdletBinding()]
    param
    (
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$EndpointUrl,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Repository,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Group,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Artifact,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Version,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Packaging,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$PackagePath,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Username,
        [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Password
    )
    BEGIN
    {        
    }
    PROCESS
    {
        if (-not (Test-Path $PackagePath))
        {
            $errorMessage = ("Package file {0} missing or unable to read." -f $packagePath)
            $exception =  New-Object System.Exception $errorMessage
            $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, 'XLDPkgUpload', ([System.Management.Automation.ErrorCategory]::InvalidArgument), $packagePath
            $PSCmdlet.ThrowTerminatingError($errorRecord)
        }

        Add-Type -AssemblyName System.Net.Http

         # Sanitize package name: the "multiple role support" feature adds semicolons
        $PackagePath = $PackagePath.Replace(";", "_")

        $repoContent = CreateStringContent "r" $Repository
        $groupContent = CreateStringContent "g" $Group
        $versionContent = CreateStringContent "v" $Version
        $packagingContent = CreateStringContent "p" $Packaging
        $artifactContent = CreateStringContent "a" $Artifact
        $streamContent = CreateStreamContent $PackagePath

        $content = New-Object -TypeName System.Net.Http.MultipartFormDataContent
        $content.Add($repoContent)
        $content.Add($groupContent)
        $content.Add($versionContent)
        $content.Add($packagingContent)
        $content.Add($artifactContent)
        $content.Add($streamContent)

        $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $securePassword)

        $httpClientHandler = GetHttpClientHandler $Credential

        return PostArtifact $EndpointUrl $httpClientHandler $content

        
        function CreateStringContent()
        {
            param
            (
                [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Name,
                [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$Value,
                [string]$FileName,
                [string]$MediaTypeHeaderValue
            )
                $contentDispositionHeaderValue = New-Object -TypeName  System.Net.Http.Headers.ContentDispositionHeaderValue -ArgumentList @("form-data")
                $contentDispositionHeaderValue.Name = $Name

                if ($FileName)
                {
                    $contentDispositionHeaderValue.FileName = $FileName
                }

                $content = New-Object -TypeName System.Net.Http.StringContent -ArgumentList @($Value)
                $content.Headers.ContentDisposition = $contentDispositionHeaderValue

                if ($MediaTypeHeaderValue)
                {
                    $content.Headers.ContentType = New-Object -TypeName System.Net.Http.Headers.MediaTypeHeaderValue $MediaTypeHeaderValue
                }

                return $content
        }

        function CreateStreamContent()
        {
            param
            (
                [string][parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]$PackagePath
            )
                $packageFileStream = New-Object -TypeName System.IO.FileStream -ArgumentList @($PackagePath, [System.IO.FileMode]::Open)

                $contentDispositionHeaderValue = New-Object -TypeName  System.Net.Http.Headers.ContentDispositionHeaderValue "form-data"
                $contentDispositionHeaderValue.Name = "file"
                $contentDispositionHeaderValue.FileName = Split-Path $packagePath -leaf

                $streamContent = New-Object -TypeName System.Net.Http.StreamContent $packageFileStream
                $streamContent.Headers.ContentDisposition = $contentDispositionHeaderValue
                $streamContent.Headers.ContentType = New-Object -TypeName System.Net.Http.Headers.MediaTypeHeaderValue "application/octet-stream"

                return $streamContent
        }

        function GetHttpClientHandler()
        {
            param
            (
                [System.Management.Automation.PSCredential][parameter(Mandatory = $true)]$Credential
            )

            $networkCredential = New-Object -TypeName System.Net.NetworkCredential -ArgumentList @($Credential.UserName, $Credential.Password)
            $httpClientHandler = New-Object -TypeName System.Net.Http.HttpClientHandler
            $httpClientHandler.Credentials = $networkCredential

            return $httpClientHandler
        }

        function PostArtifact()
        {
            param
            (
                [string][parameter(Mandatory = $true)]$EndpointUrl,
                [System.Net.Http.HttpClientHandler][parameter(Mandatory = $true)]$Handler,
                [System.Net.Http.HttpContent][parameter(Mandatory = $true)]$Content
            )

            $httpClient = New-Object -TypeName System.Net.Http.Httpclient $Handler

            try
            {
                $response = $httpClient.PostAsync($EndpointUrl, $Content).Result

                if (!$response.IsSuccessStatusCode)
                {
                    $responseBody = $response.Content.ReadAsStringAsync().Result
                    $errorMessage = "Status code {0}. Reason {1}. Server reported the following message: {2}." -f $response.StatusCode, $response.ReasonPhrase, $responseBody

                    throw [System.Net.Http.HttpRequestException] $errorMessage
                }

                return $response.Content.ReadAsStringAsync().Result
            }
            catch [Exception]
            {
                $PSCmdlet.ThrowTerminatingError($_)
            }
            finally
            {
                if($null -ne $httpClient)
                {
                    $httpClient.Dispose()
                }

                if($null -ne $response)
                {
                    $response.Dispose()
                }
            }
        }
    }
    END { }
}