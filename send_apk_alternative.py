#!/usr/bin/env python3
"""
Alternative APK Email Script - Bypasses Gmail APK blocking
Uses file extension tricks and multiple fallback methods
"""

import smtplib
import os
import shutil
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders
from datetime import datetime

# Load configuration
try:
    from dotenv import load_dotenv
    load_dotenv()
    SENDER_EMAIL = os.getenv('SENDER_EMAIL')
    SENDER_PASSWORD = os.getenv('SENDER_PASSWORD')
    RECIPIENT_EMAIL = os.getenv('RECIPIENT_EMAIL')
except ImportError:
    SENDER_EMAIL = os.environ.get('SENDER_EMAIL')
    SENDER_PASSWORD = os.environ.get('SENDER_PASSWORD')
    RECIPIENT_EMAIL = os.environ.get('RECIPIENT_EMAIL')

APK_PATH = "build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"

def get_file_size_mb(filepath):
    size_bytes = os.path.getsize(filepath)
    return round(size_bytes / (1024 * 1024), 2)

def method1_rename_extension():
    """Method 1: Rename APK to .txt extension"""
    print("[METHOD 1] Trying file extension trick (.txt)...")
    
    if not os.path.exists(APK_PATH):
        return False
    
    # Create copy with .txt extension
    txt_path = APK_PATH.replace('.apk', '.txt')
    shutil.copy2(APK_PATH, txt_path)
    
    try:
        msg = MIMEMultipart()
        msg['From'] = SENDER_EMAIL
        msg['To'] = RECIPIENT_EMAIL
        msg['Subject'] = "X-Ray Body Scanner - APK Ready (Rename .txt to .apk)"
        
        body = f"""Hi,

New APK build is ready! 

IMPORTANT: The attached file has .txt extension to bypass email filters.
RENAME IT FROM .txt TO .apk BEFORE INSTALLING.

Steps:
1. Download the attached .txt file
2. Rename it from .txt to .apk
3. Install the APK

Build Details:
- Date: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
- Size: {get_file_size_mb(APK_PATH)} MB

Thanks!
"""
        
        msg.attach(MIMEText(body, 'plain'))
        
        # Attach renamed file
        with open(txt_path, 'rb') as f:
            part = MIMEBase('application', 'octet-stream')
            part.set_payload(f.read())
        
        encoders.encode_base64(part)
        part.add_header('Content-Disposition', f'attachment; filename= {os.path.basename(txt_path)}')
        msg.attach(part)
        
        # Send email
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, RECIPIENT_EMAIL, msg.as_string())
        server.quit()
        
        # Cleanup
        os.remove(txt_path)
        
        print("[SUCCESS] Method 1 worked! APK sent as .txt file")
        return True
        
    except Exception as e:
        try:
            os.remove(txt_path)
        except:
            pass
        print(f"[FAILED] Method 1 failed: {str(e)}")
        return False

def method2_split_file():
    """Method 2: Split APK into multiple parts"""
    print("[METHOD 2] Trying file splitting...")
    
    if not os.path.exists(APK_PATH):
        return False
    
    chunk_size = 10 * 1024 * 1024  # 10MB chunks
    
    try:
        msg = MIMEMultipart()
        msg['From'] = SENDER_EMAIL
        msg['To'] = RECIPIENT_EMAIL
        msg['Subject'] = "X-Ray Body Scanner - APK Parts (Combine to install)"
        
        parts = []
        with open(APK_PATH, 'rb') as f:
            part_num = 1
            while True:
                chunk = f.read(chunk_size)
                if not chunk:
                    break
                
                part_filename = f"app-part{part_num}.dat"
                part_path = os.path.join(os.path.dirname(APK_PATH), part_filename)
                
                with open(part_path, 'wb') as part_file:
                    part_file.write(chunk)
                
                parts.append(part_path)
                part_num += 1
        
        body = f"""Hi,

New APK build is ready! The APK has been split into {len(parts)} parts to bypass email filters.

TO RECONSTRUCT THE APK:
1. Download all attached .dat files
2. Use this command to combine them:
   copy /b app-part1.dat+app-part2.dat+... app.apk
3. Install the reconstructed APK

Build Details:
- Date: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
- Total Size: {get_file_size_mb(APK_PATH)} MB
- Parts: {len(parts)}

Thanks!
"""
        
        msg.attach(MIMEText(body, 'plain'))
        
        # Attach all parts
        for part_path in parts:
            with open(part_path, 'rb') as f:
                part = MIMEBase('application', 'octet-stream')
                part.set_payload(f.read())
            
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', f'attachment; filename= {os.path.basename(part_path)}')
            msg.attach(part)
        
        # Send email
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, RECIPIENT_EMAIL, msg.as_string())
        server.quit()
        
        # Cleanup
        for part_path in parts:
            os.remove(part_path)
        
        print(f"[SUCCESS] Method 2 worked! APK sent as {len(parts)} parts")
        return True
        
    except Exception as e:
        # Cleanup on failure
        for part_path in parts:
            try:
                os.remove(part_path)
            except:
                pass
        print(f"[FAILED] Method 2 failed: {str(e)}")
        return False

def method3_notification_only():
    """Method 3: Send notification with manual upload instructions"""
    print("[METHOD 3] Sending notification with manual instructions...")
    
    try:
        msg = MIMEMultipart()
        msg['From'] = SENDER_EMAIL
        msg['To'] = RECIPIENT_EMAIL
        msg['Subject'] = "X-Ray Body Scanner - APK Ready (Manual Upload Required)"
        
        body = f"""Hi,

New APK build is ready for testing!

Unfortunately, Gmail blocks APK files. Please use one of these methods:

OPTION 1 - Google Drive:
1. Upload APK to Google Drive: {APK_PATH}
2. Share the download link with me

OPTION 2 - File Sharing:
- WeTransfer: https://wetransfer.com/
- Send Anywhere: https://send-anywhere.com/
- Dropbox: https://dropbox.com/

OPTION 3 - Direct Transfer:
- Use USB cable
- Bluetooth transfer
- Local network sharing

Build Details:
- Date: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
- Size: {get_file_size_mb(APK_PATH)} MB
- Location: {APK_PATH}

The APK is ready on the build machine!

Thanks!
"""
        
        msg.attach(MIMEText(body, 'plain'))
        
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, RECIPIENT_EMAIL, msg.as_string())
        server.quit()
        
        print("[SUCCESS] Method 3 worked! Notification sent with manual instructions")
        return True
        
    except Exception as e:
        print(f"[FAILED] Method 3 failed: {str(e)}")
        return False

def main():
    print("=" * 60)
    print("Alternative APK Email Script - Gmail Bypass Methods")
    print("=" * 60)
    
    if not all([SENDER_EMAIL, SENDER_PASSWORD, RECIPIENT_EMAIL]):
        print("[ERROR] Email configuration missing!")
        return False
    
    if not os.path.exists(APK_PATH):
        print(f"[ERROR] APK not found: {APK_PATH}")
        return False
    
    print(f"[INFO] APK found: {APK_PATH} ({get_file_size_mb(APK_PATH)} MB)")
    print("[INFO] Trying multiple methods to bypass Gmail APK blocking...")
    print()
    
    # Try methods in order
    methods = [method1_rename_extension, method2_split_file, method3_notification_only]
    
    for i, method in enumerate(methods, 1):
        try:
            if method():
                print(f"[SUCCESS] Method {i} succeeded!")
                return True
        except Exception as e:
            print(f"[ERROR] Method {i} crashed: {str(e)}")
        
        print()
    
    print("[FAILED] All methods failed!")
    return False

if __name__ == "__main__":
    main()