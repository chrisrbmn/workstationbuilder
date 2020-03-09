#--- Create a folder for tools ---
Write-Host ""
Write-Output "Creating Tools folder on C:\" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
New-Item -Path C:\tools -ItemType "directory"
New-Item -Path C:\tools -Name "TOOLS_THAT_DON'T_HAVE_INSTALLER.txt" -ItemType "file" -Value "This folder is for tools that are NOT installed via an installer. Tools that are installed via an installer should be placed in default programs location or in 'C:\bin\'"

Write-Host ""
Write-Host "Installing RSAT Tools" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
Write-Host ""
Write-Host "Updating the help file" -ForegroundColor Yellow
Write-Host "------------------------------------" -ForegroundColor Yellow
Update-Help

# Install applications not available in Chocolatey
# https://joshuachini.com/2017/10/27/automated-setup-of-a-windows-environment-using-boxstarter-and-powershell/
# ---
# https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_windows_amd64.zip
Write-Host ""
Write-Output "Downloading and Installing Terraform v0.12.23 to the C:\tools\terraform folder." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
(New-Object System.Net.WebClient).DownloadFile("https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_windows_amd64.zip","$Env:TEMP\terraform_0.12.23_windows_amd64.zip");(Expand-Archive "$Env:TEMP\terraform_0.12.23_windows_amd64.zip" -DestinationPath "C:\tools\terraform\" -Force);


Write-Host ""
Write-Output "Downloading and Installing Sysinternals to the C:\tools\sysinternals folder." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
(New-Object System.Net.WebClient).DownloadFile("https://download.sysinternals.com/files/SysinternalsSuite.zip","$Env:TEMP\SysinternalsSuite.zip");(Expand-Archive "$Env:TEMP\SysinternalsSuite.zip" -DestinationPath "C:\tools\sysinternals\" -Force);

Write-Host ""
Write-Output "Downloading and Installing PuTTY to the C:\tools\putty folder." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
(New-Object System.Net.WebClient).DownloadFile("https://the.earth.li/~sgtatham/putty/latest/w64/putty.zip","$Env:TEMP\putty.zip");(Expand-Archive "$Env:TEMP\putty.zip" -DestinationPath "C:\tools\putty\" -Force);
#
#(New-Object System.Net.WebClient).DownloadFile("https://download.teamviewer.com/download/TeamViewerPortable.zip","$Env:TEMP\TeamViewerPortable.zip");(Expand-Archive "$Env:TEMP\TeamViewerPortable.zip" -DestinationPath "$Env:USERPROFILE\AppData\Local\TeamViewerPortable\" -Force);
#(New-Object System.Net.WebClient).DownloadFile("https://typora.io/windows/typora-setup-x64.exe","$Env:TEMP\typora-setup-x64.exe");cmd /c '%TEMP%\typora-setup-x64.exe /SILENT'
# Include this if you want Xamarin installed  --add Microsoft.VisualStudio.Workload.NetCrossPlat;includeOptional
#(New-Object System.Net.WebClient).DownloadFile("https://aka.ms/vs/15/release/vs_enterprise.exe","$Env:TEMP\vs_enterprise.exe");cmd /c  'start /wait %TEMP%\vs_enterprise.exe --wait --passive --add Microsoft.VisualStudio.Workload.Azure --add Microsoft.VisualStudio.Workload.Data;includeOptional --add Microsoft.VisualStudio.Workload.NetCoreTools --add Microsoft.VisualStudio.Workload.NetWeb;includeOptional --add Microsoft.VisualStudio.Workload.Node --includeRecommended'

# https://eternallybored.org/misc/wget/releases/wget-1.20.3-win64.zip
Write-Host ""
Write-Output "Downloading and Installing Wget v1.20.3 to the C:\tools\wget folder." -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
(New-Object System.Net.WebClient).DownloadFile("https://eternallybored.org/misc/wget/releases/wget-1.20.3-win64.zip","$Env:TEMP\wget-1.20.3-win64.zip");(Expand-Archive "$Env:TEMP\wget-1.20.3-win64.zip" -DestinationPath "C:\tools\wget\" -Force);
#

Write-Host ""
Write-Host "Adding PuTTY and Sysinternal to the path" -ForegroundColor Green
Write-Host "------------------------------------" -ForegroundColor Green
setx /M PATH "$($env:path);C:\tools\putty;C:\tools\sysinternals;C:\tools\terraform;C:\tools\wget"