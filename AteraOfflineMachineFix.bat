@ECHO OFF
CALL :CHECK_PERMS

:SCRIPT_START
ECHO:
ECHO *******************************************
ECHO * Script:  AteraOfflineMachineFix.bat     *
ECHO * Author:  Ed Fabre                       *
ECHO * Purpose: Starts Atera Service and sets  *
ECHO *          agents heatbeats to 30 second  *
ECHO *          intervals.                     *
ECHO *******************************************
ECHO:

:EOF
EXIT /B %ERRORLEVEL%

:CHECK_PERMS
SETLOCAL
net session >nul 2>&1
if %errorLevel% == 0 (
  CALL :SCRIPT_START
) else (
  ECHO Please Run script as Administrator.
  PAUSE
  CALL :EOF
)
EXIT /B 0
