@echo off
reg query "HKLM\SOFTWARE\Wow6432Node\company\NVMS7000" >NUL && exit
SET hr=%time:~0,2%
SET hr=%hr: =0%
SET CURRDT=%date:~10,4%%date:~4,2%%date:~7,2%_%hr%h%time:~3,2%m%time:~6,2%s
SET installexefile="\\192.168.1.10\MSI_Installers\NVMS7000\NVMS7000.exe"
SET installissfile="\\192.168.1.10\MSI_Installers\NVMS7000\NVMS7000.iss"
SET installlogfile="\\192.168.1.10\MSI_Installers\NVMS7000\logs\%COMPUTERNAME%_%CURRDT%.log"

START /wait %installexefile% /s /sms /f1%installissfile% /f2%installlogfile%
