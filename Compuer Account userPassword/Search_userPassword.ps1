# Specify OU 
$ouDN = "OU=YourOU,DC=yourdomain,DC=com"

# Get the current script location
$scriptPath = $MyInvocation.MyCommand.Path
$scriptFolder = Split-Path $scriptPath -Parent

# Set the output text file path
$outputTXTPath = Join-Path $scriptFolder "output.txt"

# Initialize an empty array to store the DistinguishedNames of computer accounts with userPassword attribute set
$computersWithUserPassword = @()

# Get the computer accounts in the specified OU with the userPassword attribute set
$computers = Get-ADComputer -Filter {UserPassword -like "*"} -SearchBase $ouDN -Properties UserPassword

# Loop through the computers and add their DistinguishedName to the array
foreach ($computer in $computers) {
    $computersWithUserPassword += $computer.DistinguishedName
}

# Export the DistinguishedNames to the text file
$computersWithUserPassword | Out-File -FilePath $outputTXTPath

# Output a message indicating successful completion
Write-Host "DistinguishedNames of computer accounts with userPassword attribute set have been exported to $outputTXTPath."
