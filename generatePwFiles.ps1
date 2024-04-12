# Brendan Bladdick
 
# script to create password files for the accounts and certificates
 
# Define account types and their respective output file paths in a hashtable
$accounts = @{ # Hashtable
    "AD account 'domain\svcArcGIS'" = "D:\EsriInstall\passwordFiles\ADPassword.txt"
    "MyEsri account 'temp'" = "D:\EsriInstall\passwordFiles\myesri.txt"
    "Portal account 'arcgisportal'" = "D:\EsriInstall\passwordFiles\arcgisportal.txt"
    "Server account 'arcgisadmin'" = "D:\EsriInstall\passwordFiles\arcgisadmin.txt"
    "Server 'cert' certificate" = "D:\EsriInstall\passwordFiles\cert.txt"
}
 
# Iterate over each account, prompt for password, and save to file
foreach ($account in $accounts.GetEnumerator()) { # GetEnumerator() returns a collection of key-value pairs
    Write-Host "Enter the password for the $($account.Key)" # Key is the account type, Value is the file path
    $password = Read-Host -AsSecureString | ConvertFrom-SecureString # Convert to secure string and then to plain text
    $password | Out-File $account.Value # Save to file
}
