# PowerShell runs two pipelines: the success pipeline/success stream and the error pipeline/error stream.

# two pipelines!
Get-Process # this will generate a success pipeline
1/0; # this will generate an error pipeline; divide by zero error

# non-terminating error
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
Get-Item -Path c:\nope\nope.txt;Write-Host 'Hello, will I run after an error?'
# With ErrorAction; tell PowerShell what to do when an error occurs (ex: Stop, Continue, Ignore, SilentlyContinue)
Get-Item -Path c:\nope\nope.txt -ErrorAction Stop;Write-Host 'Hello, will I run after an error?'
