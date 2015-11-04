# cManageCertificates

The **cManageCertificates** module contains resources for Managing certificates on a computer.

## Resources

###cManageCertificates

*   **Thumbprint**: KEY - Thumbprint of the certificate to be imported or removed.

*   **Location**: KEY - Source location of the certificate file.

*   **StoreType**: The storetype of the certificate location.
Valid roles are "CurrentUser", "LocalMachine".

*   **Store**: The Store name for the certificate.
Valid roles are "TrustedPublisher", "ClientAuthIssuer", "Remote Desktop", "Root", "TrustedDevices", "WebHosting", "CA", "AuthRoot", "TrustedPeople", "My", "SmartCardRoot", "Trust", "Disallowed".

*   **Password**: REQUIRED - The Certificate password.

*   **Ensure**: Value to make sure a certificate is or is not available on the store of the server.

*   **Reboot**: BOOLEAN - If set to $true, will set the DSC Reboot flag when completed.