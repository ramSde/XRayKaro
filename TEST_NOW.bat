@echo off
title Test Email Automation
color 0B

echo.
echo ============================================================================
echo                    TEST EMAIL AUTOMATION
echo ============================================================================
echo.

REM Check if Python is installed
echo Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python not installed!
    echo.
    echo Please install Python first:
    echo 1. Double-click START_SETUP.bat
    echo 2. Or go to: https://www.python.org/downloads/
    echo 3. Make sure to check "Add Python to PATH"
    echo.
    pause
    exit /b 1
)

echo ✅ Python is installed!
echo.

REM Check requirements
echo Running comprehensive requirements check...
echo.
python check_requirements.py

echo.
echo ============================================================================
echo.

REM Check if .env is configured
findstr /C:"your.email@gmail.com" .env >nul 2>&1
if %errorlevel% == 0 (
    echo ⚠️  .env file needs configuration!
    echo.
    echo Please edit .env file with your actual credentials:
    echo 1. SENDER_EMAIL=your.actual.email@gmail.com
    echo 2. SENDER_PASSWORD=your_gmail_app_password
    echo 3. RECIPIENT_EMAIL=friend.actual.email@gmail.com
    echo.
    echo Gmail App Password: https://myaccount.google.com/apppasswords
    echo.
    pause
    exit /b 1
)

echo ✅ .env file is configured!
echo.

REM Test email setup
echo Testing email configuration...
echo.
python test_email_setup.py

echo.
echo ============================================================================
echo                    READY TO BUILD AND SEND!
echo ============================================================================
echo.
echo Your automation is ready! To build and send APK:
echo.
echo   flutter build apk --release
echo.
echo The APK will be automatically emailed after build completes.
echo.
pause