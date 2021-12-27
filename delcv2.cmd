@echo off

::config
if not exist %~dp0\config.bat goto :mkconfig
if exist %~dp0\config.bat goto :start

:start
title delC
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
call %~dp0\config.bat
if %automode%==true (
goto :automode
)
if %automode%==false (
goto :manual
)
exit

:manual
color 4
set drive=
set mode=
set confirm=
::code
:N
cls
echo enter wich directory / drive you want to erase
set/p drive=enter drive:
echo you sure that you want to delete ; %drive% ; (Y;N)
set/p confirm=confirm:
if %confirm%==N (
goto :N
)
if %confirm%==Y (
goto :Y
)

:Y
echo modes: automatic (enter auto),smart,nuke
set/p mode=
if %mode%==auto (
goto :automatic
)
if %mode%==smart (
goto :smart
)
if %mode%==nuke (
goto :nuke
)
:automode
::AUTOMATIC  _____________________________________________________________________
:N2
cls

if %confirm%==N (
goto :N2
)
if %confirm%==Y (
goto :Y2
)

:Y2
if %mode%==auto (
goto :automatic
)
if %mode%==smart (
goto :smart
)
if %mode%==nuke (
goto :nuke
)

::delete
:automatic
echo 1
pause
exit

:smart
echo 2
pause
exit

:nuke
del /S /q %drive%\*
pause
exit

:mkconfig
echo set automode=false>> %~dp0\config.bat
echo set drive=>> %~dp0\config.bat
echo set confirm=N>> %~dp0\config.bat
echo set mode=>> %~dp0\config.bat
goto :start