# Function scope

function Get-NumberTimesTwo {
    [CmdletBinding()]
    param (
        [int]$Number
    )
    $total = $Number * 2
    # Write-Debug $total
    return $total
}#Get-NumberTimesTwo

Get-NumberTimesTwo -Number 2 -Debug

# unable to see the value of $total in the console. Here are some strategies to analyze the variable in the console:
# 1. remove the function wrapper and simply run as a normal PowerShell script
# 2. use Write-Host, Write-Output, Write-Debug