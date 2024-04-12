# Brendan Bladdick

# remove old modules from machines except for machine that you are running invoke command from

# change the machine1, machine2 with your machines

# connects to each machine in the arcgisservers array and removes the old ArcGIS module from the machine then installs the new module

$arcgisservers = ("machine1","machine2")

# Start a new job for each server
$jobs = $arcgisservers | ForEach-Object {
    $server = $_
    Start-Job -ScriptBlock {
        param($server)
        Write-Host "Connecting to $server"
        $session = New-PSSession -ComputerName $server
        Invoke-Command -Session $session -ScriptBlock {
            Remove-Item -Path "C:\Program Files\WindowsPowerShell\Modules\ArcGIS" -Recurse -Force -ErrorAction SilentlyContinue
            #install new module to this machine
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
            Install-Module ArcGIS -Force
        }
    } -ArgumentList $server
}

# Wait for all jobs to complete
$jobs | Wait-Job

# Get the results of the jobs
$results = $jobs | Receive-Job

# Clean up the jobs
$jobs | Remove-Job