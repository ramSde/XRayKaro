# Quick Setup Guide - Email Automation

## Current Status: ❌ Python Not Installed

Your automation system is ready, but Python needs to be installed first.

## Step 1: Install Python (5 minutes)

### Option A: Automatic (Recommended)
1. Double-click `INSTALL_PYTHON_NOW.bat`
2. Follow the instructions

### Option B: Manual
1. Go to https://www.python.org/downloads/windows/
2. Download "Python 3.12.x" (latest version)
3. **IMPORTANT**: During installation, check "Add Python to PATH"
4. Click "Install Now"

## Step 2: Verify Installation
Open a NEW command prompt and run:
```bash
python --version
```
Should show: `Python 3.12.x`

## Step 3: Complete Setup
```bash
python check_requirements.py
```

## Step 4: Configure Email
1. Copy `.env.example` to `.env`
2. Edit `.env` with your Gmail credentials
3. Use Gmail App Password (not regular password)

## Step 5: Test
```bash
python test_email_setup.py
```

## Step 6: Build & Send
```bash
flutter build apk --release
```
The APK will be automatically emailed after build completes!

---

## What's Already Done ✅

- ✅ Email automation script (`send_apk.py`)
- ✅ Gradle post-build hook configured
- ✅ Security setup (.env, .gitignore)
- ✅ Requirements checker
- ✅ Test script
- ✅ All documentation

## What You Need To Do

1. **Install Python** (5 minutes)
2. **Configure .env** (2 minutes)
3. **Test & Build** (1 minute)

Total setup time: **8 minutes**