# List of target machines
$computers = @("Machine1", "Machine2", "Machine3")

# Trusted hosts array
$trustedHosts = @(
    "192.168.1.1",  # Replace with your IP addresses
    "192.168.1.2",
    "hostname1.domain.com",  # Replace with your hostnames
    "hostname2.domain.com"
)

# Convert the array to a comma-separated string
$trustedHostsString = $trustedHosts -join ','

# Script block to execute on each machine
$scriptBlock = {
    param($trustedHostsString)
    try {
        winrm set winrm/config/client '@{TrustedHosts="' + $trustedHostsString + '"}'
        Write-Host "TrustedHosts set to: $trustedHostsString"
    } catch {
        Write-Host "An error occurred: $_"
    }
}

# Execute the script block on each target machine
foreach ($computer in $computers) {
    Invoke-Command -ComputerName $computer -ScriptBlock $scriptBlock -ArgumentList $trustedHostsString
}