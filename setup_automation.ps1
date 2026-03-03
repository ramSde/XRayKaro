# ============================================================================
# Email Automation Setup Script
# Sets up secure email automation with .env file
# ============================================================================

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Email Automation Setup" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check Python
Write-Host "Step 1: Checking Python installation..." -ForegroundColor Yellow
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
    Write-Host "❌ Python not found!" -ForegroundColor Red
    Write-Host "   Please install Python from: https://www.python.org/downloads/" -ForegroundColor Yellow
    Write-Host "   Make sure to check 'Add Python to PATH' during installation" -ForegroundColor Yellow
    exit 1
}

$pythonVersion = python --version
Write-Host "✅ Python found: $pythonVersion" -ForegroundColor Green
Write-Host ""

# Step 2: Install python-dotenv
Write-Host "Step 2: Installing python-dotenv..." -ForegroundColor Yellow
pip install python-dotenv --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ python-dotenv installed" -ForegroundColor Green
} else {
    Write-Host "⚠️  Failed to install python-dotenv" -ForegroundColor Yellow
    Write-Host "   You can install it manually: pip install python-dotenv" -ForegroundColor Gray
}
Write-Host ""

# Step 3: Create .env file
Write-Host "Step 3: Creating .env file..." -ForegroundColor Yellow
if (Test-Path ".env") {
    Write-Host "⚠️  .env file already exists" -ForegroundColor Yellow
    $overwrite = Read-Host "   Do you want to overwrite it? (y/N)"
    if ($overwrite -ne "y" -and $overwrite -ne "Y") {
        Write-Host "   Keeping existing .env file" -ForegroundColor Gray
        Write-Host ""
    } else {
        Copy-Item ".env.example" ".env" -Force
        Write-Host "✅ .env file created from template" -ForegroundColor Green
        Write-Host ""
    }
} else {
    Copy-Item ".env.example" ".env"
    Write-Host "✅ .env file created from template" -ForegroundColor Green
    Write-Host ""
}

# Step 4: Guide user to configure
Write-Host "Step 4: Configuration needed" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please complete these steps:" -ForegroundColor White
Write-Host ""
Write-Host "1. Get Gmail App Password:" -ForegroundColor Cyan
Write-Host "   - Visit: https://myaccount.google.com/apppasswords" -ForegroundColor Gray
Write-Host "   - Create new App Password" -ForegroundColor Gray
Write-Host "   - Copy the 16-character code" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Edit .env file:" -ForegroundColor Cyan
Write-Host "   - Open .env in a text editor" -ForegroundColor Gray
Write-Host "   - Update SENDER_EMAIL (your Gmail)" -ForegroundColor Gray
Write-Host "   - Update SENDER_PASSWORD (App Password from step 1)" -ForegroundColor Gray
Write-Host "   - Update RECIPIENT_EMAIL (friend's email)" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Test configuration:" -ForegroundColor Cyan
Write-Host "   - Run: python test_email_setup.py" -ForegroundColor Gray
Write-Host ""

# Step 5: Open .env file for editing
Write-Host "Would you like to open .env file now? (Y/n)" -ForegroundColor Yellow
$openFile = Read-Host
if ($openFile -ne "n" -and $openFile -ne "N") {
    notepad .env
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "1. Configure .env file with your credentials" -ForegroundColor Gray
Write-Host "2. Run: python test_email_setup.py" -ForegroundColor Gray
Write-Host "3. Build APK: flutter build apk --release" -ForegroundColor Gray
Write-Host ""
Write-Host "Documentation: SETUP_AUTOMATION.md" -ForegroundColor Gray
Write-Host ""
