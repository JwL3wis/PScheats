Read-Host This script will remove users from the Administrators group on a computer.
Read-Host Winthin the directory you are running this script from you must name a CSV file call computers.csv that has two columns REMOTE_COMPUTER_NAME and USER_NAME. 

$computers = Import-Csv "$PSScriptRoot\inputlist.csv"
$outputFile = "$PSScriptRoot\output.txt"

$successCount = 0
$failureCount = 0

foreach ($computer in $computers) {
    $remoteComputerName = $computer.REMOTE_COMPUTER_NAME
    $userName = $computer.USER_NAME

    if (Test-Connection -ComputerName $remoteComputerName -Quiet -Count 1) {
        try {
            if (Invoke-Command -ComputerName $remoteComputerName -ScriptBlock {
                if (Get-LocalGroupMember -Group "Administrators" | Where-Object { $_.Name -eq $using:userName }) {
                    Remove-LocalGroupMember -Group "Administrators" -Member $using:userName
                }
            }) {
                $status = "Success"
                $successCount++
            }
            else {
                $status = "Failed: User $userName not found in Administrators group"
                $failureCount++
            }
        }
        catch {
            $status = "Failed: $_"
            $failureCount++
        }
    }
    else {
        $status = "Failed: Could not ping $remoteComputerName"
        $failureCount++
    }

    $output = "$remoteComputerName,$userName,$status"
    $output | Out-File -FilePath $outputFile -Append
}

Write-Host "Number of successes: $successCount"
Write-Host "Number of failures: $failureCount"
Write-Host "See output.txt"
Read-Host -Prompt "Press Enter to exit"