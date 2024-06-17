#Adrien Hafner
#This script is designed to assist with troubleshooting if you feel there may be an issue with connecting from an orchestration or deployment server to remote servers in the environment. 
#If successful, this script should allow you to enter a PowerShell session on the remote computer specified.
#change the 'server1' text with your machine name


Enter-PSSession -ComputerName 'server1'