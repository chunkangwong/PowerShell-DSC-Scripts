# Brendan Bladdick
#
# this script is designed to transfer licenses to all the machines in the @arcgisservers block from a local directory on the machine that has the licenses
# change the machine1, machine2 with your machines
# Do not include the machine that has the licenses on it inside of the @arcgisservers block or it will remove your licenses

$arcgisservers = @('arcgisdata27t', 'arcgishost26t', 'arcgisport25t', 'arcgislrs23t', 'arcgisimg28t', 'machine1','machine2')

$mainDirectory = "EsriInstall"
$subDirectory = "licenses"
 
$ScriptBlock = {
    param ($server, $mainDirectory, $subDirectory)
    # Define the target directory path
    $targetDir = "\\$server\d$\$mainDirectory\$subDirectory"
    
    # Check if the target directory exists, create it if it doesn't
    if (-not (Test-Path -Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force
    }
    else {
        # If the directory already exists, remove its contents
        Remove-Item "$targetDir\*" -Recurse -Force
    }
    
    # Now, copy only the contents of the source licenses folder to the target
    Copy-Item -Path "D:\$mainDirectory\$subDirectory\*" -Destination $targetDir -Recurse -Force
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
