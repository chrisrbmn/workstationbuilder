# Description: Boxstarter/Choco build script for IT SysAdmin/Engineer base PC build.
# Author: Chris B
# https://
# Creation Date: 2020-03-04
# Last Updated: 
#
# -- Begin Windows Dev Box Setup 
# https://github.com/microsoft/windows-dev-box-setup-scripts/blob/master/dev_app.ps1
# --
# https://edi.wang/post/2018/12/21/automate-windows-10-developer-machine-setup
# The below reference detects whether it currently has administrative permissions, and if not, a UAC will pop up to request an administrator right to PowerShell and continue running the current script.
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# -----------------------------------------------------------------------------
$computerName = Read-Host 'Enter New Computer Name'
Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
Rename-Computer -NewName $computerName
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Disable Sleep on AC Power..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Powercfg /Change monitor-timeout-ac 20
Powercfg /Change standby-timeout-ac 0
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Add 'This PC' Desktop Icon..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
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
$godmodeSplat = @{
    Path = "$env:USERPROFILE\Desktop"
    Name = "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
    ItemType = 'Directory'
    }
    New-Item @godmodeSplat
# -----------------------------------------------------------------------------
#Write-Host ""
#Write-Host "Removing Edge Desktop Icon..." -ForegroundColor Green
#Write-Host "------------------------------------" -ForegroundColor Green
#$edgeLink = $env:USERPROFILE + "\Desktop\Microsoft Edge.lnk"
#Remove-Item $edgeLink
# -----------------------------------------------------------------------------
# To list all appx packages:
# Get-AppxPackage | Format-Table -Property Name,Version,PackageFullName
Write-Host "Removing UWP Rubbish..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
$uwpRubbishApps = @(
    "king.com.CandyCrushSaga",
    "Fitbit.FitbitCoach",
    "4DF9E0F8.Netflix")

foreach ($uwp in $uwpRubbishApps) {
    Get-AppxPackage -Name $uwp | Remove-AppxPackage
}
# -----------------------------------------------------------------------------
#Write-Host ""
#Write-Host "Installing IIS..." -ForegroundColor Green
#Write-Host "------------------------------------" -ForegroundColor Green
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument -All
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionDynamic -All
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic -All
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets -All
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit -All
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45 -All
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-ServerSideIncludes
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
# -----------------------------------------------------------------------------
#Write-Host ""
#Write-Host "Enable Windows 10 Developer Mode..." -ForegroundColor Green
#Write-Host "------------------------------------" -ForegroundColor Green
#reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "Enable Remote Desktop..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name "UserAuthentication" -Value 1
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

if (Check-Command -cmdname 'choco') {
    Write-Host "Choco is already installed, skip installation."
}
else {
    Write-Host ""
    Write-Host "Installing Chocolatey for Windows..." -ForegroundColor Green
    Write-Host "------------------------------------" -ForegroundColor Green
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

Write-Host ""
Write-Host "Installing Applications..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Write-Host "[WARN] Ma de in China: some software like Google Chrome require the true Internet first" -ForegroundColor Yellow

if (Check-Command -cmdname 'git') {
    Write-Host "Git is already installed, checking new version..."
    choco update git -y
}
else {
    Write-Host ""
    Write-Host "Installing Git for Windows..." -ForegroundColor Green
    choco install git -y
}

if (Check-Command -cmdname 'node') {
    Write-Host "Node.js is already installed, checking new version..."
    choco update nodejs -y
}
else {
    Write-Host ""
    Write-Host "Installing Node.js..." -ForegroundColor Green
    choco install nodejs -y
}

choco install 7zip.install -y
choco install googlechrome -y
choco install potplayer -y
choco install dotnetcore-sdk -y
choco install ffmpeg -y
choco install curl -y
choco install wget -y
choco install openssl.light -y
choco install vscode -y
choco install vscode-csharp -y
choco install vscode-icons -y
choco install vscode-mssql -y
choco install vscode-powershell -y
choco install sysinternals -y
choco install notepadplusplus.install -y
choco install dotpeek -y
choco install linqpad -y
choco install fiddler -y
choco install beyondcompare -y
choco install filezilla -y
choco install lightshot.install -y
choco install microsoft-teams.install -y
choco install teamviewer -y
choco install github-desktop -y

Write-Host "------------------------------------" -ForegroundColor Green
Read-Host -Prompt "Setup is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer