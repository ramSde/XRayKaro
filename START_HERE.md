# 🚀 START HERE - Complete Setup Guide

## 📋 What You Have

Your Flutter app now has **secure, automated APK email delivery** integrated into the build process.

---

## ⚡ Quick Start (5 Minutes)

### Step 0: Check Requirements (30 seconds)

**Double-click:** `CHECK_SETUP.bat`

Or run:
```bash
python check_requirements.py
```

**This verifies:**
- ✅ Python installed
- ✅ Dependencies installed
- ✅ Configuration files present
- ✅ Network connectivity
- ✅ Gradle integration

**If all checks pass, continue to Step 1.**
**If checks fail, see `REQUIREMENTS.md` for fixes.**

---

### Step 1: Run Setup Script (1 minute)

```powershell
.\setup_automation.ps1
```

This will:
- ✅ Check Python installation
- ✅ Install python-dotenv
- ✅ Create .env file
- ✅ Open .env for editing

---

### Step 2: Get Gmail App Password (2 minutes)

1. Visit: **https://myaccount.google.com/apppasswords**
2. Sign in to Gmail
3. Create new App Password
4. Copy the 16-character code

**Important:** This is NOT your regular Gmail password!

---

### Step 3: Configure .env File (1 minute)

Edit `.env` file:

```
SENDER_EMAIL=your.email@gmail.com
SENDER_PASSWORD=abcd efgh ijkl mnop
RECIPIENT_EMAIL=friend.email@gmail.com
```

Replace with your actual values. Save the file.

---

### Step 4: Test (30 seconds)

```bash
python test_email_setup.py
```

**Expected output:**
```
✅ Test email sent successfully!
```

---

### Step 5: Build APK (Automatic!)

```bash
flutter build apk --release
```

**That's it!** Email sends automatically after build. ✅

---

## 🔐 Security - Is This Safe?

### YES! ✅ Here's Why:

1. **NOT using your real password**
   - Using Gmail App Password (16-character code)
   - Separate from your Gmail password
   - Limited to sending emails only

2. **App Password is safe**
   - Can only send emails (nothing else)
   - Cannot read emails or access account
   - Can be revoked in 10 seconds

3. **Credentials protected**
   - Stored in .env file (not in code)
   - .env is in .gitignore (never committed)
   - TLS encrypted connection

4. **Official methods only**
   - Python built-in library (smtplib)
   - Gmail official SMTP
   - Google's official App Password system

**Read more:** `SECURITY_EXPLAINED.md`

---

## 📁 Files Overview

### Configuration Files:
- `.env.example` - Template (safe to commit)
- `.env` - Your credentials (NEVER commit)
- `.gitignore` - Protects .env from Git

### Scripts:
- `send_apk.py` - Main email script
- `test_email_setup.py` - Test configuration
- `setup_automation.ps1` - Automated setup
- `build_and_send.ps1` - Alternative manual script

### Documentation:
- `START_HERE.md` - This file
- `SETUP_AUTOMATION.md` - Detailed setup
- `SECURITY_EXPLAINED.md` - Security details
- `SECURITY_QUICK_ANSWER.md` - Quick security FAQ
- `AUTOMATION_COMPLETE.md` - Technical details
- `FINAL_SETUP_CHECKLIST.md` - Complete checklist

---

## 🎯 How It Works

```
flutter build apk --release
    ↓
Gradle builds APK (2-3 min)
    ↓
Post-build hook triggers
    ↓
Python reads .env file
    ↓
Connects to Gmail SMTP (TLS encrypted)
    ↓
Sends email with APK
    ↓
Friend receives email ✅
```

**Zero extra commands. Fully automatic.**

---

## ✅ Verification Checklist

Before first use:

- [ ] Python installed
- [ ] Ran `setup_automation.ps1`
- [ ] Created .env file
- [ ] Got Gmail App Password
- [ ] Configured .env with credentials
- [ ] Ran `python test_email_setup.py` successfully
- [ ] .env is in .gitignore
- [ ] .env NOT committed to Git

---

## 🔧 Common Commands

### Setup:
```powershell
# Run automated setup
.\setup_automation.ps1

# Install python-dotenv manually
pip install python-dotenv
```

### Testing:
```bash
# Test email configuration
python test_email_setup.py

# Check if .env is protected
git status  # .env should NOT appear
```

### Building:
```bash
# Build APK (email sends automatically)
flutter build apk --release

# Build without email (debug build)
flutter build apk --debug
```

### Maintenance:
```bash
# Update credentials
notepad .env

# Revoke App Password
# Visit: https://myaccount.google.com/apppasswords
```

---

## 🆘 Troubleshooting

### "Configuration not found"
```bash
# Solution:
cp .env.example .env
notepad .env
# Add your credentials
```

### "python-dotenv not installed"
```bash
# Solution:
pip install python-dotenv
```

### "Authentication failed"
```bash
# Solution:
# 1. Get new App Password: https://myaccount.google.com/apppasswords
# 2. Update .env file
# 3. Test: python test_email_setup.py
```

### ".env committed to Git"
```bash
# Solution:
git rm --cached .env
git commit -m "Remove .env"
```

**Full troubleshooting:** `FINAL_SETUP_CHECKLIST.md`

---

## 📚 Documentation Guide

### Quick Start:
- **START_HERE.md** ← You are here
- **SETUP_AUTOMATION.md** - Detailed setup

### Security:
- **SECURITY_QUICK_ANSWER.md** - Is this safe?
- **SECURITY_EXPLAINED.md** - Complete security guide

### Technical:
- **AUTOMATION_COMPLETE.md** - How it works
- **FINAL_SETUP_CHECKLIST.md** - Complete checklist

### Reference:
- **README_AUTOMATION.md** - Quick reference
- **BUILD_COMMANDS.md** - Build commands

---

## 🎯 Next Steps

### 1. Complete Setup (5 minutes)
Follow the Quick Start section above.

### 2. Test Everything
```bash
python test_email_setup.py
flutter build apk --release
```

### 3. Verify Friend Receives Email
Check with your friend that they received the APK.

### 4. Use Normally
From now on, just run:
```bash
flutter build apk --release
```

Email sends automatically! ✅

---

## 💡 Pro Tips

### Tip 1: Multiple Recipients
Edit `.env`:
```
RECIPIENT_EMAIL=tester1@gmail.com,tester2@gmail.com,tester3@gmail.com
```

### Tip 2: Disable Temporarily
Comment out in `android/app/build.gradle.kts`:
```kotlin
// finalizedBy("sendApkEmail")
```

### Tip 3: Custom Email Template
Edit `send_apk.py` (lines 60-80)

### Tip 4: Environment-Specific Config
Create `.env.production`, `.env.staging`, etc.

---

## 🔐 Security Reminders

### ✅ DO:
- ✅ Use Gmail App Password
- ✅ Store credentials in .env
- ✅ Add .env to .gitignore
- ✅ Revoke App Password when done

### ❌ DON'T:
- ❌ Use real Gmail password
- ❌ Commit .env to Git
- ❌ Share .env file
- ❌ Hardcode credentials in code

---

## 📞 Need Help?

### Check Documentation:
1. **SECURITY_EXPLAINED.md** - Security questions
2. **FINAL_SETUP_CHECKLIST.md** - Complete checklist
3. **SETUP_AUTOMATION.md** - Detailed setup

### Test Configuration:
```bash
python test_email_setup.py
```

### Verify Git Protection:
```bash
git status  # .env should NOT appear
```

---

## 🎉 Summary

### What You Get:
- ✅ Automated APK email delivery
- ✅ Secure credential management (.env)
- ✅ Gmail App Password (not real password)
- ✅ TLS encrypted connection
- ✅ Integrated with build process
- ✅ Graceful error handling
- ✅ Complete documentation

### How to Use:
```bash
# One-time setup (5 min)
.\setup_automation.ps1
# Configure .env
# Test: python test_email_setup.py

# Every build (automatic)
flutter build apk --release
```

**That's it! Your friend automatically receives every build.** 🚀

---

## ✅ Ready?

1. Run: `.\setup_automation.ps1`
2. Configure .env
3. Test: `python test_email_setup.py`
4. Build: `flutter build apk --release`

**Done!** ✅

---

**Questions? Read:** `SECURITY_EXPLAINED.md` or `FINAL_SETUP_CHECKLIST.md`
