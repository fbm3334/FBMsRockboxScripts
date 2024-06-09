# Display introduction message
Write-Host "FBM's Rockbox Scripts"
Write-Host "2024 Finn Beckitt-Marshall"
Write-Host "Licensed under the GNU General Public License - see LICENSE for more details."

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
