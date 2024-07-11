# Run from Git repo

# Get the full path of the script itself
$scriptPath = $MyInvocation.MyCommand.Definition
$scriptFolder = (Split-Path -Parent $scriptPath)
$scriptName = [System.IO.Path]::GetFileName($scriptPath)

Write-Host "[1] Move file from dotfile (remote) to %localappdata% (local)"
Write-Host "[2] Move file from %localappdata% (local) to dotfile (remote)"

$option = Read-Host "Option"

while ($option -ne 1 -and $option -ne 2){
    Write-Host "Option not valid. Please re-enter"
    $option = Read-Host "Option"
}

if ($option -eq 1){
    $confirm = Read-Host "Confirm? [Y/n]"
    if ($confirm -eq "Y"){
        $srcFolder = (Split-Path -Parent $scriptFolder)
        $destFolder = "$env:LOCALAPPDATA\nvim"
        Write-Host "Removing files from $destFolder" -ForegroundColor Red
        Get-ChildItem -Path $destFolder -Recurse | Remove-Item -Recurse -Force
        Write-Host "Copy from $srcFolder to $destFolder" -ForegroundColor Green
        Copy-Item -Path $srcFolder\* -Destination $destFolder -Recurse -Force
    } else {
        Write-Host "Abort"
    }
} elseif ($option -eq 2){
    $confirm = Read-Host "Confirm? [Y/n]"
    if ($confirm -eq "Y"){
        $srcFolder = "$env:LOCALAPPDATA\nvim"
        $destFolder = (Split-Path -Parent $scriptFolder)
        Write-Host "Removing files from $destFolder" -ForegroundColor Red
        Get-ChildItem -Path $destFolder | Where-Object { $_.FullName -ne $scriptFolder } | Remove-Item -Recurse -Force
        Write-Host "Copy from $srcFolder to $destFolder" -ForegroundColor Green 
        Copy-Item -Path "$srcFolder\*" -Destination $destFolder -Recurse -Force -Exclude "scripts"
    } else {
        Write-Host "Abort"
    }
}

Write-Host "Done"
Read-Host "Press Enter to exit"
