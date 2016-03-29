$ErrorActionPreference = 'Stop'
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
$MicroCHAP = $ScriptPath + '\MicroCHAP.dll'
Add-Type -Path $MicroCHAP

Function Sync-Unicorn {
	Param(
		[Parameter(Mandatory=$True)]
		[string]$ControlPanelUrl,

		[Parameter(Mandatory=$True)]
		[string]$SharedSecret,

		[string[]]$Configurations,

		[string]$Verb = 'Sync'
	)

	# PARSE THE URL TO REQUEST
	$parsedConfigurations = ($Configurations) -join "^"

	$url = "{0}?verb={1}&configuration={2}" -f $ControlPanelUrl, $Verb, $parsedConfigurations

	Write-Host "Sync-Unicorn: Preparing authorization for $url"

	# GET AN AUTH CHALLENGE
	$challenge = Get-Challenge -ControlPanelUrl $ControlPanelUrl

	Write-Host "Sync-Unicorn: Received challenge: $challenge"

	$signature = CreateSignature $challenge $url $SharedSecret

	Write-Host "Sync-Unicorn: Created signature $signature, executing $Verb..."

	# USING THE SIGNATURE, EXECUTE UNICORN
	$result = Invoke-WebRequest -Uri $url -Headers @{ "X-MC-MAC" = $signature; "X-MC-Nonce" = $challenge } -TimeoutSec 10800 -UseBasicParsing

	$result.Content
}

Function Get-Challenge {
	Param(
		[Parameter(Mandatory=$True)]
		[string]$ControlPanelUrl
	)

	$url = "$($ControlPanelUrl)?verb=Challenge"

	$result = Invoke-WebRequest -Uri $url -TimeoutSec 360 -UseBasicParsing

	$result.Content
}

Function CreateSignature {
    param(
        $challenge,
        $url,
        $sharedSecret
    )
    
    $uri = New-Object Uri $url
    $url = ($uri.Host + $uri.PathAndQuery).ToUpperInvariant()
    
    $signature = "$challenge|$sharedSecret|$url"
    $sha = New-Object System.Security.Cryptography.SHA512Managed
    $hash = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($signature));
    return [System.Convert]::ToBase64String($hash)
}

Export-ModuleMember -Function Sync-Unicorn