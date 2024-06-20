# Get the full path of the script itself
$scriptPath = $MyInvocation.MyCommand.Definition
$scriptName = [System.IO.Path]::GetFileName($scriptPath)
$destFolder = [System.IO.Path]::GetDirectoryName($scriptPath)

# Copy from source to dest
Get-ChildItem -Path $destFolder -File | Where-Object { $_.Name -ne $scriptName } | Remove-Item -Force
$sourcePath = "$env:LOCALAPPDATA\nvim"
Copy-Item -Path $sourcePath\* -Destination $destFolder -Recurse -Force
