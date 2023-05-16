# Define an array of OUs to search for inactive users
# Replace with the distinguished names of the OUs you want to search, separated by commas
$searchBases = @('OU=Users1,DC=example,DC=com', 'OU=Users2,DC=example,DC=com')

$results = foreach ($searchBase in $searchBases) {
    Get-ADUser -Filter * -SearchBase $searchBase -Properties extensionattribute8, LastLogonDate |
        Where-Object { $_.extensionattributeX -ne $null } |
        Select-Object Name, CanonicalName, SamAccountName, extensionattribute8, LastLogonDate, Enabled, UserPrincipalName,DistinguishedName
}

$count = $results.Count
Write-Host "$count users found"
$results | Export-Csv -Path "C:\temp\output.csv" -NoTypeInformation
Write-Host "Output has been exported to 'C:\Temp\output.csv'."
Read-Host -Prompt "Press Enter to exit"
