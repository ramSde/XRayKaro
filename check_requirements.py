#!/usr/bin/env python3
"""
Requirements Checker for Email Automation
Verifies all dependencies and setup requirements
"""

import sys
import os
import subprocess
import platform

def print_header(text):
    """Print formatted header"""
    print("\n" + "=" * 60)
    print(f"  {text}")
    print("=" * 60)

def print_check(name, status, message=""):
    """Print check result"""
    icon = "✅" if status else "❌"
    print(f"{icon} {name}")
    if message:
        print(f"   {message}")

def check_python_version():
    """Check Python version"""
    print_header("Python Version Check")
    
    version = sys.version_info
    version_str = f"{version.major}.{version.minor}.{version.micro}"
    
    if version.major >= 3 and version.minor >= 6:
        print_check(f"Python {version_str}", True, "Python 3.6+ required")
        return True
    else:
        print_check(f"Python {version_str}", False, "Python 3.6+ required, please upgrade")
        print(f"   Download from: https://www.python.org/downloads/")
        return False

def check_pip():
    """Check if pip is installed"""
    print_header("Package Manager Check")
    
    try:
        result = subprocess.run(
            [sys.executable, "-m", "pip", "--version"],
            capture_output=True,
            text=True,
            timeout=5
        )
        if result.returncode == 0:
            pip_version = result.stdout.strip()
            print_check("pip", True, pip_version)
            return True
        else:
            print_check("pip", False, "pip not found")
            return False
    except Exception as e:
        print_check("pip", False, f"Error: {str(e)}")
        return False

def check_python_dotenv():
    """Check if python-dotenv is installed"""
    print_header("Python Dependencies Check")
    
    try:
        import dotenv
        version = dotenv.__version__ if hasattr(dotenv, '__version__') else "installed"
        print_check("python-dotenv", True, f"Version: {version}")
        return True
    except ImportError:
        print_check("python-dotenv", False, "Not installed")
        print("   Install with: pip install python-dotenv")
        return False

def check_env_file():
    """Check if .env file exists and is configured"""
    print_header("Configuration File Check")
    
    # Check .env.example
    if os.path.exists(".env.example"):
        print_check(".env.example", True, "Template file exists")
    else:
        print_check(".env.example", False, "Template file missing")
    
    # Check .env
    if os.path.exists(".env"):
        print_check(".env file", True, "Configuration file exists")
        
        # Check if configured
        try:
            with open(".env", "r") as f:
                content = f.read()
                
            has_sender = "SENDER_EMAIL=" in content and "your.email@gmail.com" not in content
            has_password = "SENDER_PASSWORD=" in content and "xxxx xxxx xxxx xxxx" not in content
            has_recipient = "RECIPIENT_EMAIL=" in content and "friend.email@gmail.com" not in content
            
            if has_sender and has_password and has_recipient:
                print_check(".env configured", True, "All credentials set")
                return True
            else:
                print_check(".env configured", False, "Please update credentials in .env")
                if not has_sender:
                    print("   - Update SENDER_EMAIL")
                if not has_password:
                    print("   - Update SENDER_PASSWORD")
                if not has_recipient:
                    print("   - Update RECIPIENT_EMAIL")
                return False
        except Exception as e:
            print_check(".env readable", False, f"Error reading file: {str(e)}")
            return False
    else:
        print_check(".env file", False, "Configuration file missing")
        print("   Create from template: cp .env.example .env")
        return False

def check_gitignore():
    """Check if .gitignore protects .env"""
    print_header("Git Protection Check")
    
    if os.path.exists(".gitignore"):
        try:
            with open(".gitignore", "r") as f:
                content = f.read()
            
            if ".env" in content:
                print_check(".gitignore", True, ".env is protected")
                return True
            else:
                print_check(".gitignore", False, ".env not in .gitignore")
                print("   Add '.env' to .gitignore file")
                return False
        except Exception as e:
            print_check(".gitignore", False, f"Error: {str(e)}")
            return False
    else:
        print_check(".gitignore", False, "File not found")
        return False

def check_flutter():
    """Check if Flutter is installed"""
    print_header("Flutter Check")
    
    try:
        result = subprocess.run(
            ["flutter", "--version"],
            capture_output=True,
            text=True,
            timeout=10
        )
        if result.returncode == 0:
            # Extract version from output
            lines = result.stdout.split('\n')
            version_line = lines[0] if lines else "Unknown version"
            print_check("Flutter", True, version_line)
            return True
        else:
            print_check("Flutter", False, "Flutter not found")
            return False
    except FileNotFoundError:
        print_check("Flutter", False, "Flutter not found in PATH")
        print("   Download from: https://flutter.dev/docs/get-started/install")
        return False
    except Exception as e:
        print_check("Flutter", False, f"Error: {str(e)}")
        return False

def check_gradle_integration():
    """Check if Gradle post-build hook is configured"""
    print_header("Gradle Integration Check")
    
    gradle_file = "android/app/build.gradle.kts"
    
    if os.path.exists(gradle_file):
        try:
            with open(gradle_file, "r") as f:
                content = f.read()
            
            if "sendApkEmail" in content and "finalizedBy" in content:
                print_check("Gradle hook", True, "Post-build automation configured")
                return True
            else:
                print_check("Gradle hook", False, "Post-build hook not configured")
                print("   Check android/app/build.gradle.kts")
                return False
        except Exception as e:
            print_check("Gradle file", False, f"Error: {str(e)}")
            return False
    else:
        print_check("Gradle file", False, "android/app/build.gradle.kts not found")
        return False

def check_internet_connection():
    """Check internet connectivity"""
    print_header("Network Check")
    
    try:
        import socket
        socket.create_connection(("smtp.gmail.com", 587), timeout=5)
        print_check("Gmail SMTP", True, "Can connect to smtp.gmail.com:587")
        return True
    except Exception as e:
        print_check("Gmail SMTP", False, "Cannot connect to smtp.gmail.com:587")
        print(f"   Error: {str(e)}")
        print("   Check internet connection and firewall")
        return False

def check_apk_exists():
    """Check if APK exists"""
    print_header("APK Check")
    
    apk_path = "build/app/outputs/flutter-apk/app-release.apk"
    
    if os.path.exists(apk_path):
        size_mb = round(os.path.getsize(apk_path) / (1024 * 1024), 2)
        print_check("APK file", True, f"Found: {size_mb} MB")
        
        if size_mb > 25:
            print("   ⚠️  Warning: APK size > 25 MB (Gmail limit)")
            print("   Consider using: flutter build apk --release --split-per-abi")
        return True
    else:
        print_check("APK file", False, "Not found (build first)")
        print("   Build with: flutter build apk --release")
        return False

def print_summary(results):
    """Print summary of all checks"""
    print_header("Summary")
    
    total = len(results)
    passed = sum(results.values())
    failed = total - passed
    
    print(f"\nTotal Checks: {total}")
    print(f"✅ Passed: {passed}")
    print(f"❌ Failed: {failed}")
    
    if failed == 0:
        print("\n🎉 All checks passed! You're ready to use the automation.")
        print("\nNext steps:")
        print("1. Test: python test_email_setup.py")
        print("2. Build: flutter build apk --release")
    else:
        print("\n⚠️  Some checks failed. Please fix the issues above.")
        print("\nQuick fixes:")
        if not results.get("python-dotenv"):
            print("- Install python-dotenv: pip install python-dotenv")
        if not results.get(".env"):
            print("- Create .env: cp .env.example .env")
        if not results.get(".env configured"):
            print("- Configure .env with your credentials")
        if not results.get("Flutter"):
            print("- Install Flutter: https://flutter.dev/docs/get-started/install")

def main():
    """Run all checks"""
    print("\n" + "=" * 60)
    print("  Email Automation Requirements Checker")
    print("=" * 60)
    print(f"\nPlatform: {platform.system()} {platform.release()}")
    print(f"Python: {sys.version}")
    
    results = {}
    
    # Run all checks
    results["Python"] = check_python_version()
    results["pip"] = check_pip()
    results["python-dotenv"] = check_python_dotenv()
    results[".env"] = check_env_file()
    results[".gitignore"] = check_gitignore()
    results["Flutter"] = check_flutter()
    results["Gradle"] = check_gradle_integration()
    results["Network"] = check_internet_connection()
    results["APK"] = check_apk_exists()
    
    # Print summary
    print_summary(results)
    
    # Exit code
    if all(results.values()):
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nCheck cancelled by user.")
        sys.exit(1)
    except Exception as e:
        print(f"\n\n❌ Unexpected error: {str(e)}")
        sys.exit(1)
