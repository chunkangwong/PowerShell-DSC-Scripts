# Create a local user account on a Windows machine

# Variables
$username = "NewLocalUser"
$password = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
$fullName = "New Local User"
$description = "Local user for DMZ and Non-DMZ machines"

try {
    # Create local user
    if (-not (Get-LocalUser -Name $username -ErrorAction SilentlyContinue)) {
        New-LocalUser -Name $username -Password $password -FullName $fullName -Description $description
        Write-Host "Local user $username created successfully."
    } else {
        Write-Host "Local user $username already exists."
    }

    # Add user to the Administrators group
    if (-not (Get-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction SilentlyContinue)) {
        Add-LocalGroupMember -Group "Administrators" -Member $username
        Write-Host "User $username added to Administrators group."
    } else {
        Write-Host "User $username is already a member of the Administrators group."
    }
} catch {
    Write-Host "An error occurred: $_"
}
