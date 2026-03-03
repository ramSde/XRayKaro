# 📋 Requirements for Email Automation

## 🎯 Overview

This document lists all requirements needed for the email automation to work.

---

## ✅ Required Software

### 1. Python 3.6+

**What:** Python programming language
**Why:** Runs the email automation script
**Version:** 3.6 or higher (3.8+ recommended)

**Check if installed:**
```bash
python --version
```

**Expected output:**
```
Python 3.x.x
```

**If not installed:**
- **Windows:** https://www.python.org/downloads/
  - ✅ Check "Add Python to PATH" during installation
- **Mac:** `brew install python3`
- **Linux:** `sudo apt install python3`

---

### 2. pip (Python Package Manager)

**What:** Python package installer
**Why:** Installs python-dotenv dependency
**Version:** Usually comes with Python

**Check if installed:**
```bash
pip --version
```

**Expected output:**
```
pip x.x.x from ...
```

**If not installed:**
```bash
python -m ensurepip --upgrade
```

---

### 3. Flutter SDK

**What:** Flutter development kit
**Why:** Builds the APK
**Version:** Any recent version

**Check if installed:**
```bash
flutter --version
```

**Expected output:**
```
Flutter x.x.x • channel stable • ...
```

**If not installed:**
- https://flutter.dev/docs/get-started/install

---

## 📦 Required Python Packages

### 1. python-dotenv

**What:** Loads environment variables from .env file
**Why:** Securely manages credentials
**Version:** Any recent version

**Check if installed:**
```bash
pip list | grep python-dotenv
```

**Install:**
```bash
pip install python-dotenv
```

**Official documentation:**
https://pypi.org/project/python-dotenv/

---

### 2. Built-in Python Libraries (No Installation Needed)

These come with Python:
- ✅ `smtplib` - SMTP protocol
- ✅ `email` - Email formatting
- ✅ `os` - Operating system interface
- ✅ `sys` - System-specific parameters

**No installation required!**

---

## 🔐 Required Accounts & Credentials

### 1. Gmail Account

**What:** Gmail email account
**Why:** Sends emails via Gmail SMTP
**Cost:** Free

**Requirements:**
- ✅ Active Gmail account
- ✅ 2-Step Verification enabled
- ✅ App Password created

**Setup:**
1. Enable 2-Step Verification: https://myaccount.google.com/security
2. Create App Password: https://myaccount.google.com/apppasswords

---

### 2. Gmail App Password

**What:** 16-character code for SMTP access
**Why:** Secure authentication (not your real password)
**Cost:** Free

**How to get:**
1. Visit: https://myaccount.google.com/apppasswords
2. Sign in to Gmail
3. Create new App Password
4. Copy 16-character code

**Important:** This is NOT your regular Gmail password!

---

## 📁 Required Files

### 1. .env File

**What:** Configuration file with credentials
**Why:** Stores email credentials securely
**Location:** Project root directory

**Create from template:**
```bash
cp .env.example .env
```

**Required content:**
```
SENDER_EMAIL=your.email@gmail.com
SENDER_PASSWORD=your_app_password
RECIPIENT_EMAIL=friend.email@gmail.com
```

---

### 2. .env.example File

**What:** Template for .env file
**Status:** ✅ Already created
**Location:** Project root directory

**No action needed** - already exists in project.

---

### 3. .gitignore File

**What:** Protects .env from being committed to Git
**Status:** ✅ Already configured
**Location:** Project root directory

**Verify:**
```bash
cat .gitignore | grep ".env"
```

**Expected output:**
```
.env
.env.local
.env.*.local
```

---

## 🌐 Network Requirements

### 1. Internet Connection

**What:** Active internet connection
**Why:** Connects to Gmail SMTP server
**Speed:** Any speed (email is small)

**Test connection:**
```bash
ping smtp.gmail.com
```

---

### 2. Gmail SMTP Access

**What:** Access to smtp.gmail.com on port 587
**Why:** Sends emails via Gmail
**Protocol:** SMTP with TLS

**Server:** smtp.gmail.com
**Port:** 587
**Encryption:** TLS (STARTTLS)

**Test access:**
```bash
telnet smtp.gmail.com 587
```

---

### 3. Firewall Configuration

**What:** Allow outbound connections on port 587
**Why:** SMTP communication
**Action:** Usually no action needed

**If blocked:**
- Check Windows Firewall
- Check antivirus software
- Check corporate firewall

---

## 🔧 System Requirements

### Operating System

**Supported:**
- ✅ Windows 10/11
- ✅ macOS 10.14+
- ✅ Linux (Ubuntu, Debian, etc.)

**Current system:** Windows (based on your setup)

---

### Disk Space

**Required:**
- Python: ~100 MB
- python-dotenv: <1 MB
- APK file: ~50 MB
- Total: ~200 MB

**Check available space:**
```bash
# Windows
wmic logicaldisk get size,freespace,caption
```

---

### Permissions

**Required:**
- ✅ Read/write access to project directory
- ✅ Execute Python scripts
- ✅ Network access (outbound port 587)

**No admin rights needed!**

---

## ✅ Quick Requirements Check

### Run Automated Check:

```bash
python check_requirements.py
```

**This checks:**
1. ✅ Python version
2. ✅ pip installed
3. ✅ python-dotenv installed
4. ✅ .env file exists and configured
5. ✅ .gitignore protects .env
6. ✅ Flutter installed
7. ✅ Gradle integration
8. ✅ Network connectivity
9. ✅ APK exists

---

## 📊 Requirements Summary

### Minimum Requirements:

| Component | Requirement | Status |
|-----------|-------------|--------|
| Python | 3.6+ | Check: `python --version` |
| pip | Any version | Check: `pip --version` |
| python-dotenv | Any version | Install: `pip install python-dotenv` |
| Flutter | Any version | Check: `flutter --version` |
| Gmail Account | Active | Create at gmail.com |
| App Password | 16 chars | Get at myaccount.google.com/apppasswords |
| .env file | Configured | Create from .env.example |
| Internet | Active | Required for SMTP |

---

## 🚀 Installation Steps

### Step 1: Install Python (if needed)

**Windows:**
1. Download: https://www.python.org/downloads/
2. Run installer
3. ✅ Check "Add Python to PATH"
4. Click "Install Now"
5. Restart terminal

**Verify:**
```bash
python --version
```

---

### Step 2: Install python-dotenv

```bash
pip install python-dotenv
```

**Verify:**
```bash
pip list | grep python-dotenv
```

---

### Step 3: Create .env File

```bash
# Copy template
cp .env.example .env

# Edit with your credentials
notepad .env
```

---

### Step 4: Get Gmail App Password

1. Visit: https://myaccount.google.com/apppasswords
2. Create new App Password
3. Copy 16-character code
4. Add to .env file

---

### Step 5: Verify Setup

```bash
python check_requirements.py
```

**Expected:**
```
✅ All checks passed!
```

---

## 🆘 Troubleshooting

### "Python not found"

**Cause:** Python not installed or not in PATH

**Solution:**
1. Install Python: https://www.python.org/downloads/
2. Check "Add Python to PATH"
3. Restart terminal
4. Verify: `python --version`

---

### "pip not found"

**Cause:** pip not installed

**Solution:**
```bash
python -m ensurepip --upgrade
```

---

### "python-dotenv not found"

**Cause:** Package not installed

**Solution:**
```bash
pip install python-dotenv
```

---

### "Cannot connect to smtp.gmail.com"

**Cause:** Network/firewall issue

**Solution:**
1. Check internet connection
2. Check firewall settings
3. Try disabling VPN temporarily
4. Check port 587 is not blocked

---

### ".env file not found"

**Cause:** File not created

**Solution:**
```bash
cp .env.example .env
notepad .env
```

---

## 📚 Official Documentation

### Python:
- Download: https://www.python.org/downloads/
- Documentation: https://docs.python.org/3/

### python-dotenv:
- PyPI: https://pypi.org/project/python-dotenv/
- GitHub: https://github.com/theskumar/python-dotenv

### Gmail SMTP:
- Settings: https://support.google.com/mail/answer/7126229
- App Passwords: https://support.google.com/accounts/answer/185833

### Flutter:
- Install: https://flutter.dev/docs/get-started/install
- Documentation: https://flutter.dev/docs

---

## ✅ Verification Checklist

Before using automation:

- [ ] Python 3.6+ installed (`python --version`)
- [ ] pip installed (`pip --version`)
- [ ] python-dotenv installed (`pip list | grep python-dotenv`)
- [ ] Flutter installed (`flutter --version`)
- [ ] Gmail account with 2FA enabled
- [ ] Gmail App Password created
- [ ] .env file created from .env.example
- [ ] .env file configured with credentials
- [ ] .env protected by .gitignore
- [ ] Internet connection active
- [ ] Can connect to smtp.gmail.com:587
- [ ] All checks pass: `python check_requirements.py`

---

## 🎉 Ready to Use!

Once all requirements are met:

```bash
# Test configuration
python test_email_setup.py

# Build APK (email sends automatically)
flutter build apk --release
```

---

## 💡 Optional Enhancements

### 1. Virtual Environment (Recommended)

**Why:** Isolates Python packages

**Setup:**
```bash
# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate

# Install dependencies
pip install python-dotenv

# Deactivate when done
deactivate
```

---

### 2. requirements.txt File

**Why:** Easy dependency management

**Create:**
```bash
pip freeze > requirements.txt
```

**Install from file:**
```bash
pip install -r requirements.txt
```

---

## 📞 Need Help?

### Run Requirements Check:
```bash
python check_requirements.py
```

### Read Documentation:
- `START_HERE.md` - Setup guide
- `SETUP_AUTOMATION.md` - Detailed setup
- `FINAL_SETUP_CHECKLIST.md` - Complete checklist

### Test Configuration:
```bash
python test_email_setup.py
```

---

**All requirements documented and verified!** ✅
