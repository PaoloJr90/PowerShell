# PowerShell runs two pipelines: the success pipeline/success stream and the error pipeline/error stream.

# two pipelines!
Get-Process # this will generate a success pipeline
1/0; # this will generate an error pipeline; divide by zero error

# non-terminating error. PowerShell will continue execution after exception-handling
1/0; Write-Host 'Hello, will I run after an error?' # this will run the Write-Host command after the error

# non-terminating errors don't stop loops
$collection =  @('C:\Test\newcsv.csv',
                'c:\nope\nope.txt'
                'C:\Test\newcsv2.csv'
                )
foreach ($item in $collection) {
Get-Item $item
}
# this will error out on each item not present in the file-system, log it, and continue on to the next item in the collection

# Terminating Behavior

# Without ErrorAction
Get-Item -Path c:\nope\nope.txt; Write-Host 'Hello, will I run after an error?'
# With ErrorAction; tell PowerShell what to do when an error occurs (ex: Stop, Continue, Ignore, SilentlyContinue)
Get-Item -Path c:\nope\nope.txt -ErrorAction Stop; Write-Host 'Hello, will I run after an error?'
# error action could be:
# 'Continue' --> (default) logs error to $Error, displays error to console, continues execution
# 'Stop' --> logs error to $Error, displays error to console, terminates
# 'SilentlyContinue' --> logs error to $Error, does not display error, continues execution
# 'Ignore' --> does not log error $Error, does not display error, continues execution

# using try / catch

# throw causes PowerShell to terminate:
try {
    1/0; Write-Host 'Hello, will I run after an error?'
}
catch {
    # throw
    # Write-Error $_ # to force-show the error, otherwise PowerShell will simply run the catch 
    Write-Host 'You are now in the catch'

}

# this example will not go to the catch and will the Write-Host
try {
    Get-Item -Path C:\nope\nope.txt; Write-Host 'Hello, will i run after an error?'
}
catch {
    Write-Host 'You are now in the catch'
}
# this example will error and go directly to the catch
try {
    Get-Item -Path C:\nope\nope.txt -ErrorAction Stop; Write-Host 'Hello, will I run after an error?'
}
catch {
    Write-Host 'You are now in the catch'
}

# loop example

$processNames = @('NotAProcess', 'Notepad')
foreach ($item in $processNames) {
    try {
        Get-Process -Name $item -ErrorAction Stop # use this to force PowerShell to handle error
    }
    catch {
        Write-Host $item
        throw
    }
}

# Finally will log results regardless of what happens
try {
    Get-Content -Path c:\nope\nope.txt -ErrorAction Stop
}
catch {
    Write-Error $_
}
finally {
    # log results to a logging file
}

# exploring the error object

#The website exists, but the page does not
try {
    $webResults = Invoke-WebRequest -Uri 'https://techthoughts.info/nope.htm' -ErrorAction Stop
}
catch {
    Write-Error $_ # '$_' represents the current object in the error pipeline
}

#The website exists, but the page does not
try {
    $webResults = Invoke-WebRequest -Uri 'https://techthoughts.info/nope.htm'
}
catch {
    $theError = $_
    if ($theError.Exception -like "*404*") {
        Write-Warning 'Web page not found. Check the address and try again.'
        #Retry code
    }
    else {
        throw
    }
}
# can search through error object (or others) by piping to 'Format-List' cmdlet with -Force
# example:
$theError | Format-List -Force

#The website does not exist
try {
    $webResults = Invoke-WebRequest -Uri 'https://techthoughtssssssss.info/'
}
catch {
    $theError = $_
    $theError.Exception.Message
}

# $Error is a reserved variable that contains a collection of all errors in the current session
$Error[5] | Format-List * -Force
 
#a few other $Error commands to try
$Error
1/0; $Error
Get-Process -Name 'NotAProcess'
$Error # show all errors in current session
$Error.Clear() # to clear all errors in current session


#this example will help display some helpful message to the user
#this example will only work in PowerShell 6.1+
$uri = Read-Host 'Enter the URL'
try {
    $webResults = Invoke-WebRequest -Uri $uri -ErrorAction Stop
}
catch {
    $statusCodeValue = $_.Exception.Response.StatusCode.value__
    switch ($statusCodeValue) {
        400 {
            Write-Warning -Message "HTTP Status Code 400 Bad Request. Check the URL and try again."
        }
        401 {
            Write-Warning -Message "HTTP Status Code 401 Unauthorized."
        }
        403 {
            Write-Warning -Message "HTTP Status Code 403 Forbidden. Server may be having issues. Check the URL and try again."
        }
        404 {
            Write-Warning -Message "HTTP Status Code 404 Not found. Check the URL and try again."
        }
        500 {
            Write-Warning -Message "HTTP Status Code 500 Internal Server Error."
        }
        Default {
            throw
        }
    }
}