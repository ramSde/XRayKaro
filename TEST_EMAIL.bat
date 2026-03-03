@echo off
title Test Email Configuration
color 0A

echo.
echo ============================================================================
echo                    TEST EMAIL CONFIGURATION
echo ============================================================================
echo.

REM Check if .env is configured
findstr /C:"your.email@gmail.com" .env >nul 2>&1
if %errorlevel% == 0 (
    echo ❌ Please configure .env file first!
    echo.
    echo Edit .env file with your actual credentials:
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

echo Testing email configuration...
echo.
python test_email_setup.py

echo.
echo ============================================================================
echo.

REM Check if test was successful
if %errorlevel% == 0 (
    echo ✅ EMAIL TEST SUCCESSFUL!
    echo.
    echo Your automation is ready! To build and send APK:
    echo.
    echo   flutter build apk --release --split-per-abi
    echo   python send_apk.py
    echo.
) else (
    echo ❌ Email test failed. Please check your credentials.
    echo.
    echo Make sure you're using:
    echo 1. Gmail App Password (not regular password)
    echo 2. Correct email addresses
    echo 3. Valid App Password from: https://myaccount.google.com/apppasswords
    echo.
)

pause