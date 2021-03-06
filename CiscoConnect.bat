@echo off 
echo *******************************************************
echo * start %~f0
echo *******************************************************
echo.
echo *******************************************************
set "LAUNCH_DIR=%~dp0"
echo Launch_Directory : %LAUNCH_DIR%
echo *******************************************************
echo.
echo.
echo *******************************************************
set "CURRENT_DIR=%CD%"
echo Current_Directory : %CURRENT_DIR%
echo *******************************************************
echo.
echo.

echo *******************************************************
set "VPN_CLIENT_EXE_PATH="C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client""
echo VPN Cisco Client Executable Path : %VPN_CLIENT_EXE_PATH%
echo *******************************************************
echo.

echo.
echo **** Cisco AnyConnect Secure VPN Connection Connecting *************
echo Running Command "%VPN_CLIENT_EXE_PATH%\vpncli.exe -s < %CURRENT_DIR%\CiscoLoginInfo.bat"
echo.
%VPN_CLIENT_EXE_PATH%\vpncli.exe -s < %CURRENT_DIR%\CiscoLoginInfo.bat
echo.
echo %ERRORLEVEL%
IF "%ERRORLEVEL%" == "0" ( 
	echo ===============================================
	echo **** Cisco Client Connect sucsessfully ***
	echo ===============================================
	TIMEOUT /T 6
	exit /b 0
) ELSE (
  echo ===================================
  echo **** Cisco Client Connect Failed ***
  echo ===================================
  pause
  exit /b 1
)