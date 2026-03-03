# ⚡ Auto-Send APK Setup (Integrated with Flutter Build)

## 🎯 What This Does

When you run `flutter build apk --release`, it will **automatically**:
1. Build the APK
2. Send it via email to your friend
3. Show success/failure message

**No extra commands needed!**

---

## 📝 One-Time Setup (2 Minutes)

### Step 1: Get Gmail App Password

1. Visit: https://myaccount.google.com/apppasswords
2. Sign in to your Gmail
3. Create new App Password
4. Copy the 16-character code (e.g., "abcd efgh ijkl mnop")

**Official Documentation:** https://support.google.com/accounts/answer/185833

---

### Step 2: Configure Email Settings

Open `send_apk.py` and update these 3 lines:

```python
# Line 18-23: Update these values
SENDER_EMAIL = "your.email@gmail.com"        # Your Gmail address
SENDER_PASSWORD = "abcd efgh ijkl mnop"      # App Password from Step 1
RECIPIENT_EMAIL = "friend.email@gmail.com"   # Your friend's email
```

**Example:**
```python
SENDER_EMAIL = "john.developer@gmail.com"
SENDER_PASSWORD = "xyzw abcd 1234 5678"
RECIPIENT_EMAIL = "mike.tester@gmail.com"
```

Save the file.

---

### Step 3: Test Configuration

Run this to test your email setup:

```bash
python test_email_setup.py
```

**Expected output:**
```
✅ Test email sent successfully!
```

If you see errors, check `AUTOMATION_SETUP_GUIDE.md` for troubleshooting.

---

## 🚀 Usage

### Normal Flutter Build (Auto-Send Enabled)

Just build normally - email sends automatically:

```bash
flutter build apk --release
```

**What happens:**
1. Flutter builds APK (2-3 minutes)
2. Gradle automatically runs email script
3. APK sent to your friend
4. Done! ✅

---

### Build Without Sending Email

If you want to build WITHOUT sending email:

```bash
flutter build apk --release --no-gradle-daemon
```

Or temporarily disable in `android/app/build.gradle.kts`:
```kotlin
// Comment out this line:
// finalizedBy("sendApkEmail")
```

---

## 📧 What Your Friend Receives

**Email with:**
- Subject: "X-Ray Body Scanner - New Build Ready for Testing"
- Attachment: app-release.apk (~46 MB)
- Build details: date, version, size
- Testing checklist

---

## 🔧 How It Works

### Integration Point: Gradle Post-Build Hook

Added to `android/app/build.gradle.kts`:

```kotlin
// Automatically run email task after release build completes
tasks.named("assembleRelease") {
    finalizedBy("sendApkEmail")
}
```

**Official Gradle Documentation:**
https://docs.gradle.org/current/userguide/more_about_tasks.html#sec:finalizer_tasks

### Execution Flow:

```
flutter build apk --release
    ↓
Gradle assembleRelease task
    ↓
APK built successfully
    ↓
Gradle finalizedBy hook triggers
    ↓
Runs: python send_apk.py
    ↓
Email sent with APK
    ↓
Build complete ✅
```

---

## ✅ Verification

### Check if automation is active:

```bash
cd android
./gradlew tasks --group automation
```

**Expected output:**
```
sendApkEmail - Sends the built APK via email to tester
```

---

## 🔐 Security

### Keep Credentials Safe:

1. **Add to .gitignore:**
```
send_apk.py
.env
```

2. **Never commit credentials** to Git

3. **Revoke App Password** when done:
   - Visit: https://myaccount.google.com/apppasswords
   - Remove the password you created

---

## 🆘 Troubleshooting

### Email not sending after build?

**Check 1: Python installed?**
```bash
python --version
```
If not found, install: https://www.python.org/downloads/

**Check 2: Configuration correct?**
```bash
python test_email_setup.py
```

**Check 3: Check Gradle output**
Look for this in build output:
```
> Task :app:sendApkEmail
✅ APK sent via email successfully!
```

---

### Build fails with email error?

The automation is configured to NOT fail the build if email fails.

**You'll see:**
```
⚠️  Email sending failed. APK is ready at: build/app/outputs/flutter-apk/app-release.apk
```

**APK is still built successfully** - just email didn't send.

---

### Want to disable automation temporarily?

**Option 1: Comment out in build.gradle.kts:**
```kotlin
// tasks.named("assembleRelease") {
//     finalizedBy("sendApkEmail")
// }
```

**Option 2: Build debug instead:**
```bash
flutter build apk --debug
```
(Email only triggers on release builds)

---

## 📊 Comparison

### Before Automation:
```
1. flutter build apk --release     (2-3 min)
2. Find APK in file explorer        (30 sec)
3. Open Gmail                       (10 sec)
4. Compose email                    (1 min)
5. Attach APK                       (20 sec)
6. Send                             (5 sec)
────────────────────────────────────────────
Total: ~5 minutes + manual effort
```

### After Automation:
```
1. flutter build apk --release     (2-3 min)
   └─> Email sent automatically    ✅
────────────────────────────────────────────
Total: ~3 minutes, zero manual effort
```

**Time Saved:** 2 minutes per build
**Effort Saved:** 100% automated

---

## 💡 Pro Tips

### Tip 1: Multiple Testers
Send to multiple people:
```python
RECIPIENT_EMAIL = "tester1@gmail.com, tester2@gmail.com, tester3@gmail.com"
```

### Tip 2: Custom Email Template
Edit email subject/body in `send_apk.py` (lines 28-45)

### Tip 3: Debug Builds Too
To enable for debug builds, add to `build.gradle.kts`:
```kotlin
tasks.named("assembleDebug") {
    finalizedBy("sendApkEmail")
}
```

### Tip 4: CI/CD Integration
This works in CI/CD pipelines too (GitHub Actions, GitLab CI, etc.)

---

## 📚 Documentation References

1. **Gradle Finalizer Tasks:**
   https://docs.gradle.org/current/userguide/more_about_tasks.html#sec:finalizer_tasks

2. **Python SMTP:**
   https://docs.python.org/3/library/smtplib.html

3. **Gmail App Passwords:**
   https://support.google.com/accounts/answer/185833

---

## 🎉 Quick Start Checklist

- [ ] Python installed (`python --version`)
- [ ] Gmail App Password created
- [ ] `send_apk.py` configured (3 lines updated)
- [ ] Test email sent (`python test_email_setup.py`)
- [ ] Build APK: `flutter build apk --release`
- [ ] Friend receives email with APK ✅

---

## ✅ Done!

From now on, every time you run:
```bash
flutter build apk --release
```

Your friend automatically receives the APK via email. No extra steps!

**Setup time:** 2 minutes (one-time)
**Usage:** Zero effort (fully automatic)

🚀 **Happy building!**
