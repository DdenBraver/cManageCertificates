#requires -Version 4
configuration Sample_Certificate
{
    Import-DscResource -module cManageCertificates
    cManageCertificates Certificate
    {
        Thumbprint = $Node.CertificateThumbprint
        Location = $Node.Certificatelocation
        Ensure = 'Present'
        Password = $Node.Certificatepassword
        Store = 'My'
        StoreType = 'LocalMachine'
        Reboot = $false
        PsDscRunAsCredential = $Node.Credential
    }
}
Sample_Certificate