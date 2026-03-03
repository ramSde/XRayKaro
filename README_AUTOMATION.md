# 🤖 APK Build & Email Automation

## What This Does
**Automatically** sends your Flutter APK to your friend via email after every release build. Fully integrated - no extra commands needed!

---

## 🚀 Quick Setup (2 Minutes)

### 1. Get Gmail App Password
Visit: https://myaccount.google.com/apppasswords
- Create new App Password
- Copy the 16-character code

### 2. Configure
Edit `send_apk.py`:
```python
SENDER_EMAIL = "your.email@gmail.com"
SENDER_PASSWORD = "xxxx xxxx xxxx xxxx"  # App Password
RECIPIENT_EMAIL = "friend.email@gmail.com"
```

### 3. Test
```bash
python test_email_setup.py
```

### 4. Build (Email Sends Automatically!)
```bash
flutter build apk --release
```

Done! ✅ Your friend receives the APK automatically.

---

## 🎯 How It Works

**Integrated with Gradle:**
- Added post-build hook to `android/app/build.gradle.kts`
- Automatically triggers after `assembleRelease` task
- Runs `python send_apk.py` to send email
- Build never fails if email fails (graceful handling)

**Official Gradle Documentation:**
https://docs.gradle.org/current/userguide/more_about_tasks.html#sec:finalizer_tasks

---

## 📁 Files

| File | Purpose |
|------|---------|
| `send_apk.py` | Python script - sends email with APK |
| `test_email_setup.py` | Test your email configuration |
| `build_and_send.ps1` | Alternative: Manual build + send |
| `BUILD_AND_SEND.bat` | Alternative: Double-click to build + send |
| `SETUP_AUTOMATION.md` | Complete setup guide |
| `AUTOMATION_SETUP_GUIDE.md` | Detailed documentation |

---

## 🎯 Usage

### Automatic (Recommended)
```bash
flutter build apk --release
```
Email sends automatically after build! ✅

### Manual (If Needed)
```bash
python send_apk.py
```

### Alternative: PowerShell Script
```powershell
.\build_and_send.ps1
```

---

## ✅ What Happens

```
flutter build apk --release
    ↓
Gradle builds APK (2-3 min)
    ↓
Post-build hook triggers
    ↓
Python sends email with APK
    ↓
Friend receives email ✅
    ↓
Build complete!
```

---

## 📧 What Friend Receives

**Email with:**
- Subject: "X-Ray Body Scanner - New Build Ready for Testing"
- Attachment: app-release.apk (~46 MB)
- Build date, version, size
- Testing checklist

---

## 🔧 Requirements

- Python 3.x (https://www.python.org/downloads/)
- Gmail account with App Password
- Flutter project

---

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| "Python not found" | Install: https://www.python.org/downloads/ |
| "Authentication failed" | Use App Password, not regular password |
| Email not sending | Run: `python test_email_setup.py` |
| Want to disable | Comment out `finalizedBy` in build.gradle.kts |

**Full troubleshooting:** See `SETUP_AUTOMATION.md`

---

## 🔐 Security

- ✅ Uses official Gmail App Password
- ✅ Direct SMTP connection (no third-party services)
- ✅ Official Python SMTP library
- ✅ Add `send_apk.py` to `.gitignore`

**Documentation:**
- Python SMTP: https://docs.python.org/3/library/smtplib.html
- Gmail App Passwords: https://support.google.com/accounts/answer/185833

---

## 💡 Pro Tips

1. **Multiple testers:** Add comma-separated emails in `RECIPIENT_EMAIL`
2. **Customize email:** Edit template in `send_apk.py`
3. **Debug builds too:** Add `finalizedBy` to `assembleDebug` task
4. **Disable temporarily:** Comment out hook in `build.gradle.kts`

---

## 📚 Documentation

- **Setup Guide:** `SETUP_AUTOMATION.md`
- **Complete Guide:** `AUTOMATION_SETUP_GUIDE.md`
- **Quick Reference:** `QUICK_START.md`

---

## 🎉 Benefits

- ✅ **Zero manual effort** - Fully automatic
- ✅ **Fast** - Integrated with build process
- ✅ **Free** - No paid services
- ✅ **Secure** - Official Gmail authentication
- ✅ **Reliable** - Uses official APIs
- ✅ **Simple** - 2 minute setup

---

**Ready? Just run: `flutter build apk --release`**

Your friend automatically receives the APK! 🚀
