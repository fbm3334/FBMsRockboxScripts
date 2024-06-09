# Setup.ps1
# Setup script for the Rockbox scripts.

# Step 1 - Download and save rb-scrobbler-windows in the correct location
# (root of the user directory).
# https://github.com/jeselnik/rb-scrobbler

# Check the latest release version
$releases = Invoke-RestMethod -Uri "https://api.github.com/repos/jeselnik/rb-scrobbler/releases"
$latestMasterBuild = $releases | Select-Object -First 1
$latestVersion = $latestMasterBuild.tag_name
Write-Host "Latest version of rb-scrobbler is $latestVersion."

# Get the URL
$assetUrl = $latestMasterBuild.assets.browser_download_url
$exeUrl = $assetUrl | Where-Object { $_ -like "*rb-scrobbler-windows.exe*" }
Write-Host "The download URL is $exeUrl"

# Save the exe to the user directory
$rbScrobblerSaveLocation = $env:USERPROFILE + "\rb-scrobbler-windows.exe"
Invoke-WebRequest -Uri $exeUrl -OutFile $rbScrobblerSaveLocation
Write-Host "rb-scrobbler-windows.exe has downloaded successfully."

# Step 2 - Run the initial configuration to 