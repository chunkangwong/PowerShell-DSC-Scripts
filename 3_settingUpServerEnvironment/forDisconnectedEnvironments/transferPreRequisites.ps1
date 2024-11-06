# Brendan Bladdick

# this script is designed to transfer web adaptor pre-requisites to the web server machine

$server = "web server machine"
$mainDirectory = "EsriInstall" #change this to the directory that contains the folder that contains the pre-requisites folder
$subDirectory = "pre_requisites" #change this to the directory that contains the pre-requisites

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