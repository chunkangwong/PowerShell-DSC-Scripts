# Brendan Bladdick
#
# this script is designed to transfer web adaptor pre-requisites to all the machines in the @arcgisservers block from a local directory on the machine that has the web adaptor pre-requisites
# change the machine1, machine2 with your machines
# Do not include the machine that has the web adaptor pre-requisites on it inside of the @arcgisservers block or it will remove your web adaptor pre-requisites

$server = "arcgisweb24t"
$mainDirectory = "EsriInstall"
$subDirectory = "pre_requisites"

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