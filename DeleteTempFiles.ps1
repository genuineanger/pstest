# DeleteTempFiles.ps1
# This script deletes temporary files from Windows Temp and User Temp folders.

# Function to delete files and folders in a given path
function Clear-TempFolder {
    param (
        [string]$Path
    )

    if (Test-Path $Path) {
        Write-Host "Cleaning: $Path" -ForegroundColor Cyan
        try {
            # Remove files
            Get-ChildItem -Path $Path -File -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
            
            # Remove folders
            Get-ChildItem -Path $Path -Directory -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        }
        catch {
            Write-Warning "Error cleaning $Path: $_"
        }
    } else {
        Write-Warning "$Path does not exist."
    }
}

# Clean Windows Temp folder
Clear-TempFolder -Path "C:\Windows\Temp"

# Clean the current user's Temp folder
Clear-TempFolder -Path $env:TEMP

Write-Host "Temporary files cleanup complete!" -ForegroundColor Green
