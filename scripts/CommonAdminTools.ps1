Write-Host ""
Write-Host "Installing Common Admin Applications..." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"

if (Check-Command -cmdname 'git') {
    Write-Host "Git is already installed, checking new version..."
    choco update git -y
}
else {
    Write-Host ""
    Write-Host "Installing Git for Windows..." -ForegroundColor "Green"
    choco install -y git.install --params "/GitAndUnixToolsOnPath /WindowsTerminal"
}

choco install 7zip.install -y
choco install chocolatey-core.extension -y
choco install paint.net -y
#choco install dotnetcore-sdk -y
choco install winscp -y
choco install glogg -y
choco install vscode -y
choco install vscode-csharp -y
choco install vscode-icons -y
choco install vscode-mssql -y
choco install vscode-powershell -y
choco install softerraldapbrowser -y
choco install notepadplusplus.install -y
choco install sql-server-management-studio -y
#choco install visualstudio2019community -y
#choco install dotpeek -y
#choco install linqpad -y
#choco install fiddler -y
choco install winmerge -y
choco install windirstat -y
choco install filezilla -y
#choco install lightshot.install -y
choco install rdcman -y
#choco install teamviewer -y
choco install github-desktop -y

#--- Create a folder for bin installs ---
Write-Host ""
Write-Output "Creating BIN folder on C:\" -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"
New-Item -Path C:\bin -ItemType "directory"

# Tools with installers placed in the BIN folder.
Write-Host ""
Write-Output "Installing Special Apps into C:\bin folder." -ForegroundColor "Green"
Write-Host "------------------------------------" -ForegroundColor "Green"

if (Check-Command -cmdname 'node') {
    Write-Host "Node.js is already installed, checking new version..."
    choco update nodejs -y
}
else {
    Write-Host ""
    Write-Host "Installing Node.js..." -ForegroundColor "Green"
    choco install nodejs -y --params "/InstallDir:C:\bin\nodejs"
}

choco install openssl.light -y --params "/InstallDir:C:\bin\openssl"
choco install wget -y --params "/InstallDir:C:\bin\lockhunter"
choco install curl -y --params "/InstallDir:C:\bin\curl"
choco install wget -y --params "/InstallDir:C:\bin\wget"

#choco install -y python
choco install -y python3 --params "/InstallDir:C:\bin\python3"