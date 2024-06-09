# Display introduction message
Write-Host "FBM's Rockbox Scripts"
Write-Host "2024 Finn Beckitt-Marshall"
Write-Host "Licensed under the GNU General Public License - see LICENSE for more details."

Write-Host "`nEnsure your Rockbox music player is connected to your PC."

$setupScrobbling = $false
$scrobble = Read-Host "`nDo you want to set up scrobbling to Last.fm? (Y/N)"
Switch ($scrobble)
{
    "Y" {$setupScrobbling = $true}
    "N" {Write-Host "Scrobbling setup skipped."}
}

# Set up scrobbling
if ($setupScrobbling){
    & $PSScriptRoot/Setup/ScrobbleSetup.ps1
}

# Ask the user to select the drive their Rockbox player is connected to
$drives = Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, VolumeName
$driveIndex = 1

Write-Host "Available drives:"
$drives | ForEach-Object {
    Write-Host "$driveIndex. $($_.DeviceID) - $($_.VolumeName)"
    $driveIndex++
}

$selectedDriveIndex = Read-Host "Enter the number corresponding to the drive:"
$selectedDrive = $drives[$selectedDriveIndex - 1]

if ($selectedDrive) {
    Write-Host "You selected drive $($selectedDrive.DeviceID)"
} else {
    Write-Host "Invalid selection."
}
$selectedDrive = $selectedDrive.DeviceID + "\"

if ($setupScrobbling) {
    Copy-Item -Path .\Setup\Scrobble.cmd -Destination $selectedDrive
    Copy-Item -Path .\Setup\Scrobble.ps1 -Destination $selectedDrive
    Write-Host "To scrobble from this player, navigate to the player in Windows Explorer and double click on Scrobble.cmd. The scrobbles should then be uploaded to Last.fm." -ForegroundColor Green
}