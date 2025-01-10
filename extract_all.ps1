# PowerShell script to unzip all files from a source folder into a single destination folder

param (
    [string]$SourceFolder,  # Path to the folder containing zip files
    [string]$DestinationFolder  # Path to the destination folder where files will be unzipped
)

# Check if source and destination folders are provided
if (-not (Test-Path $SourceFolder)) {
    Write-Host "Error: Source folder does not exist." -ForegroundColor Red
    exit 1
}

# Create destination folder if it doesn't exist
if (-not (Test-Path $DestinationFolder)) {
    New-Item -ItemType Directory -Path $DestinationFolder | Out-Null
}

# Get all .zip files in the source folder
$zipFiles = Get-ChildItem -Path $SourceFolder -Filter "*.zip"

if ($zipFiles.Count -eq 0) {
    Write-Host "No zip files found in $SourceFolder." -ForegroundColor Yellow
    exit 0
}

# Iterate over each zip file and extract contents to the destination folder
foreach ($zipFile in $zipFiles) {
    try {
        Write-Host "Unzipping $($zipFile.FullName)..." -ForegroundColor Cyan
        Expand-Archive -Path $zipFile.FullName -DestinationPath $DestinationFolder -Force
        Write-Host "$($zipFile.Name) unzipped successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to unzip $($zipFile.FullName): $_" -ForegroundColor Red
    }
}

Write-Host "All zip files have been unzipped to $DestinationFolder." -ForegroundColor Green
