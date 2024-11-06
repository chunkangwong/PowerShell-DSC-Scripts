#Adrien Hafner
#This script is designed to assist with confirming WinRM connectivity between an orchestration server and other servers in the deployment before attempting a PowerShellDSC install.  The script can also assist with troubleshooting if you feel there may be an issue with connecting from an orchestration or deployment server to remote servers in the environment. 
#If successful, this script should allow you to enter a PowerShell session on the remote computer specified.
#change the 'server1' text with your machine name

$arcgisservers = @('machine1', 'machine2')
foreach ($server in $arcgisservers) {
    try {
        Enter-PSSession -ComputerName $server -ErrorAction Stop
        Exit-PSSession
    
        Write-Host "WinRM appears to be working between this machine and the server you entered." -ForegroundColor Green
    }
    catch {
        Write-Host "WinRM test failed." -ForegroundColor Red
    
        Write-Host "Details: $_" -ForegroundColor Yellow
    }
}