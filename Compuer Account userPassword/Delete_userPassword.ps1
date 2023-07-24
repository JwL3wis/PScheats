# Get the current directory where the script is located
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Combine the script directory with the filename (output.txt)
$txtFilePath = Join-Path -Path $scriptDirectory -ChildPath "output.txt"

# Read the list of computer DistinguishedNames from the text file
$computers = Get-Content -Path $txtFilePath

# Domain Controller
$domainController = "your_domain_controller"

# Loop through each computer account and remove the userPassword attribute
foreach ($computerDN in $computers) {
    $ldapPath = "LDAP://" + $domainController + "/" + $computerDN

    try {
        # Connect to the AD object
        $adComputer = [ADSI]$ldapPath

        # Remove the userPassword attribute
        $adComputer.Put("userPassword", $null)
        $adComputer.SetInfo()

        Write-Host "Removed userPassword attribute from $($computerDN)"
    }
    catch {
        Write-Host "Error occurred while processing $($computerDN): $_.Exception.Message"
    }
}
