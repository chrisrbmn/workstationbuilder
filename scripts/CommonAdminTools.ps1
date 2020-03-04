Write-Host ""
Write-Host "Installing Common Admin Applications..." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Write-Host "[WARN] If in China: some software like Google Chrome require the true Internet first" -ForegroundColor Yellow

#--- Create a folder for tools ---
Write-Host ""
Write-Output "Creating BIN folder on C:\" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
New-Item -Path C:\bin -ItemType "directory"

if (Check-Command -cmdname 'git') {
    Write-Host "Git is already installed, checking new version..."
    choco update git -y
}
else {
    Write-Host ""
    Write-Host "Installing Git for Windows..." -ForegroundColor Green
    choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
}

if (Check-Command -cmdname 'node') {
    Write-Host "Node.js is already installed, checking new version..."
    choco update nodejs -y
}
else {
    Write-Host ""
    Write-Host "Installing Node.js..." -ForegroundColor Green
    choco install nodejs -y --params "/InstallDir:C:\bin\nodejs"
}

choco install 7zip.install -y
choco install chocolatey-core.extension -y
choco install paint.net -y
#choco install dotnetcore-sdk -y
choco install winscp -y
choco install glogg -y
choco install curl -y --params "/InstallDir:C:\bin\curl"
choco install wget -y --params "/InstallDir:C:\bin\wget"
choco install openssl.light -y --params "/InstallDir:C:\bin\openssl"
choco install wget -y --params "/InstallDir:C:\bin\lockhunter"
choco install vscode -y
choco install vscode-csharp -y
choco install vscode-icons -y
choco install vscode-mssql -y
choco install vscode-powershell -y
choco install softerraldapbrowser -y
choco install notepadplusplus.install -y
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

# tools we expect devs across many scenarios will want
choco install -y vscode
#choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
#choco install -y python
choco install -y python3 --params "/InstallDir:C:\bin\python3"
#choco install -y 7zip.install
#choco install -y sysinternals
