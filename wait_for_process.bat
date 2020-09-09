@echo off
rem ***************************************************************************************************************
rem * Wait until a process is started, errorlevel is set depending on the outcome.
rem *
rem * Parameters:
rem *     PROCESS_NAME: the name of the process to monitor
rem *     TIMEOUT: approximate timeout value. (accurate sleep is not possible in batch)
rem *
rem ***************************************************************************************************************

echo *******************************************************
echo * start %~f0
echo *

set PROCESS_NAME=%1
set TIMEOUT=%2

if "%PROCESS_NAME%" == "" (
	echo Error: Process name not specified
	goto error
)

if "%TIMEOUT%" == "" (
	set TIMEOUT=30
)

echo * PROCESS_NAME: %PROCESS_NAME%
echo * TIMEOUT: %TIMEOUT%
echo *

set COUNT=1
:search
if %COUNT% gtr %TIMEOUT% (
    echo * Error: Timeout. "%PROCESS_NAME%" was not started.
    goto error
)
tasklist /FI "IMAGENAME eq %PROCESS_NAME%" 2>NUL | find /I /N "%PROCESS_NAME%" >NUL
if "%ERRORLEVEL%"=="0" (
    goto found
)
ping 127.0.0.1 -n 2 >NUL
set /a COUNT=%COUNT% + 1
goto search

:found
echo * "%PROCESS_NAME%" was started.
exit /b

:error
exit /b 1
