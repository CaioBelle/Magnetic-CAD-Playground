@echo off
setlocal
cd /d "%~dp0"

if not exist "%~dp0vendor\three\three.module.js" (
  echo.
  echo Magnetic CAD Playground is not prepared for offline use yet.
  echo Double-click Prepare_Offline.bat once while connected to the internet.
  echo.
  pause
  exit /b 2
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Offline_Server.ps1"
