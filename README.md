# ArcGIS PowerShell DSC Helper Scripts

A series of helper scripts have been developed to assist with both setting up and configuring the PowerShell DSC environment, as well as making the ArcGIS deployment more standardized and seamless. Below is a brief description of some of them:

## [dscScripts folder](./dscScripts/)

- [**clearDscConfig.ps1**](./dscScripts/clearDscConfig.ps1) – This script is good to run before and after running the Invoke-ArcGISConfiguration command, as it clears out any of the configuration settings currently in place within the PowerShell DSC module on the machine(s) specified. It’s good to run it twice, as well. The first time, it should clear out any settings. Running it again will allow you to confirm by looking at the console outputs that nothing is pending and that everything has in fact been reset/cleared.

- [**localLcmSet.ps1**](./dscScripts/localLcmSet.ps1) – This script sets the local DSC configuration by updating the LCM (local configuration manager) for each machine to ‘ApplyOnly’ configuration mode, and ‘StopConfiguration’ action after reboot. The ‘ApplyOnly’ configuration mode is not the default LCM setting but works best with PowerShell DSC deployments like we use for installing and upgrading Enterprise. What it does is specify that the LCM applies the configuration only, and then does not continue to monitor for changes and write logs about any drift. The ‘ApplyOnly’ setting essentially says “do what the script is telling you to do right now, and then nothing else until another script tells you to do something else, explicitly”. The ‘StopConfiguration’ setting for the action after reboot says that in the event the machine gets rebooted, the process will be stopped and upon reboot, the DSC process will not try to restart automatically.

## [transferScripts folder](./transferScripts/)

- [**transferCertificates.ps1**](./transferScripts/transferCertificates.ps1) – this script will transfer the contents of a ‘certificates’ folder on an orchestration machine, or the local machine to remote servers to be used for the deployment. Make sure not to include the orchestrating machine in the list of $arcgisservers.

- [**transferInstallers.ps1**](./transferScripts/transferInstallers.ps1) – this script will transfer the contents of an ‘installers’ folder (as well as any sub-directories) from a local location to a list of machines specified for each ArcGIS component. Make sure not to include the orchestrating machine in the list of $arcgisservers.

- [**transferLicenses.ps1**](./transferScripts/transferLicenses.ps1) – this script will transfer the contents of a ‘licenses’ folder from a local location to a list of machines specified for each ArcGIS component. Make sure not to include the orchestrating machine in the list of $arcgisservers.

- [**transferModule.ps1**](./transferScripts/transferModule.ps1) – this script will transfer the local arcgis PowerShell module (without upgrading it) to a list of remote servers provided in the script. This is useful if utilizing an older version of the PowerShell DSC ArcGIS Module. Make sure not to include the orchestrating machine in the list of $arcgisservers.

- [**transferPreRequisites.ps1**](./transferScripts/transferPreRequisites.ps1) - This script transfers the Web Adaptor prerequisites from a local machine to the web server that will be used for hosting the Web Adaptors.

## [hostEntryModification folder](./hostEntryModification/)

- [**addHostEntry.ps1**](./hostEntryModification/addHostEntry.ps1) - This script adds a new host entry to the hosts file on multiple remote machines. It ensures that the specified DNS name resolves to the given IP address locally on each target machine. After adding the entry, the script verifies the DNS resolution to confirm it points to the correct IP address.

- [**removeHostEntry.ps1**](./hostEntryModification/removeHostEntry.ps1) - This script removes an existing host entry from the hosts file on multiple remote machines. After removing the entry, the script verifies the DNS resolution to ensure it points to the correct IP address according to the DNS server.

## [setFirewallRules folder](./setFirewallRules/)

- [**setFirewallRulesAllowAge.ps1**](./setFirewallRules/setFirewallRulesAllowAge.ps1) - This script sets up firewall rules on a list of specified machines to allow inbound traffic on designated ports. It is designed to facilitate the configuration of firewall settings for ArcGIS Enterprise by opening necessary ports for various services.

- [**setFirewallRulesBlockIpFilter.ps1**](./setFirewallRules/setFirewallRulesBlockIpFilter.ps1) - This script sets up a firewall rule on a list of specified machines to block inbound traffic from a list of specified IP addresses. It is intended to enhance security by preventing traffic from certain IP addresses in a specified environment.

## Addional Scripts

-  [**downloadUpgradeArcgisModule.ps1**](./downloadUpgradeArcgisModule.ps1)
    - This script will remove any ArcGIS Modules from the machines in the list and install the most up to date ArcGIS Module to each machine. If you do not want the most recent version, download the desired version from GitHub and utilize the script within the transferScripts folder that will transfer the module from the Orchestration machine to the list of remote servers in the $arcgisservers variable.

- [**generatePwFiles.ps1**](./generatePwFiles.ps1)
    - This script allows for the generation of the password files that can be used in place of hard-coded password values in the JSON configuration file. Note: Once you specify the location of the password files in the script and run the script, the password files cannot be moved, or they will break. This is intentional. So, decide where you’d like for them to be located, make sure that path is specified in the script as well as the JSON configuration file, and then run the script. Note that the password files can only be used by the user who created them on the machine they were created on, within the folder they were created. This is for security purposed. The password files only need to be created on the machine that is being used to orchestrate the Invoke-ArcGISConfiguration command.

- [**InvokeScript.ps1**](./InvokeScript.ps1)
    - This script starts the ArcGIS deployment in PowerShell. It first changes the directory to a path where logs can be accessed easily (such as within the folder structure where the rest of the deployment files are located). Then, it runs the Invoke-ArcGISConfiguration command with the configuration file. You can change the -Mode switch to one of the other options \[Install | InstallLicense | InstallLicenseConfigure | Uninstall | Upgrade | WebGISDRExport | WebGISDRImport\] to adjust to what you’d like the Invoke command to do.
