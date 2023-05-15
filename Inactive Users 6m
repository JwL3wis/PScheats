
# Connect to Active Directory
Import-Module ActiveDirectory

# Define the number of days for inactive users
$daysInactive = 180

# Define the date 6 months ago
$time = (Get-Date).AddDays(-($daysInactive))

# Define an array of OUs to search for inactive users
$searchBases = @('OU=A,DC=A', 'OU=B,DC=B', 'OU=C,DC=C', 'OU=D,DC=D')

# Initialize an array to store inactive users
$inactiveUsers = @()

# Search for inactive users in each OU separately
ForEach ($searchBase in $searchBases) {
    $inactiveUsers += Get-ADUser -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp -SearchBase $searchBase | Where-Object { $_.Enabled -eq $true } | Select-Object Name, CanonicalName, samAccountName, Enabled, UserPrincipalName, LastLogonTimeStamp, DistinguishedName
}

# Display the number of inactive users found
Write-Host "Found $($inactiveUsers.Count) inactive users."

# Export the list of inactive users to a CSV file in the "C:\Temp" folder
$inactiveUsers | Export-Csv -Path "C:\Temp\Inactive Users 6m.csv" -NoTypeInformation

# Output confirmation 
Write-Host "Output has been exported to 'C:\Temp\Inactive Users 6m.csv'."
Read-Host -Prompt "Press Enter to exit"


