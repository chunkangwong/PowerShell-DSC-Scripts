# Brendan Bladdick

# this script is designed to transfer certificates to all the machines in the @arcgisservers block from a local directory on the machine that has the certificates

# change the machine1, machine2 with your machines

# Do not include the machine that has the certificates on it inside of the @arcgisservers block or it will remove your certificates
 
$arcgisservers = @('machine1', 'machine2')
 
$mainDirectory = "EsriInstall" #change this to the directory that contains the folder that contains the certificates folder
$subDirectory = "certificates" #change this to the directory that contains the certificates

$ScriptBlock = {
    param ($server, $mainDirectory, $subDirectory)
    # Define the target directory path
    $targetDir = "\\$server\c$\$mainDirectory\$subDirectory"
    
    # Check if the target directory exists, create it if it doesn't
    if (-not (Test-Path -Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force
    }
    else {
        # If the directory already exists, remove its contents
        Remove-Item "$targetDir\*" -Recurse -Force
    }
    
    # Now, copy only the contents of the source licenses folder to the target
    Copy-Item -Path "C:\$mainDirectory\$subDirectory\*" -Destination $targetDir -Recurse -Force
}

$jobs = @()
foreach ($server in $arcgisservers) {
    $job = Start-Job -ScriptBlock $ScriptBlock -ArgumentList $server, $mainDirectory, $subDirectory
    $jobs += $job
}

# Wait for all jobs to complete
$jobs | Wait-Job

# Output job results and cleanup
$jobs | ForEach-Object {
    Receive-Job -Job $_
    Remove-Job -Job $_
}