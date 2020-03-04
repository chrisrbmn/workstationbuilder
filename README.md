## Windows 10 SysAdmin/Engineer Machine Setup
This is the script to setup a new sysadmin workstation. You can modify the scripts to fit your own requirements.

These scripts leverage two popular open source projects.

- Boxstarter [boxstarter.org](http://boxstarter.org)
- Chocolatey [chocolatey.org](http://chocolatey.org)

Boxstarter is a wrapper for Chocolatey and includes features like managing reboots for you. We're using the Boxstarter web launcher to start the installation process: [https://boxstarter.org/Learn/WebLauncher](https://boxstarter.org/Learn/WebLauncher)

 
# Prerequisites
- A clean install of Windows 10 Pro v1903 en-us or higher
- A stable internet connection

> This script has not been tested on older version of Windows. Consider yourself warned.

# How to use
Run the script here by clicking this [Boxstarter Web Launcher](http://boxstarter.org/package/url?https://raw.githubusercontent.com/chrisrbmn/workstationbuilder/master/BaseBuild.ps1).

# Optional
Import "Add_PS1_Run_as_administrator.reg" to your registry to enable context menu on the powershell files to run as Administrator. The Reg file is located in the _optional_ folder.
