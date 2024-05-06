#Functions
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7

#Parameters
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters?view=powershell-7

#Functions Advanced
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-7

#Functions Advanced Parameters
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7

#PowerShell Approved Verbs
#https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7

#CmdletBindingAttribute
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7


# ----------------------------------------------
# Anatomy of a PowerShell Function
# ----------------------------------------------
# function help - (optional but strongly encouraged)
# function name
# CmdletBinding - (optional)
# parameters - (optional)
# function logic (optional Begin / Process / End)
# return - (optional)


# PowerShell functions capabilities:
# Single-purposed --> a function is typically used to perform a narrow task. This makes functions hihgly-reusable.
# Help --> functions support help-based comments. This allows users to do things like Get-Help and figure out how to use your function
# Parameters --> support for simple and advanced parameter declarations and control allows your function to be dynamic and take various forms of user input
# Testable --> functions can be tested and mocked which greatly improves code-quality 


<#
.SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
function Verb-Noun {
    [CmdletBinding()]
    param (

    )
    begin {

    }
    process {

    }
    end {

    }
}

# PowerShell functions will act like a cmdlet. Cmdlet's are compile in C#, whereas PowerShell functions are written in PowerShell
# CmdletBinding is an attribute of functions that enables capabilities to make them operate like cmdlets. Some are:
# Write-Verbose --> allow users to use the -Verbose switch to see what your function is doing while it's executing
# ShouldProcess --> if your function will make a change to a system that is high risk, you may want the user to confirm the action 
# PositionalBininding --> enables your function to be run without explicitly providing each parameter name. The values can be inferred by the order they are provided to your function


# Function example

<#
.SYNOPSIS
    Returns your public IP address.
.DESCRIPTION
    Queries the ipify Public IP Address API and returns your public IP.
.EXAMPLE
    Get-PublicIP
 
    Returns the public IP.
.OUTPUTS
    System.String
.NOTES
    https://github.com/rdegges/ipify-api
#>
function Get-PublicIP {
    [CmdletBinding()]
    param ()
    $uri = 'https://api.ipify.org'
    Write-Verbose -Message "Pulling Public IP from $uri"
    try {
        $invokeRestMethodSplat = @{
            Uri         = $uri
            ErrorAction = 'Stop'
        }
        $publicIP = Invoke-RestMethod @invokeRestMethodSplat
    }
    catch {
        Write-Error $_
    }
 
    return $publicIP
}#Get-PublicIP