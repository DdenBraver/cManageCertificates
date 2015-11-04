#------------------------------
# The Get-TargetResource cmdlet
#------------------------------
FUNCTION Get-TargetResource
{
	param
	(
        [parameter(Mandatory)]
        [ValidateNotNull()]
		[System.String]
		$Thumbprint,

	    [parameter(Mandatory)]
        [ValidateNotNull()]
		[System.String]
		$Location,

        [ValidateSet('CurrentUser', 'LocalMachine')]
		[System.String]
		$StoreType = 'LocalMachine',

        [ValidateSet('TrustedPublisher', 'ClientAuthIssuer', 'Remote Desktop', 'Root', 'TrustedDevices', 'WebHosting', 'CA', 'AuthRoot', 'TrustedPeople', 'My', 'SmartCardRoot', 'Trust', 'Disallowed')]
		[System.String]
		$Store = 'My',

	    [parameter(Mandatory)]
        [System.Management.Automation.PSCredential]
        $Password,

        [ValidateSet('Present', 'Absent')]
		[System.String]
		$Ensure = 'Present',

		[System.Boolean]
		$Reboot = $false
	)
    
    Get-ChildItem -Path "Cert:\$Storetype\$Store" | Where-Object {$_.Thumbprint -eq $thumbprint}
}

#------------------------------
# The Set-TargetResource cmdlet
#------------------------------
FUNCTION Set-TargetResource
{
	param
	(
        [parameter(Mandatory)]
        [ValidateNotNull()]
		[System.String]
		$Thumbprint,

	    [parameter(Mandatory)]
        [ValidateNotNull()]
		[System.String]
		$Location,

        [ValidateSet('CurrentUser', 'LocalMachine')]
		[System.String]
		$StoreType = 'LocalMachine',

        [ValidateSet('TrustedPublisher', 'ClientAuthIssuer', 'Remote Desktop', 'Root', 'TrustedDevices', 'WebHosting', 'CA', 'AuthRoot', 'TrustedPeople', 'My', 'SmartCardRoot', 'Trust', 'Disallowed')]
		[System.String]
		$Store = 'My',

	    [parameter(Mandatory)]
        [System.Management.Automation.PSCredential]
        $Password,

        [ValidateSet('Present', 'Absent')]
		[System.String]
		$Ensure = 'Present',

		[System.Boolean]
		$Reboot = $false
	)

    # ----------------
    # ENSURE = PRESENT
    if ($Ensure -ieq 'Present')
    {
        Import-PfxCertificate -CertStoreLocation "Cert:\$StoreType\$Store" -FilePath $Location -Password $Password.Password
    }

    # ---------------
    # ENSURE = ABSENT
    elseif ($Ensure -ieq 'Absent')
    {
        Get-ChildItem -Path "Cert:\$Storetype\$Store" | Where-Object {$_.Thumbprint -eq $thumbprint} | Remove-Item -Force
    }
}


#-------------------------------
# The Test-TargetResource cmdlet
#-------------------------------

FUNCTION Test-TargetResource
{
	param
	(
        [parameter(Mandatory)]
        [ValidateNotNull()]
		[System.String]
		$Thumbprint,

	    [parameter(Mandatory)]
        [ValidateNotNull()]
		[System.String]
		$Location,

        [ValidateSet('CurrentUser', 'LocalMachine')]
		[System.String]
		$StoreType = 'LocalMachine',

        [ValidateSet('TrustedPublisher', 'ClientAuthIssuer', 'Remote Desktop', 'Root', 'TrustedDevices', 'WebHosting', 'CA', 'AuthRoot', 'TrustedPeople', 'My', 'SmartCardRoot', 'Trust', 'Disallowed')]
		[System.String]
		$Store = 'My',

	    [parameter(Mandatory)]
        [System.Management.Automation.PSCredential]
        $Password,

        [ValidateSet('Present', 'Absent')]
		[System.String]
		$Ensure = 'Present',

		[System.Boolean]
		$Reboot = $false
	)

    # ----------------
    # ENSURE = PRESENT
    if ($Ensure -ieq 'Present')
    {
        (Get-TargetResource @PSBoundParameters).thumbprint -eq $Thumbprint
    }

    # ---------------
    # ENSURE = ABSENT
    elseif ($Ensure -ieq 'Absent')
    {
        (Get-TargetResource @PSBoundParameters) -eq $null
    }
}
