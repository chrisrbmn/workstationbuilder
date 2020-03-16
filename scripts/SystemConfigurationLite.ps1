# -----------------------------------------------------------------------------
#$computerName = Read-Host 'Enter New Computer Name'
#Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
#Rename-Computer -NewName $computerName
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Disable Sleep on AC Power..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Powercfg /Change monitor-timeout-ac 20
Powercfg /Change standby-timeout-ac 0
# -----------------------------------------------------------------------------
#Set the time zone and resync the time
Write-Host ""
Write-Output "Setting the Time Zone to CST and syncing time..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-TimeZone -Name "Central Standard Time"
w32tm /resync /rediscover 
# -----------------------------------------------------------------------------
# Disable Xbox Gamebar
Write-Host ""
Write-Output "Disable XBox Gamer Bar..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Disable-GameBarTips
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0
# -----------------------------------------------------------------------------
#--- Hide Cortana via Registry bit and restart explorer ---
Write-Host ""
Write-Output "Hiding Cortana..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0
#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0
# -----------------------------------------------------------------------------
# Turn off People in Taskbar
Write-Host ""
Write-Output "Turning off People in Taskbar..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0
# -----------------------------------------------------------------------------
# Privacy: Let apps use my advertising ID: Disable
Write-Host ""
Write-Output "Disabling Advertising ID..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Restarting Explorer" -ForegroundColor Yellow
Write-Host "------------------------------------" -ForegroundColor Yellow
Stop-Process -ProcessName Explorer
# -----------------------------------------------------------------------------
if (Check-Command -cmdname 'choco') {
    Write-Host "Choco is already installed, skip installation." -ForegroundColor Yellow
}
else {
    Write-Host ""
    Write-Host "Installing Chocolatey for Windows..." -ForegroundColor Green
    Write-Host "------------------------------------" -ForegroundColor Green
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
# -----------------------------------------------------------------------------