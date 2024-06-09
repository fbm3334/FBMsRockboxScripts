# Setup.ps1
# Setup script for the Rockbox scripts.

# Check whether rb-scrobbler exists in the user directory - if it does, then
# ask the user whether they want to reinstall it.
$rbScrobblerSaveLocation = $env:USERPROFILE + "\rb-scrobbler-windows.exe"
$rbScrobblerExists = Test-Path -Path  $rbScrobblerSaveLocation

$downloadRbScrobbler = $false
if ($rbScrobblerExists) {
    Write-Host "rb-scrobbler already exists on your PC."
} else {
    $downloadRbScrobbler = $true
}

# If not installed, download and save rb-scrobbler-windows in the correct 
# location (root of the user directory).
# https://github.com/jeselnik/rb-scrobbler
if ($downloadRbScrobbler) {
    # Check the latest release version
    $releases = Invoke-RestMethod -Uri "https://api.github.com/repos/jeselnik/rb-scrobbler/releases"
    $latestMasterBuild = $releases | Select-Object -First 1
    $latestVersion = $latestMasterBuild.tag_name
    Write-Host "Latest version of rb-scrobbler is $latestVersion."

    # Get the URL
    $assetUrl = $latestMasterBuild.assets.browser_download_url
    $exeUrl = $assetUrl | Where-Object { $_ -like "*rb-scrobbler-windows.exe*" }

    # Save the exe to the user directory
    Write-Host "Downloading $exeUrl"
    Invoke-WebRequest -Uri $exeUrl -OutFile $rbScrobblerSaveLocation
    Write-Host "rb-scrobbler-windows.exe has downloaded successfully."
}
# Run the initial configuration to set up scrobbling
Write-Host "Running the inital setup for rb-scrobbler - follow the instructions shown below:"
& "~\rb-scrobbler-windows.exe" "-auth"

# Print a message to say that scrobbler setup is complete
Write-Host "Scrobbling set up complete."
Write-Host "You will need to enable scrobbling in Rockbox:"
Write-Host "    Settings > Playback Settings > Last.fm Log"