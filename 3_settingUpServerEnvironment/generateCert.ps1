$domain_name = $env:userdnsdomain;

$dns_name = $env:computername + '.' + $domain_name;
$date_now = Get-Date;
$extended_date = $date_now.AddYears(3);

# Create a self-signed certificate
$mycert = New-SelfSignedCertificate -DnsName $dns_name -CertStoreLocation cert:/LocalMachine/My -NotAfter $extended_date;

$mainDirectory = "EsriInstall" # change this to the directory that contains the folder that contains the certificates folder
$subDirectory = "certificates" # change this to the directory that contains the certificates
$pfxPath = "C:\$mainDirectory\$subDirectory\certificate.pfx"

$password = Read-Host -Prompt "Enter password to protect the certificate" -AsSecureString

Export-PfxCertificate -Cert $mycert -FilePath $pfxPath -Password $password
