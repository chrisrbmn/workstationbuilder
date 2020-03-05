Write-Host ""
Write-Host "Installing HyperV..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor "Green"
choco install -y Microsoft-Hyper-V-All --source="'windowsFeatures'"