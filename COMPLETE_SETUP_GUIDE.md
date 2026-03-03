# 🎯 Complete Setup Guide - Everything You Need

## 📋 Table of Contents

1. [Requirements Check](#requirements-check)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Testing](#testing)
5. [Usage](#usage)
6. [Verification](#verification)

---

## 1. Requirements Check

### Quick Check (30 seconds)

**Double-click:** `CHECK_SETUP.bat`

Or run:
```bash
python check_requirements.py
```

**What it checks:**
- ✅ Python 3.6+ installed
- ✅ pip installed
- ✅ python-dotenv installed
- ✅ .env file exists and configured
- ✅ .gitignore protects .env
- ✅ Flutter installed
- ✅ Gradle integration configured
- ✅ Network connectivity to Gmail SMTP
- ✅ APK file exists (if built)

---

### Required Software

| Software | Version | Check Command | Install Link |
|----------|---------|---------------|--------------|
| Python | 3.6+ | `python --version` | https://www.python.org/downloads/ |
| pip | Any | `pip --version` | Comes with Python |
| python-dotenv | Any | `pip list \| grep python-dotenv` | `pip install python-dotenv` |
| Flutter | Any | `flutter --version` | https://flutter.dev/docs/get-started/install |

---

### Required Accounts

| Account | Purpose | Setup Link |
|---------|---------|------------|
| Gmail Account | Send emails | https://gmail.com |
| 2-Step Verification | Required for App Password | https://myaccount.google.com/security |
| Gmail App Password | SMTP authentication | https://myaccount.google.com/apppasswords |

---

## 2. Installation

### Step 1: Install Python (if needed)

**Windows:**
1. Download: https://www.python.org/downloads/
2. Run installer
3. ✅ **IMPORTANT:** Check "Add Python to PATH"
4. Click "Install Now"
5. Restart terminal

**Verify:**
```bash
python --version
```

**Expected:** `Python 3.x.x`

---

### Step 2: Install python-dotenv

```bash
pip install python-dotenv
```

**Verify:**
```bash
pip list | grep python-dotenv
```

**Expected:** `python-dotenv    x.x.x`

---

### Step 3: Run Automated Setup

```powershell
.\setup_automation.ps1
```

**What it does:**
1. ✅ Checks Python installation
2. ✅ Installs python-dotenv (if needed)
3. ✅ Creates .env file from template
4. ✅ Opens .env for editing
5. ✅ Provides setup instructions

---

## 3. Configuration

### Step 1: Get Gmail App Password

1. **Enable 2-Step Verification:**
   - Visit: https://myaccount.google.com/security
   - Enable 2-Step Verification

2. **Create App Password:**
   - Visit: https://myaccount.google.com/apppasswords
   - Sign in to Gmail
   - Click "Select app" → Choose "Mail"
   - Click "Select device" → Choose "Windows Computer"
   - Click "Generate"
   - Copy the 16-character code (e.g., "abcd efgh ijkl mnop")

**Important:** This is NOT your regular Gmail password!

---

### Step 2: Configure .env File

**If not created by setup script:**
```bash
cp .env.example .env
```

**Edit .env:**
```bash
notepad .env
```

**Update these values:**
```
SENDER_EMAIL=your.email@gmail.com
SENDER_PASSWORD=abcd efgh ijkl mnop
RECIPIENT_EMAIL=friend.email@gmail.com
```

**Replace with:**
- `SENDER_EMAIL`: Your Gmail address
- `SENDER_PASSWORD`: App Password from Step 1 (16 characters)
- `RECIPIENT_EMAIL`: Friend's email address

**Save the file.**

---

### Step 3: Verify .gitignore

```bash
cat .gitignore | grep ".env"
```

**Expected output:**
```
.env
.env.local
.env.*.local
```

**If missing, add to .gitignore:**
```
.env
.env.local
.env.*.local
```

---

## 4. Testing

### Step 1: Test Email Configuration

```bash
python test_email_setup.py
```

**Expected output:**
```
✅ Loaded configuration from .env file
✅ Sender: your.email@gmail.com
✅ Recipient: friend.email@gmail.com
🔐 Connecting to Gmail SMTP server...
✅ Authentication successful!
📤 Sending test email...
✅ Test email sent successfully!

============================================================
✅ SUCCESS! Your email configuration is working!
============================================================
```

**If errors occur:**
- Check `REQUIREMENTS.md` for troubleshooting
- Verify App Password is correct
- Check internet connection

---

### Step 2: Verify Requirements

```bash
python check_requirements.py
```

**Expected output:**
```
============================================================
  Summary
============================================================

Total Checks: 9
✅ Passed: 9
❌ Failed: 0

🎉 All checks passed! You're ready to use the automation.
```

---

## 5. Usage

### Method 1: Automatic (Recommended)

Just build normally - email sends automatically:

```bash
flutter build apk --release
```

**What happens:**
1. ✅ Flutter builds APK (2-3 minutes)
2. ✅ Gradle post-build hook triggers
3. ✅ Python script reads .env
4. ✅ Connects to Gmail SMTP (TLS encrypted)
5. ✅ Sends email with APK attached
6. ✅ Friend receives email
7. ✅ Build completes

**Output:**
```
> Task :app:assembleRelease
✅ APK built successfully

> Task :app:sendApkEmail
✅ Loaded configuration from .env file
✅ Found APK: build/app/outputs/flutter-apk/app-release.apk
📦 File size: 46.11 MB
📧 Creating email message...
📎 Attaching APK file...
🔐 Connecting to Gmail SMTP server...
🔑 Logging in...
📤 Sending email...
✅ SUCCESS! Email sent successfully!
   To: friend.email@gmail.com
   Attachment: app-release.apk (46.11 MB)

BUILD SUCCESSFUL
```

---

### Method 2: Manual (Alternative)

**If you want to send existing APK:**

```bash
python send_apk.py
```

---

### Method 3: PowerShell Script (Alternative)

**Build and send in one command:**

```powershell
.\build_and_send.ps1
```

---

## 6. Verification

### Check 1: .env Not in Git

```bash
git status
```

**Verify:** `.env` should NOT appear in the list

**If it appears:**
```bash
git rm --cached .env
git commit -m "Remove .env from tracking"
```

---

### Check 2: Friend Receives Email

**Ask your friend to check:**
- ✅ Email received
- ✅ Subject: "X-Ray Body Scanner - New Build Ready for Testing"
- ✅ APK attached (app-release.apk)
- ✅ Can download APK
- ✅ Can install APK

---

### Check 3: APK Installs on Device

**Friend should:**
1. Download APK from email
2. Enable "Install from Unknown Sources"
3. Install APK
4. Open app
5. Test all features

---

## 📊 Complete Checklist

### Pre-Setup:
- [ ] Python 3.6+ installed
- [ ] pip installed
- [ ] Flutter installed
- [ ] Gmail account created
- [ ] 2-Step Verification enabled

### Setup:
- [ ] Ran `setup_automation.ps1`
- [ ] python-dotenv installed
- [ ] .env file created
- [ ] Gmail App Password obtained
- [ ] .env configured with credentials
- [ ] .env protected by .gitignore

### Testing:
- [ ] Ran `python check_requirements.py` - all passed
- [ ] Ran `python test_email_setup.py` - success
- [ ] Test email received by friend
- [ ] Built APK: `flutter build apk --release`
- [ ] Email sent automatically
- [ ] Friend received APK via email

### Verification:
- [ ] .env NOT in `git status`
- [ ] APK installs on device
- [ ] App runs correctly
- [ ] All features working

---

## 🆘 Troubleshooting

### Issue: "Python not found"

**Solution:**
1. Install Python: https://www.python.org/downloads/
2. Check "Add Python to PATH" during installation
3. Restart terminal
4. Verify: `python --version`

---

### Issue: "python-dotenv not found"

**Solution:**
```bash
pip install python-dotenv
```

---

### Issue: "Configuration not found"

**Solution:**
```bash
# Create .env from template
cp .env.example .env

# Edit with your credentials
notepad .env
```

---

### Issue: "Authentication failed"

**Solution:**
1. Get new App Password: https://myaccount.google.com/apppasswords
2. Update .env file with new password
3. Test: `python test_email_setup.py`

---

### Issue: "Cannot connect to smtp.gmail.com"

**Solution:**
1. Check internet connection
2. Check firewall settings
3. Try disabling VPN temporarily
4. Verify port 587 is not blocked

---

### Issue: ".env committed to Git"

**Solution:**
```bash
# Remove from Git tracking
git rm --cached .env

# Commit the removal
git commit -m "Remove .env from tracking"

# Verify .gitignore
cat .gitignore | grep ".env"
```

---

## 📚 Documentation Reference

### Quick Start:
- **START_HERE.md** - Main entry point
- **REQUIREMENTS.md** - Detailed requirements
- **SETUP_AUTOMATION.md** - Setup instructions

### Security:
- **SECURITY_QUICK_ANSWER.md** - Is this safe?
- **SECURITY_EXPLAINED.md** - Complete security guide

### Technical:
- **AUTOMATION_COMPLETE.md** - How it works
- **FINAL_SETUP_CHECKLIST.md** - Complete checklist

### Tools:
- **check_requirements.py** - Verify setup
- **test_email_setup.py** - Test email
- **setup_automation.ps1** - Automated setup
- **CHECK_SETUP.bat** - Quick check (double-click)

---

## 🎯 Quick Commands Reference

### Setup:
```bash
# Automated setup
.\setup_automation.ps1

# Manual setup
cp .env.example .env
notepad .env
pip install python-dotenv
```

### Testing:
```bash
# Check requirements
python check_requirements.py

# Test email
python test_email_setup.py

# Check Git protection
git status
```

### Building:
```bash
# Build APK (email sends automatically)
flutter build apk --release

# Build without email (debug)
flutter build apk --debug

# Send existing APK
python send_apk.py
```

### Maintenance:
```bash
# Update credentials
notepad .env

# Reinstall dependencies
pip install python-dotenv --upgrade

# Revoke App Password
# Visit: https://myaccount.google.com/apppasswords
```

---

## ✅ Success Criteria

You're ready when:

1. ✅ `python check_requirements.py` - all checks pass
2. ✅ `python test_email_setup.py` - email sent successfully
3. ✅ `flutter build apk --release` - APK built and email sent
4. ✅ Friend receives email with APK
5. ✅ APK installs and runs on device
6. ✅ `.env` not in `git status`

---

## 🎉 You're Done!

**From now on, just run:**
```bash
flutter build apk --release
```

**Email sends automatically!** ✅

---

**Need help? Run:** `python check_requirements.py`
**Read more:** `START_HERE.md` or `REQUIREMENTS.md`
