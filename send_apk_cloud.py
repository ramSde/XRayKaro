#!/usr/bin/env python3
"""
Cloud-based APK Email Script
Uploads APK to temporary cloud storage and sends download link
"""

import smtplib
import os
import requests
import json
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
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

def upload_to_file_io():
    """Upload APK to file.io (temporary file hosting)"""
    print("[UPLOAD] Uploading APK to file.io...")
    
    try:
        with open(APK_PATH, 'rb') as f:
            files = {'file': f}
            response = requests.post('https://file.io', files=files, timeout=60)
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                download_url = data.get('link')
                print(f"[SUCCESS] Upload complete: {download_url}")
                return download_url
        
        print(f"[FAILED] Upload failed: {response.text}")
        return None
        
    except Exception as e:
        print(f"[FAILED] Upload error: {str(e)}")
        return None

def upload_to_0x0_st():
    """Upload APK to 0x0.st (temporary file hosting)"""
    print("[UPLOAD] Uploading APK to 0x0.st...")
    
    try:
        with open(APK_PATH, 'rb') as f:
            files = {'file': f}
            response = requests.post('https://0x0.st', files=files, timeout=60)
        
        if response.status_code == 200:
            download_url = response.text.strip()
            print(f"[SUCCESS] Upload complete: {download_url}")
            return download_url
        
        print(f"[FAILED] Upload failed: {response.status_code}")
        return None
        
    except Exception as e:
        print(f"[FAILED] Upload error: {str(e)}")
        return None

def upload_to_tmpfiles_org():
    """Upload APK to tmpfiles.org"""
    print("[UPLOAD] Uploading APK to tmpfiles.org...")
    
    try:
        with open(APK_PATH, 'rb') as f:
            files = {'file': f}
            response = requests.post('https://tmpfiles.org/api/v1/upload', files=files, timeout=60)
        
        if response.status_code == 200:
            data = response.json()
            if data.get('status') == 'success':
                download_url = data.get('data', {}).get('url')
                if download_url:
                    print(f"[SUCCESS] Upload complete: {download_url}")
                    return download_url
        
        print(f"[FAILED] Upload failed: {response.text}")
        return None
        
    except Exception as e:
        print(f"[FAILED] Upload error: {str(e)}")
        return None

def send_download_link_email(download_url):
    """Send email with download link"""
    print("[EMAIL] Sending download link...")
    
    try:
        msg = MIMEMultipart()
        msg['From'] = SENDER_EMAIL
        msg['To'] = RECIPIENT_EMAIL
        msg['Subject'] = "X-Ray Body Scanner - APK Download Ready"
        
        body = f"""Hi,

New APK build is ready for testing!

DOWNLOAD LINK: {download_url}

Build Details:
- Date: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
- Size: {get_file_size_mb(APK_PATH)} MB
- File: {os.path.basename(APK_PATH)}

Instructions:
1. Click the download link above
2. Download the APK file
3. Install on your Android device

Note: This is a temporary link that will expire in 24-48 hours.

Please test the following:
1. Camera functionality
2. Save to gallery
3. Language switching
4. Theme switching
5. All skeleton styles

Let me know if you find any issues!

Thanks,
Developer
"""
        
        msg.attach(MIMEText(body, 'plain'))
        
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, RECIPIENT_EMAIL, msg.as_string())
        server.quit()
        
        print("[SUCCESS] Download link email sent!")
        return True
        
    except Exception as e:
        print(f"[FAILED] Email error: {str(e)}")
        return False

def main():
    print("=" * 60)
    print("Cloud APK Email Script - Upload & Send Link")
    print("=" * 60)
    
    if not all([SENDER_EMAIL, SENDER_PASSWORD, RECIPIENT_EMAIL]):
        print("[ERROR] Email configuration missing!")
        return False
    
    if not os.path.exists(APK_PATH):
        print(f"[ERROR] APK not found: {APK_PATH}")
        return False
    
    print(f"[INFO] APK found: {APK_PATH} ({get_file_size_mb(APK_PATH)} MB)")
    print("[INFO] Uploading to cloud storage and sending download link...")
    print()
    
    # Try different upload services
    upload_services = [upload_to_file_io, upload_to_0x0_st, upload_to_tmpfiles_org]
    
    for service in upload_services:
        try:
            download_url = service()
            if download_url:
                if send_download_link_email(download_url):
                    print()
                    print("=" * 60)
                    print("[SUCCESS] APK uploaded and download link sent!")
                    print(f"Download URL: {download_url}")
                    print("=" * 60)
                    return True
        except Exception as e:
            print(f"[ERROR] Service failed: {str(e)}")
        
        print()
    
    # Fallback to notification email
    print("[FALLBACK] All upload services failed. Sending notification...")
    try:
        msg = MIMEMultipart()
        msg['From'] = SENDER_EMAIL
        msg['To'] = RECIPIENT_EMAIL
        msg['Subject'] = "X-Ray Body Scanner - APK Ready (Upload Failed)"
        
        body = f"""Hi,

New APK build is ready, but automatic upload failed.

Please manually upload the APK using:
- Google Drive
- Dropbox  
- WeTransfer
- Any file sharing service

APK Location: {APK_PATH}
APK Size: {get_file_size_mb(APK_PATH)} MB
Build Date: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}

Thanks!
"""
        
        msg.attach(MIMEText(body, 'plain'))
        
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, RECIPIENT_EMAIL, msg.as_string())
        server.quit()
        
        print("[SUCCESS] Fallback notification sent!")
        return True
        
    except Exception as e:
        print(f"[FAILED] Fallback email failed: {str(e)}")
        return False

if __name__ == "__main__":
    main()