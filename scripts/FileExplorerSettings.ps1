#--- Configuring Windows properties ---
#--- Windows Features ---

# -----------------------------------------------------------------------------
# Show hidden files, Show protected OS files, Show file extensions
Write-Host ""
Write-Output "Showing hidden files, protected OS files, and file extensions..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
# -----------------------------------------------------------------------------
#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
Write-Host ""
Write-Output "Setting the explorer to the actual folder you're in..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
# -----------------------------------------------------------------------------
# adds things back in your left pane like recycle bin
Write-Host ""
Write-Output "Adding things in your left pane like recycle bin..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
# -----------------------------------------------------------------------------
# opens PC to This PC, not quick access
Write-Host ""
Write-Output "Setting the open PC to This PC, not quick access..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
# -----------------------------------------------------------------------------
# taskbar where window is open for multi-monitor
Write-Host ""
Write-Output "Setting the taskbar where window is open for multi-monitor..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2
# -----------------------------------------------------------------------------

