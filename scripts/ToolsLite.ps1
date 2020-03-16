# Unmodified choco installs
# -------------------------
Write-Host ""
Write-Output "Installing 7zip..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install 7zip.install -y
# -----------------------------------------------------------------------------
Write-Host ""
Write-Output "Installing Notepad++..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install notepadplusplus.install -y
# -----------------------------------------------------------------------------
Write-Host ""
Write-Output "Installing VLC..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
choco install vlc -y
# -----------------------------------------------------------------------------