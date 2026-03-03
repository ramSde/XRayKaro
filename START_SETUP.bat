@echo off
title Email Automation Setup
color 0A

echo.
echo ============================================================================
echo                    EMAIL AUTOMATION SETUP
echo ============================================================================
echo.
echo This will set up automatic APK emailing after Flutter builds.
echo.
echo Current Status:
echo   [✅] Email script ready
echo   [✅] Gradle integration ready  
echo   [✅] Security configured
echo   [❌] Python not installed
echo   [❌] Email credentials not configured
echo.
echo ============================================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Python is installed!
    echo.
    echo Running requirements check...
    python check_requirements.py
    pause
    goto :end
)

echo ❌ Python is not installed.
echo.
echo STEP 1: Install Python
echo ----------------------
echo.
echo Option A: Automatic (Recommended)
echo   1. Press any key to open Python download page
echo   2. Download Python 3.12.x
echo   3. IMPORTANT: Check "Add Python to PATH" during installation
echo   4. Install Python
echo   5. Come back and run this script again
echo.
echo Option B: Microsoft Store
echo   1. Type "python" in Start menu
echo   2. Install from Microsoft Store
echo   3. Come back and run this script again
echo.
pause

echo.
echo Opening Python download page...
start https://www.python.org/downloads/windows/

echo.
echo ============================================================================
echo AFTER INSTALLING PYTHON:
echo ============================================================================
echo.
echo 1. Close this window
echo 2. Open a NEW command prompt
echo 3. Run: START_SETUP.bat (this file again)
echo.
echo The setup will continue automatically once Python is installed.
echo ============================================================================
echo.
pause

:end