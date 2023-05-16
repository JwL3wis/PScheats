$userlist = Get-Content -Path "$PSScriptRoot\userlist.txt"
$groupData = @()

foreach ($user in $userlist) {
    Write-Host "Getting group membership for $user"
    $groups = Get-ADPrincipalGroupMembership -Identity $user | Select-Object Name
    $groupData += [PSCustomObject] @{
        User = $user
        Groups = ($groups | Select-Object -ExpandProperty Name) -join ","
    }
}

$groupData | Export-Csv -Path "$PSScriptRoot\user_groups.csv" -NoTypeInformation
Write-Host "Report has been exported to 'user_groups.csv'."
Read-Host -Prompt "Press Enter to exit"