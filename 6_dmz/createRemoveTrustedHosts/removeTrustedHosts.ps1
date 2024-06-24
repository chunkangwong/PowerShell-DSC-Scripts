# Removes specified IP addresses and hostnames from the TrustedHosts list in WinRM configuration

# Variables
$trustedHostsToRemove = @(
    "192.168.1.1",  # Replace with the IP addresses to remove
    "192.168.1.2",
    "hostname1.domain.com",  # Replace with the hostnames to remove
    "hostname2.domain.com"
)

# Get current TrustedHosts
$currentTrustedHosts = (winrm get winrm/config/client | Select-String -Pattern 'TrustedHosts').ToString().Split('=')[1].Trim('"').Split(',')

# Remove specified hosts
$updatedTrustedHosts = $currentTrustedHosts | Where-Object { $_ -notin $trustedHostsToRemove }

# Convert the array to a comma-separated string
$updatedTrustedHostsString = $updatedTrustedHosts -join ','

# Set updated TrustedHosts
try {
    winrm set winrm/config/client '@{TrustedHosts="' + $updatedTrustedHostsString + '"}'
    Write-Host "Updated TrustedHosts: $updatedTrustedHostsString"
} catch {
    Write-Host "An error occurred: $_"
}
