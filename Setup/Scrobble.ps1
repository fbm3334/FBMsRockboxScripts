# Get the current UTC offset
$utcOffset = (Get-Date).ToUniversalTime() - (Get-Date)
$hours = ($utcOffset.Hours)

# Format the offset
$offsetString = "{0}h" -f $hours

# Display the result
Write-Output "Current UTC Offset: $offsetString"

# Run rb-scrobbler-windows - downloadable from https://github.com/jeselnik/rb-scrobbler
# This assumes that you have set it up and that it is saved in your user directory
~\rb-scrobbler-windows.exe -n delete-on-success -f .\.scrobbler.log -o $offsetString