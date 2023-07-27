# Working with PowerShell variables

# $ is used to declare a variable
$process = Get-Process
$process

#----------------------------------------
# not using variable
Get-Process | Where-Object {$_.CPU -gt 5000} #find processes keeping the CPU busy; gt = greater than
Get-Process | Sort-Object WorkingSet64 -Descending #sort processes by memory usage
#----------------------------------------
# using variable
$processes = Get-Process # this will store the output of the command in the variable; the variable can be used later in the script when called
$processes | Where-Object {$_.CPU -gt 5000} #find processes keeping the CPU busy
$processes | Sort-Object WorkingSet64 -Descending #sort processes by memory usage

#----------------------------------------

# PowerShell is not a strongly-type language; variables can be defined as any data type
# examples:
$myNewVariable = "Hello World" #string
$myNewVariable = 1 #integer
$myNewVariable = 1.5 #float
$myNewVariable = $true #boolean
$myNewVariable = Get-Process #object
$myNewVariable #this call will return the last value assigned to the variable
#----------------------------------------
$total = 2 + 2
$total
$total | Get-Member # get the data type of the variable; this will return the data type as an integer
#----------------------------------------
$total = '2 + 2'
$total # this will return a string = '2 + 2'
$total | Get-Member # this will return the data type as a string

#----------------------------------------

$num1 = 2
$num2 = 2
$total = $num1 + $num2 # this will return the sum of the two variables
$total
#----------------------------------------
$num1 = '2'
$num2 = '2'
$total = $num1 + $num2 # this will return the two variables as a concatenated string = '22'
$total

#----------------------------------------

# Strongly typing variables
[int]$num1 = '2' # this will convert the string to an integer as it is assigned to the variable; front-load the variable with [int] to convert to integer
[int]$num2 = '2'
$total = $num1 + $num2
$total | Get-Member

# Converting data-types
$stringReturn = $total.ToString() # this will convert the integer to a string
$stringReturn | Get-Member

#----------------------------------------

# Working with quotes in PowerShell
# single quotes will return the literal value of the string
$literal = 'Two plus one equals: $(1 + 2)'
$literal
# double-quotes will return the value of the string; string interpolation
$escaped = "Two plus one equals: $(1 + 2)"
$escaped

# Write-Host is used to output to the console
Write-Host '$escaped' # this will return the literal value of the string = '$escaped'
Write-Host "$escaped" # this will return the value of the string = 'Two plus one equals: 3'

#----------------------------------------

# Reserved variables
Get-Variable # this will return all variables in the current session

# Attempts to load into a reserved variable will fail
# $HOME = 'c:\test'
Cannot overwrite variable HOME because it is read-only or constant.


# Getting environment variables
Get-ChildItem env: # this will return all environment variables in the current session
$env:COMPUTERNAME # this will return the value of the COMPUTERNAME environment variable
$env:USERNAME # this will return the value of the USERNAME environment variable

#----------------------------------------

# Putting it all together
$path = Read-Host -Prompt 'Please enter the file path you wish to scan for large files...'
$rawFileData = Get-ChildItem -Path $path -Recurse
$largeFiles = $rawFileData | Where-Object {$_.Length -gt 100MB}
$largeFilesCount = $largeFiles | Measure-Object | Select-Object -ExpandProperty Count
Write-Host "You have $largeFilesCount large file(s) in $path"

#----------------------------------------

# Common variable types in PowerShell
[string]    # String of Unicode characters
 
[int]       # 32-bit integer
[long]      # 64-bit integer
[decimal]   # 128-bit decimal value
[single]    # 32-bit floating point number
[double]    # 64-bit floating point number
 
[bool]      # Boolean True/False
 
[DateTime]  # Date and Time
 
[array]     # array of values
[hashtable] # Hashtable object