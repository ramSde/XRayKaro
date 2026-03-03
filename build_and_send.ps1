# ============================================================================
# Flutter Build and Auto-Send Script
# Builds APK and automatically emails it to your friend
# ============================================================================

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "Flutter Build & Auto-Send Automation" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Clean build
Write-Host "🧹 Step 1: Cleaning previous build..." -ForegroundColor Yellow
flutter clean
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Clean failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Clean complete" -ForegroundColor Green
Write-Host ""

# Step 2: Get dependencies
Write-Host "📦 Step 2: Getting dependencies..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Pub get failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Dependencies installed" -ForegroundColor Green
Write-Host ""

# Step 3: Build release APK
Write-Host "🔨 Step 3: Building release APK..." -ForegroundColor Yellow
Write-Host "   This may take 2-3 minutes..." -ForegroundColor Gray
flutter build apk --release
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Build complete" -ForegroundColor Green
Write-Host ""

# Step 4: Verify APK exists
$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
if (-not (Test-Path $apkPath)) {
    Write-Host "❌ APK not found at: $apkPath" -ForegroundColor Red
    exit 1
}

$apkSize = [math]::Round((Get-Item $apkPath).Length / 1MB, 2)
Write-Host "✅ APK created successfully!" -ForegroundColor Green
Write-Host "   Location: $apkPath" -ForegroundColor Gray
Write-Host "   Size: $apkSize MB" -ForegroundColor Gray
Write-Host ""

# Step 5: Send email
Write-Host "📧 Step 5: Sending APK via email..." -ForegroundColor Yellow

# Check if Python is installed
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
    Write-Host "❌ Python not found!" -ForegroundColor Red
    Write-Host "   Please install Python from: https://www.python.org/downloads/" -ForegroundColor Yellow
    Write-Host "   Or send the APK manually from: $apkPath" -ForegroundColor Yellow
    exit 1
}

# Run Python email script
python send_apk.py
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Email sending failed!" -ForegroundColor Red
    Write-Host "   APK is ready at: $apkPath" -ForegroundColor Yellow
    Write-Host "   You can send it manually" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "✅ ALL DONE! APK built and sent successfully!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
