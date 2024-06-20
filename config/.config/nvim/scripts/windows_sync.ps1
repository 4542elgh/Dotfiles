# Run from Git repo

# Get the full path of the script itself
$scriptPath = $MyInvocation.MyCommand.Definition
$scriptFolder = (Split-Path -Parent $scriptPath)
$scriptName = [System.IO.Path]::GetFileName($scriptPath)

Write-Host "[1] Move file from dotfile to %localappdata%"
Write-Host "[2] Move file from %localappdata% to dotfile"

$option = Read-Host "Option"

while ($option -ne 1 -and $option -ne 2){
    Write-Host "Option not valid. Please re-enter"
    $option = Read-Host "Option"
}

if ($option -eq 1){
    $srcFolder = (Split-Path -Parent $scriptFolder)
    $destFolder = "$env:LOCALAPPDATA\nvim"
    Get-ChildItem -Path $destFolder -Recurse | Remove-Item -Recurse -Force
    Copy-Item -Path $srcFolder\* -Destination $destFolder -Recurse -Force
} elseif ($option -eq 2){
    $srcFolder = "$env:LOCALAPPDATA\nvim"
    $destFolder = (Split-Path -Parent $scriptFolder)
    Get-ChildItem -Path $destFolder | Where-Object { $_.FullName -ne $scriptFolder } | Remove-Item -Recurse -Force
    Copy-Item -Path "$srcFolder\*" -Destination $destFolder -Recurse -Force -Exclude "scripts"
}

