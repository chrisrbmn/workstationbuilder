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
Write-Output "Setting the Time Zone to CST and syncing time..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
Set-TimeZone -Name "Central Standard Time"
w32tm /resync /rediscover 
# -----------------------------------------------------------------------------
# Disable Xbox Gamebar
Write-Host ""
Write-Output "Disable XBox Gamer Bar..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0
# -----------------------------------------------------------------------------
#--- Hide Cortana via Registry bit and restart explorer ---
Write-Host ""
Write-Output "Hiding Cortana..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0
#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0
# -----------------------------------------------------------------------------
# Turn off People in Taskbar
Write-Host ""
Write-Output "Turning off People in Taskbar..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0
# -----------------------------------------------------------------------------
# Privacy: Let apps use my advertising ID: Disable
Write-Host ""
Write-Output "Disabling Advertising ID..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Restarting Explorer" -ForegroundColor "Yellow"
Write-Host "------------------------------------" -ForegroundColor "Yellow"
Stop-Process -ProcessName Explorer
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Add 'This PC' Desktop Icon..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
$thisPCIconRegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$thisPCRegValname = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" 
$item = Get-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -ErrorAction SilentlyContinue 
if ($item) { 
    Set-ItemProperty  -Path $thisPCIconRegPath -name $thisPCRegValname -Value 0  
} 
else { 
    New-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -Value 0 -PropertyType DWORD | Out-Null  
} 
# -----------------------------------------------------------------------------
# Enable God Mode Menu
# Requires -RunAsAdministrator
if (-Not (Test-Path -Path '$env:USERPROFILE\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}' -Pathtype Container)) {
    Write-Host ""
    Write-Host "Creating GodMode Menu on Desktop..." -ForegroundColor "Green"
    Write-Host "------------------------------------" -ForegroundColor "Green"
    $godmodeSplat = @{
    Path = "$env:USERPROFILE\Desktop"
    Name = "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
    ItemType = 'Directory'
    }
    New-Item @godmodeSplat
}
else {
Write-Host "GodMode Menu already exists." -ForegroundColor "Yellow"
}
# -----------------------------------------------------------------------------
#--- Enable developer mode on the system ---
# Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Enable Remote Desktop..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name "UserAuthentication" -Value 1
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

if (Check-Command -cmdname 'choco') {
    Write-Host "Choco is already installed, skip installation." -ForegroundColor "Yellow"
}
else {
    Write-Host ""
    Write-Host "Installing Chocolatey for Windows..." -ForegroundColor "Green"
    Write-Host "------------------------------------" -ForegroundColor "Green"
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}