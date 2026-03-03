# 🐍 Python Installation Guide

## ⚠️ Python Not Found

Python is required for the email automation to work.

---

## 📥 Install Python (5 Minutes)

### Step 1: Download Python

**Visit:** https://www.python.org/downloads/

**Click:** "Download Python 3.x.x" (latest version)

---

### Step 2: Run Installer

1. **Double-click** the downloaded file (e.g., `python-3.x.x-amd64.exe`)

2. **IMPORTANT:** ✅ Check "Add Python to PATH"
   ```
   [✓] Add Python 3.x to PATH  ← MUST CHECK THIS!
   ```

3. Click **"Install Now"**

4. Wait for installation to complete

5. Click **"Close"**

---

### Step 3: Verify Installation

**Close and reopen** your terminal/PowerShell, then run:

```bash
python --version
```

**Expected output:**
```
Python 3.x.x
```

---

### Step 4: Verify pip

```bash
pip --version
```

**Expected output:**
```
pip x.x.x from ...
```

---

## ✅ After Python is Installed

Run the setup script:

```powershell
.\setup_automation.ps1
```

This will:
1. ✅ Install python-dotenv
2. ✅ Create .env file
3. ✅ Guide you through configuration

---

## 🆘 Troubleshooting

### "Python not found" after installation

**Cause:** PATH not updated or terminal not restarted

**Solution:**
1. Close ALL terminal/PowerShell windows
2. Open NEW terminal/PowerShell
3. Try: `python --version`

**If still not working:**
1. Restart your computer
2. Try again

---

### "Add Python to PATH" was not checked

**Solution:**
1. Uninstall Python (Control Panel → Programs)
2. Download installer again
3. Run installer
4. ✅ CHECK "Add Python to PATH"
5. Install

---

### Alternative: Microsoft Store

**If installer doesn't work:**

1. Open Microsoft Store
2. Search "Python 3.11" (or latest)
3. Click "Get" / "Install"
4. Wait for installation
5. Verify: `python --version`

---

## 📋 Quick Reference

### Download Link:
https://www.python.org/downloads/

### What to Check:
✅ "Add Python to PATH"

### Verify Commands:
```bash
python --version
pip --version
```

### Next Step:
```powershell
.\setup_automation.ps1
```

---

**After installing Python, continue with the setup!** 🚀
