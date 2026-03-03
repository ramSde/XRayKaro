@echo off
REM ============================================================================
REM Flutter Build and Auto-Send - Windows Batch File
REM Double-click this file to build APK and send to your friend
REM ============================================================================

echo.
echo ============================================================
echo Flutter Build ^& Auto-Send Automation
echo ============================================================
echo.

REM Run PowerShell script
powershell -ExecutionPolicy Bypass -File "%~dp0build_and_send.ps1"

echo.
pause
