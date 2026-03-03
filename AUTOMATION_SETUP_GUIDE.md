# 🤖 APK Build & Email Automation Setup Guide

## Overview
This automation builds your Flutter APK and automatically emails it to your friend for testing. No third-party services needed - uses Gmail SMTP directly.

---

## 📋 Prerequisites

### 1. Python Installation
**Check if installed:**
```bash
python --version
```

**If not installed:**
- Download from: https://www.python.org/downloads/
- During installation, CHECK "Add Python to PATH"
- Restart terminal after installation

### 2. Gmail App Password (REQUIRED)
Gmail requires an "App Password" for SMTP access (not your regular password).

**Steps to create App Password:**
1. Go to: https://myaccount.google.com/apppasswords
2. Sign in to your Gmail account
3. If you don't see "App passwords":
   - Enable 2-Step Verification first: https://myaccount.google.com/security
   - Then return to App passwords page
4. Click "Select app" → Choose "Mail"
5. Click "Select device" → Choose "Windows Computer"
6. Click "Generate"
7. Copy the 16-character password (e.g., "abcd efgh ijkl mnop")
8. Save it securely - you'll need it for configuration

**Official Google Documentation:**
https://support.google.com/accounts/answer/185833

---

## ⚙️ Configuration

### Step 1: Edit `send_apk.py`

Open `send_apk.py` and update these lines:

```python
# Your Gmail credentials
SENDER_EMAIL = "your.email@gmail.com"  # Replace with YOUR Gmail
SENDER_PASSWORD = "abcd efgh ijkl mnop"  # Replace with App Password (16 chars)

# Friend's email
RECIPIENT_EMAIL = "friend.email@gmail.com"  # Replace with friend's email
```

**Example:**
```python
SENDER_EMAIL = "john.developer@gmail.com"
SENDER_PASSWORD = "xyzw abcd 1234 5678"
RECIPIENT_EMAIL = "mike.tester@gmail.com"
```

### Step 2: Customize Email (Optional)

You can customize the email subject and body in `send_apk.py`:

```python
EMAIL_SUBJECT = "X-Ray Body Scanner - New Build Ready for Testing"
EMAIL_BODY = """Hi,

A new build is ready for testing!
...
"""
```

---

## 🚀 Usage

### Option 1: Automated Build + Send (Recommended)

Run this single command to build APK and send email automatically:

```powershell
.\build_and_send.ps1
```

**What it does:**
1. ✅ Cleans previous build
2. ✅ Gets dependencies
3. ✅ Builds release APK
4. ✅ Sends email with APK attachment
5. ✅ Shows success/failure status

**Time:** ~2-3 minutes

---

### Option 2: Send Existing APK Only

If you already built the APK and just want to send it:

```bash
python send_apk.py
```

---

### Option 3: Manual Build, Auto Send

```bash
# Build manually
flutter build apk --release

# Then send
python send_apk.py
```

---

## 📧 Email Details

**What your friend receives:**
- **Subject:** "X-Ray Body Scanner - New Build Ready for Testing"
- **Attachment:** app-release.apk (~46 MB)
- **Body:** Build date, version, size, testing checklist

**Gmail Limits:**
- Maximum attachment size: 25 MB
- If APK > 25 MB, script will warn you
- Solution: Use Google Drive link instead (see Alternative Solutions)

---

## 🔧 Troubleshooting

### Error: "Authentication failed"
**Cause:** Wrong password or not using App Password

**Solution:**
1. Make sure you're using Gmail App Password (16 characters)
2. NOT your regular Gmail password
3. Create new App Password: https://myaccount.google.com/apppasswords

---

### Error: "Python not found"
**Cause:** Python not installed or not in PATH

**Solution:**
1. Install Python: https://www.python.org/downloads/
2. During installation, CHECK "Add Python to PATH"
3. Restart terminal
4. Verify: `python --version`

---

### Error: "APK file not found"
**Cause:** APK hasn't been built yet

**Solution:**
```bash
flutter build apk --release
```

---

### Error: "File size exceeds 25MB limit"
**Cause:** Gmail attachment limit

**Solution 1 - Reduce APK size:**
```bash
flutter build apk --release --split-per-abi
```
This creates separate APKs for different architectures (smaller files).

**Solution 2 - Use Google Drive:**
See "Alternative Solutions" section below.

---

### Error: "SMTP connection failed"
**Cause:** Firewall or network issue

**Solution:**
1. Check internet connection
2. Try disabling VPN temporarily
3. Check if port 587 is blocked by firewall

---

## 🔐 Security Best Practices

### 1. Keep App Password Secure
- ✅ DO: Store in `send_apk.py` (add to .gitignore)
- ❌ DON'T: Commit to Git
- ❌ DON'T: Share publicly

### 2. Add to .gitignore
Add this line to `.gitignore`:
```
send_apk.py
```

Or use environment variables (see Advanced section).

### 3. Revoke App Password When Done
If you stop using this automation:
1. Go to: https://myaccount.google.com/apppasswords
2. Remove the App Password you created

---

## 🎯 Alternative Solutions

### If APK > 25 MB: Google Drive Upload

**Option A: Manual Upload**
1. Upload APK to Google Drive
2. Get shareable link
3. Send link via email

**Option B: Automated (requires Google Drive API)**
- More complex setup
- Requires Google Cloud project
- Not recommended for simple use case

### If You Want Web Interface

**Option: Firebase App Distribution**
- Official Firebase service
- Free tier available
- Requires Firebase setup
- Documentation: https://firebase.google.com/docs/app-distribution

---

## 📊 Advanced Configuration

### Use Environment Variables (More Secure)

**Step 1:** Create `.env` file:
```
SENDER_EMAIL=your.email@gmail.com
SENDER_PASSWORD=your_app_password
RECIPIENT_EMAIL=friend.email@gmail.com
```

**Step 2:** Install python-dotenv:
```bash
pip install python-dotenv
```

**Step 3:** Update `send_apk.py`:
```python
from dotenv import load_dotenv
load_dotenv()

SENDER_EMAIL = os.getenv('SENDER_EMAIL')
SENDER_PASSWORD = os.getenv('SENDER_PASSWORD')
RECIPIENT_EMAIL = os.getenv('RECIPIENT_EMAIL')
```

**Step 4:** Add to `.gitignore`:
```
.env
```

---

## 📝 Testing the Setup

### Test Email Without Building

Create `test_email.py`:
```python
import smtplib
from email.mime.text import MIMEText

SENDER_EMAIL = "your.email@gmail.com"
SENDER_PASSWORD = "your_app_password"
RECIPIENT_EMAIL = "friend.email@gmail.com"

msg = MIMEText("Test email from automation script")
msg['Subject'] = "Test Email"
msg['From'] = SENDER_EMAIL
msg['To'] = RECIPIENT_EMAIL

server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login(SENDER_EMAIL, SENDER_PASSWORD)
server.send_message(msg)
server.quit()

print("✅ Test email sent!")
```

Run:
```bash
python test_email.py
```

---

## 🎉 Quick Start Checklist

- [ ] Python installed (`python --version`)
- [ ] Gmail App Password created
- [ ] `send_apk.py` configured (email addresses + password)
- [ ] Test email sent successfully
- [ ] APK built (`flutter build apk --release`)
- [ ] Run automation: `.\build_and_send.ps1`
- [ ] Friend receives email with APK

---

## 📚 Official Documentation References

1. **Python SMTP Library:**
   https://docs.python.org/3/library/smtplib.html

2. **Gmail SMTP Settings:**
   https://support.google.com/mail/answer/7126229

3. **Gmail App Passwords:**
   https://support.google.com/accounts/answer/185833

4. **Flutter Build Documentation:**
   https://docs.flutter.dev/deployment/android

---

## 💡 Tips

1. **First Time:** Test with `python send_apk.py` before using full automation
2. **Regular Use:** Just run `.\build_and_send.ps1` each time
3. **Multiple Testers:** Add more emails to `RECIPIENT_EMAIL` (comma-separated)
4. **Build Variants:** Modify script to send debug/release/profile builds

---

## ⚡ One-Command Setup

Copy-paste this to set up everything:

```powershell
# 1. Check Python
python --version

# 2. Edit configuration
notepad send_apk.py

# 3. Test email
python send_apk.py

# 4. Build and send
.\build_and_send.ps1
```

---

**That's it! You now have automated APK delivery to your friend.** 🚀

Every time you want to send a new build, just run:
```powershell
.\build_and_send.ps1
```

No manual steps, no third-party services, completely automated!
