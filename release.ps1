param([switch]$major, [switch]$minor, [switch]$bug, [string]$m)

$version_file = Get-Content .\VERSION

[int]$CURRENT_MAJOR = $version_file[0].Split("=")[1]
[int]$CURRENT_MINOR = $version_file[1].Split("=")[1]
[int]$CURRENT_BUG = $version_file[2].Split("=")[1]

if ($major -eq $true) {
    $CURRENT_MAJOR++
    $CURRENT_MINOR = 0
    $CURRENT_BUG = 0
}
elseif ($minor -eq $true) {
    $CURRENT_MINOR++
    $CURRENT_BUG = 0
}
elseif ($bug -eq $true) {
    $CURRENT_BUG++
}

[string]$version = "MAJOR=$CURRENT_MAJOR`nMINOR=$CURRENT_MINOR`nBUG=$CURRENT_BUG"

$version | Out-File .\VERSION

[string]$version_travis = "$CURRENT_MAJOR.$CURRENT_MINOR.$CURRENT_BUG"

git add .\VERSION
git commit -m "Bump version to $version_travis"
git tag -a -m $m $version_travis
git push --follow-tags
