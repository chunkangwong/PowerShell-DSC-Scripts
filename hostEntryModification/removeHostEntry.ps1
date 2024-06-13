# This script removes an entry from the hosts file on multiple remote machines

# Define the host entry details to remove
$ipAddress = "10.0.0.1" # IP address to map to the DNS name and machine name
$machineName = "machine1" # Name of the machine whose IP address is being mapped
$dnsName = "host.domain.com" # DNS name to map to the IP address

# List of target machine names/IP addresses
$targetMachines = @("machine1", "machine2", "machine3", "machine4")

# Loop through each target machine
foreach ($machine in $targetMachines) {
    # Use Invoke-Command for remote execution
    Invoke-Command -ComputerName $machine -ScriptBlock {
        param($ipAddress, $dnsName, $machineName)

        # Path to the hosts file
        $hostsPath = "C:\Windows\System32\drivers\etc\hosts"

        # Read the content of the hosts file
        $hostsContent = Get-Content $hostsPath

        # Filter the content to remove the entry, if it exists
        $newHostsContent = $hostsContent | Where-Object { $_ -notmatch "$ipAddress\s+$machineName\s+$dnsName" }

        # Check if any change is made
        if ($hostsContent.Count -ne $newHostsContent.Count) {
            # Write the updated content back to the hosts file
            $newHostsContent | Set-Content $hostsPath
            Write-Host "Entry for $dnsName and $machineName removed from $using:machine." -ForegroundColor Cyan
        } else {
            Write-Host "Entry for $dnsName and $machineName does not exist in $using:machine." -ForegroundColor Yellow
        }

        # Verify the DNS resolution
        $resolvedIp = [System.Net.Dns]::GetHostAddresses($dnsName) | Select-Object -First 1
        if ($resolvedIp.IPAddressToString -ne $ipAddress) {
            Write-Host "DNS resolution for $dnsName on $using:machine is correct ($resolvedIp)." -ForegroundColor Green
        } else {
            Write-Host "DNS resolution for $dnsName on $using:machine is still pointing to old IP ($resolvedIp)." -ForegroundColor Red
        }
    } -ArgumentList $ipAddress, $dnsName, $machineName
}