@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Prepare_Offline.ps1"
if errorlevel 1 (
  echo.
  echo Offline preparation failed.
  pause
  exit /b 1
)
echo.
pause
