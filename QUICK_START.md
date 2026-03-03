# ⚡ Quick Start - APK Auto-Send

## 🎯 Goal
Build Flutter APK and automatically email it to your friend for testing.

---

## 📝 Setup (One-Time Only)

### 1. Get Gmail App Password
1. Go to: https://myaccount.google.com/apppasswords
2. Create new App Password
3. Copy the 16-character password

### 2. Configure Script
Open `send_apk.py` and update:
```python
SENDER_EMAIL = "your.email@gmail.com"        # Your Gmail
SENDER_PASSWORD = "xxxx xxxx xxxx xxxx"      # App Password from step 1
RECIPIENT_EMAIL = "friend.email@gmail.com"   # Friend's email
```

### 3. Test
```bash
python send_apk.py
```

---

## 🚀 Usage

### Method 1: Double-Click (Easiest)
Just double-click: `BUILD_AND_SEND.bat`

### Method 2: PowerShell
```powershell
.\build_and_send.ps1
```

### Method 3: Manual
```bash
flutter build apk --release
python send_apk.py
```

---

## ✅ What It Does

1. Cleans previous build
2. Gets dependencies  
3. Builds release APK
4. Sends email with APK attached
5. Shows success message

**Time:** 2-3 minutes

---

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| "Python not found" | Install Python: https://www.python.org/downloads/ |
| "Authentication failed" | Use Gmail App Password, not regular password |
| "APK not found" | Run `flutter build apk --release` first |
| "File too large" | APK must be < 25 MB for Gmail |

---

## 📧 What Friend Receives

**Email with:**
- Subject: "X-Ray Body Scanner - New Build Ready"
- Attachment: app-release.apk (~46 MB)
- Testing instructions

---

## 🎉 That's It!

Every time you want to send a new build:
1. Double-click `BUILD_AND_SEND.bat`
2. Wait 2-3 minutes
3. Done! ✅

**Full documentation:** See `AUTOMATION_SETUP_GUIDE.md`
