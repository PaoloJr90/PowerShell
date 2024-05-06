# code example script
$total = 2 + 2
$output = "two plus two is equal to $total"
Write-Output $output
# to execute
# windows
.\powerShellScripts.ps1
# linux 
./powerShellScripts.ps1

# PowerShell execution policy - types
# Restricted - stops any scripts from running
# RemoteSigned - runs scripts created on the device. However, scripts created on another computer won't run unless they include a signutature of a trusted publisher
# AllSigned - all the scripts will run as lon as they've been signed by a trusted publisher
# Unrestricted - runs any script withou any restrictions

# to determine the execution policy of all scopes in the order of precedence 
Get-ExecutionPolicy -List 
# change execution policy 
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser



# Each script runs in its own scope. The functions, variables, aliases, and drives that are created in the script exist only in the script scope. You cannot access these items or their values in the scope in which the script runs.

# The dot sourcing feature lets you run a script in the current scope instead of in the script scope. When you run a script that is dot sourced, the commands in the script run as though you had typed them at the command prompt. The functions, variables, aliases, and drives that the script creates are created in the scope in which you are working. After the script runs, you can use the created items and access their values in your session.

# if you need to access the information in the context of the current PowerShell session, you can `dot source` the PowerShell script --> placing a dot before the script path

# examples:
# dot source a full file path
. C:\scripts\math.ps1
# dot source a local file
. .\math.ps1
# this will load the script into memory and execute any non-Function
