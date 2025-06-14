# hversion.ps1

function Get-HoudiniVersions {
    Get-ChildItem "C:\Program Files\Side Effects Software" -Directory |
        Where-Object { $_.Name -match "^Houdini \d+" } |
        Sort-Object Name -Descending
}

function DrawMenu {
    param (
        [array]$items,
        [int]$selectedIndex
    )

    Clear-Host
    Write-Host "Select Houdini version to set as default:`n"

    for ($i = 0; $i -lt $items.Count; $i++) {
        if ($i -eq $selectedIndex) {
            Write-Host "> $($items[$i].Name)" -ForegroundColor Cyan
        } else {
            Write-Host "  $($items[$i].Name)"
        }
    }
}

function Set-HoudiniFileAssociation {
    param (
        [string]$exePath
    )

    # Associate .hip, .hipnc, .hiplc files with selected Houdini
    $fileTypes = @(".hip", ".hipnc", ".hiplc")

    foreach ($ext in $fileTypes) {
        cmd /c "assoc $ext=HoudiniProjectFile" | Out-Null
    }

    cmd /c "ftype HoudiniProjectFile=`"$exePath`" `"%1`"" | Out-Null

    Write-Host "`nFile associations updated for .hip, .hipnc, .hiplc to use:"
    Write-Host "$exePath" -ForegroundColor Green
}

# Main
$versions = Get-HoudiniVersions
if ($versions.Count -eq 0) {
    Write-Host "No Houdini installations found." -ForegroundColor Red
    exit
}

$index = 0
$running = $true

while ($running) {
    DrawMenu -items $versions -selectedIndex $index

    $key = [Console]::ReadKey($true)

    switch ($key.Key) {
        'UpArrow'    { if ($index -gt 0) { $index-- } }
        'DownArrow'  { if ($index -lt $versions.Count - 1) { $index++ } }
        'Enter'      { $running = $false }
        'Escape'     { exit }
    }
}

$selectedVersion = $versions[$index]
$houdiniExe = Join-Path $selectedVersion.FullName "bin\houdini.exe"

if (-Not (Test-Path $houdiniExe)) {
    Write-Host "Executable not found at: $houdiniExe" -ForegroundColor Red
    exit
}

Set-HoudiniFileAssociation -exePath $houdiniExe
Write-Host "$selectedVersion selected as default version."