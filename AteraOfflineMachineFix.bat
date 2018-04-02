@ECHO OFF
COLOR 9f

CALL :CHECK_PERMS
EXIT /B 0

REM FUNCTION START
REM This function executes the script.
:SCRIPT_START
REM Script Variables
Set ServiceName=AteraAgent
Set HeartBeatInterval=30

ECHO:
ECHO *******************************************
ECHO * Script:  AteraOfflineMachineFix.bat     *
ECHO * Version: 1.0                            *
ECHO * Date:    4/2/2018                       *
ECHO * Author:  Ed Fabre                       *
ECHO * Purpose: Starts Atera Service and sets  *
ECHO *          agents heatbeats to 30 second  *
ECHO *          intervals.                     *
ECHO *******************************************
ECHO:

REM This will set startup type to automatic
CALL SC config "AteraAgent" start= auto >NUL && (echo AteraAgent Service startup mode set to Automatic) || (echo Failed to configure startup type)

REM This will start the service
SC queryex "%ServiceName%"|Find "STATE"|Find /v "RUNNING">Nul&&(
    echo %ServiceName% Service not running
    echo %ServiceName% Service Starting

    Net start %ServiceName% >nul||(
        Echo %ServiceName% Service wont start
    )
    echo %ServiceName% Service Has been Started
)||(
    echo %ServiceName% Service Already is Working
)

REM This will set the atera heartbeat to 30 second intervals
REG QUERY "HKLM\SOFTWARE\ATERA Networksvv\AlphaAgent" /v HeartBeatInterval >nul 2> nul
IF %ERRORLEVEL% == 0 (
  ECHO AteraAgent HeartBeatInterval already set
) ELSE (
  REG ADD "HKLM\SOFTWARE\ATERA Networksvv\AlphaAgent" /v HeartBeatInterval /t REG_DWORD /d 30 >NUL
  ECHO AteraAgent HeartBeatInterval set to %HeartBeatInterval% seconds
)
CALL :EOF
EXIT /B 0
REM FUNCTION END


REM FUNCTION START
REM This function represents what happens at the end of a script
:EOF
ECHO:
IF %errorLevel% == 0 (
  ECHO Script Successfully Executed
  PAUSE
) ELSE (
  ECHO Error occured with code %ERRORLEVEL%
  PAUSE
)
EXIT /B 0
REM FUNCTION END


REM FUNCTION START
REM This function checks if this app is being run as admin.
:CHECK_PERMS
SETLOCAL
net session >nul 2>&1
if %errorLevel% == 0 (
  CALL :SCRIPT_START
  EXIT /B 0
) else (
  ECHO Please Run script as Administrator.
  CALL :EOF
)
EXIT /B 0
REM FUNCTION END
