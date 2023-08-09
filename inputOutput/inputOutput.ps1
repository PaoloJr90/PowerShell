# Dynamic Inputs and Outputs using PowerShell

#retrieve dynamic content from a website
$webResults = Invoke-WebRequest -Uri 'https://reddit.com/r/powershell.json' # retrieve the JSON data from the website
$rawJSON = $webResults.Content # retrieve the content from the JSON data
$objData = $rawJSON | ConvertFrom-Json # convert the JSON data to a PowerShell object
$posts = $objData.data.children.data # retrieve the data from the children of the object
$posts | Select-Object Title,Score | Sort-Object Score -Descending

#--------------------------------------------------------------------------------

# Read-Host Input cmdlet to prompt the user for input; using similar code as above
[int]$numPosts = Read-Host -Prompt "Enter the number of posts to read"
$posts | Select-Object Title,url | Sort-Object Score -Descending | Select-Object -First $numPosts

# Another example of using Read-Host
[int]$numFacts = Read-Host -Prompt "Enter the number of cat facts you would like"
$webResults = Invoke-RestMethod -Uri "https://catfact.ninja/facts?limit=$numFacts&max_length=140"
$webResults.data

#--------------------------------------------------------------------------------

#Get-Content
$logContent = Get-Content C:\Users\pjang\OneDrive\Documents\GitHub\PowerShell\inputOutput\SampleLog.log
# -Raw parameter to get the entire file as a single string; cannot parse the raw data (using -Raw) as with the above example
$raw = Get-Content C:\Users\pjang\OneDrive\Documents\GitHub\PowerShell\inputOutput\SampleLog.log -Raw
$raw | Select-String -Pattern "ERROR"
$logContent | Select-String -Pattern "ERROR"
# get just entries that have an IP address using regex
$regex = "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
$logContent | Select-String -Pattern $regex -AllMatches
# get just entries that have an IP address using Where-Object
$logContent | Where-Object {$_ -like "*.*.*.*"}
# Get-Content from .csv file
$rawCSVInput = Get-Content C:\Users\pjang\OneDrive\Documents\GitHub\PowerShell\inputOutput\csv.csv
$objData = $rawCSVInput | ConvertFrom-Csv


