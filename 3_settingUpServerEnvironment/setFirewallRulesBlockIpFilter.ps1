# This script creates a new firewall rule to block inbound traffic from multiple IP addresses on multiple machines.

$arcgisservers = @('machine1','machine2','machine3')  # List of machines to run the script on
$blockIPs = '192.168.1.1,10.0.0.1,172.16.0.1'  # List of IP addresses to block as a comma-separated string
$environment = "Target Non-Production" # Name of the environment to block traffic from

$parameters = @{
    ComputerName = $arcgisservers
    ScriptBlock = {
        param($blockIPs, $environment)  # Accepts the block IPs and environment as parameters
        # Create a single firewall rule to block inbound traffic from all specified IPs
        New-NetFirewallRule -DisplayName "Block Multiple IPs from $environment" -Direction Inbound -Action Block -RemoteAddress $blockIPs -Profile Any
    }
    ArgumentList = ($blockIPs, $environment)  # Pass the $blockIPs string and $environment as arguments to the ScriptBlock
}

Invoke-Command @parameters



