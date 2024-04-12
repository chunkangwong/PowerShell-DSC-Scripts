# Brendan Bladdick
# 
# 10/4/2022

#remove old modules from machines except for machine that you are running invoke command from
$arcgisservers = ("machine1","machine2")
foreach($server in $arcgisservers) {
Remove-Item -Path "\\$server\c$\Program Files\WindowsPowerShell\Modules\ArcGIS" -Recurse -Force -ErrorAction SilentlyContinue
}

#remove old module from this machine
Remove-Item -Path "C:\Program Files\WindowsPowerShell\Modules\ArcGIS" -Recurse -Force

#install new module to this machine
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module ArcGIS -Force

#transfer new module from this machine to other machines
foreach ($server in $arcgisservers) {
    Copy-Item -Path "C:\Program Files\WindowsPowerShell\Modules\ArcGIS" -Destination "\\$server\c$\Program Files\WindowsPowerShell\Modules" -Recurse
}