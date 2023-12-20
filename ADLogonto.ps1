$Usernames = @("User1", "User2")

foreach ($Username in $Usernames) {
    # Get the AD user object
    $User = Get-ADUser -Identity $Username -Properties LogonWorkstations

    # Check if the 'LogonWorkstations' attribute is set
    if ($User.LogonWorkstations -ne $null) {
        # The 'LogonWorkstations' attribute contains the list of allowed computers
        Write-Host "Computers that $Username is allowed to log on to:"
        $User.LogonWorkstations
    } else {
        Write-Host "The user $Username is not restricted from logging on to specific computers."
    }

    # Add a separator between user results
    Write-Host "------------------------"
}
