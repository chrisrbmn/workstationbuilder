# Windows 10 SysAdmin/Engineer Machine Setup
This is a script to setup a new sysadmin/sysengineer workstation. Feel free to modify the scripts to fit your own requirements.

These scripts leverage two popular open source projects.

- Boxstarter [boxstarter.org](http://boxstarter.org)
- Chocolatey [chocolatey.org](http://chocolatey.org)

Boxstarter is a wrapper for Chocolatey and includes features like managing reboots for you. We're using the Boxstarter web launcher to start the installation process: [https://boxstarter.org/Learn/WebLauncher](https://boxstarter.org/Learn/WebLauncher)

 
## Prerequisites
- A clean install of Windows 10 Pro v1903 en-us or higher
- A stable internet connection

> This script has not been tested on older versions of Windows. Consider yourself warned.

## How to use
Run the script here by clicking this [Boxstarter Web Launcher](http://boxstarter.org/package/url?https://raw.githubusercontent.com/chrisrbmn/workstationbuilder/master/BaseBuild.ps1).

## Optional
Import "Add_PS1_Run_as_administrator.reg" to your registry to enable context menu on the powershell files to run as Administrator. The Reg file is located in the _optional_ folder.

## References
The below projects have provided examples and inspiration to this project. Please make sure to drop by their individual projects to take a look at the cool things they have done. 

-  [Microsoft - windows-dev-box-setup-scripts](https://github.com/microsoft/windows-dev-box-setup-scripts)
-  [Edi Wang - EnvSetup](https://github.com/EdiWang/EnvSetup)
-  [Joshua Chini](https://joshuachini.com/2017/10/27/automated-setup-of-a-windows-environment-using-boxstarter-and-powershell/)

## Customizing or Contributing
This script should provide most of what the infrastructure/application admin/engineer needs in his/her toolset. With that said, it is certainly possible that this script may not match your personal preferences exactly. If this case, please feel free to fork this project and make whatever changes you desire as long as you give a little credit by providing a reference link back to this project.

## Issues

- ~~Curl not installing into custom path - no longer needed, as comes from w10 1803 and newer by default.~~
- ~~lockhunter not installing into custom path~~
- ~~openssl not installing into custom path~~
- ~~nodejs not installing into custom path~~
- ~~python3 not installing into custom path~~
- ~~terraform not installing into custom path~~
- ~~wget not installing into custom path~~
- ~~Auto Reboot does work. Manually rebooting is a workaround. Script will pick up where it left off. - may be fixed by ordering windows updates first~~
- ~~HyperV not installing~~
