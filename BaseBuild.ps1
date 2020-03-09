# Description: Boxstarter/Choco build script for IT SysAdmin/Engineer base PC build.
# Author: Chris B
# https://github.com/chrisrbmn/workstationbuilder
# Creation Date: 2020-03-04
# Last Updated: 
#
# Reference Author: Microsoft
# Common settings for azure devops
# https://github.com/chrisrbmn/windows-dev-box-setup-scripts/blob/master/devops_azure.ps1
# 
# Reference Author: Edi Wang
# https://edi.wang/post/2018/12/21/automate-windows-10-developer-machine-setup
# https://github.com/EdiWang/EnvSetup
#
# The below reference detects whether it currently has administrative permissions, and if not, a UAC will pop up to request an administrator right to PowerShell and continue running the current script.
#if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
#
function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula -GetUpdatesFromMS

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "Browsers.ps1";
executeScript "CommonAdminTools.ps1";
executeScript "Tools.ps1";
executeScript "HyperV.ps1";
RefreshEnv
#executeScript "WSL.ps1";
#RefreshEnv
#executeScript "Docker.ps1";
executeScript "Azure.ps1";

# Install tools in WSL instance
#write-host "Installing tools inside the WSL distro..."
#Ubuntu1804 run apt install python2.7 python-pip -y 
#Ubuntu1804 run apt install python-numpy python-scipy -y
#Ubuntu1804 run pip install pandas
#Ubuntu1804 run apt install ansible -y
#write-host "Finished installing tools inside the WSL distro"


# Clean up trash.
Remove-Item "$env:USERPROFILE\Desktop\*.ini" -Force

Enable-UAC

Write-Host "------------------------------------" -ForegroundColor Red
Read-Host -Prompt "Setup is done, restart is needed, press [ENTER] to restart computer."
#Restart-Computer