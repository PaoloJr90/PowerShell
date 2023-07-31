# Control/Logic flow with PowerShell

if (condition) {
    # perform an action
}
elseif (condition) {
    # perform a different action base on different criteria
}
else {
    # will perform action if none of the previous criteria are met
}

#----------------------------------

$path = 'C:\Users' #windows file-system path
$evalPath = Test-Path $path # Test-Path is used to evaluate the path; returns a boolean value
if ($evalPath -eq $true) { # $true come from the Test-Path cmdlet
    Write-Host "The path $path exists" # Write-Host is used to output to the console
}
elseif ($evalPath -eq $false) {
    Write-Host "The path $path does not exist"
}

# Comparison Operators
# -eq       equals
# -ne       not equals
# -gt       greater than
# -ge       greater than or equal to
# -lt       less than
# -le       less than or equal to
# -like     wild card pattern match
# -notlike  wild card pattern match 

#----------------------------------

# Switch statements are used to evaluate multiple conditions

[int]$aValue = Read-Host 'Enter a number' # Read-Host is used to prompt the user for input
switch ($aValue) {
    1 {
        Write-Host 'You entered the number ONE'
    }
    2 {
        Write-Host 'You entered the number TWO'
    }
    3 {
        Write-Host 'You entered the number THREE'
    }
    Default {
        Write-Host "Sorry, I don't know what to do with $aValue"
    }
}

#----------------------------------

# Loops are used to iterate over a collection of items

# for loop
for ($i = 0; $i -le 10; $i++) {
    Write-Host $i -ForegroundColor $i # ForegroundColor is used to change the color of the text in the console
}

$aString = 'Jean-Luc Picard'
$reversedString = ''
for ($i = $aString.Length; $i -ge 0; $i--) {
    $reversedString += $aString[$i]
}
$reversedString

# foreach loop

$path = 'C:\Users\pjang\OneDrive'
[int]$totalSize = 0
$fileInfo = Get-ChildItem $path -Recurse # Get-ChildItem is used to get the files in the path; used recursively
foreach ($file in $fileInfo) {
    $totalSize += $file.Length # Length is a property of the file object that returns the size of the file
}
Write-Host "The total size of files in $path is $($totalSize / 1MB) MB"

#----------------------------------

# do while loop; will execute at least once
$pathVerified = $false
do {
    # in a do while, the user will always be prompted at least once
    $path = Read-Host 'Please enter a file path to evaluate'
    if (Test-Path $path) {
        $pathVerified = $true
    }
} while ($pathVerified -eq $false)
# the loop will continue until the path is verified
#----------------------------------
# while loop performs similarly to a do while loop, but will not execute if the condition is not met
$pathVerified = $true
while ($pathVerified -eq $false) {
    # in a while loop, you might never enter the loop
    $path = Read-Host 'Please enter a file path to evaluate'
    if (Test-Path $path) {
        $pathVerified = $true
    }
}
# this loop was never entered because $pathVerified is $true

#----------------------------------

# Where-Object is used to filter a collection of items
# Get processes using more than 50MB of memory
$largeProcesses = Get-Process | Where-Object { $_.WorkingSet64 -gt 50MB }

# do the same thing using if statements and loop
$largeProcesses = @() # create an empty array
$processes = Get-Process
foreach ($process in $processes) {
    if ($process.WorkingSet64 -gt 50MB) {
        $largeProcesses += $process
    }
}

# ForEach-Object is used to perform an action on each item in a collection
$path = 'C:\Users\pjang\OneDrive'
$folderCount = 0
Get-ChildItem $path | ForEach-Object -Process { if ($_.PSIsContainer) { $folderCount++ } }
# $_ is the current item in the collection
# PSIsContainer is a property of the item that returns a boolean value; $true if the item is a folder and $false if it is a file
$folderCount

#----------------------------------

# Putting it all together with a real-world example
# declare a few variables for counting
[int]$fileCount = 0
[int]$folderCount = 0
[int]$totalSize = 0
 
# declare our path we want to evaluate
$path = 'C:\Users\pjang\OneDrive'
 
# get the file information
$rawFileInfo = Get-ChildItem $path -Recurse
 
# loop through that file information
foreach ($item in $rawFileInfo) {
    if ($item.PSIsContainer) {
        # this is a folder/directory
        $folderCount++
    }
    else {
        # this is a file, because it is not a PSIsContainer
        $fileCount++
        $totalSize += $item.Length # Length is a property of the file object that returns the size of the file
    }
}
 
# generate output
Write-Host "Breakdown of $path"
Write-Host "Total Directories: $folderCount"
Write-Host "Total Files: $fileCount"
Write-Host "Total Size of files: $($totalSize / 1MB) MB"