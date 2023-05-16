# Replace with the distinguished names of the OUs you want to search, separated by commas
$ous = "OU=Users1,DC=example,DC=com","OU=Users2,DC=example,DC=com" 

$results = foreach ($ou in $ous) {
    Get-ADUser -Filter * -SearchBase $ou -Properties extensionattributeX, LastLogonDate | Select-Object Name, CanonicalName, SamAccountName, extensionattribute8, LastLogonDate, Enabled, UserPrincipalName,DistinguishedName
}
$count = $results.Count
Write-Host "$count users found"
$results | Export-Csv -Path "C:\temp\output.csv" -NoTypeInformation
Write-Host "Output has been exported to 'C:\Temp\Inactive Users 6m.csv'."
Read-Host -Prompt "Press Enter to exit"
