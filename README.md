# 🦴 X-Ray Fun Camera - Skeleton Prank Simulator

A complete, production-ready Flutter app that applies fun skeleton/X-ray visual effects to photos. Perfect for pranks and entertainment!

## ✨ Features

### 🎯 Core Functionality
- **Live Camera Preview** with real-time skeleton overlay effect
- **Photo Capture** with animated scanning effect
- **X-Ray Color Filter** - Blue-tinted effect for authentic look
- **Skeleton Overlay** - Animated skeleton graphics on photos
- **Image Processing** - On-device processing, no server uploads
- **Save to Gallery** - Save processed images to device storage
- **Share Images** - Share via native share dialog

### 📱 Complete Screens
1. **Splash Screen** - Animated app intro
2. **Disclaimer Screen** - Legal acceptance flow
3. **Home Screen** - Main hub with animated hero icon
4. **Camera Screen** - Live preview with skeleton overlay
5. **Result Screen** - View and manage captured photos
6. **Gallery Screen** - Browse all saved X-ray images
7. **Samples Screen** - Ideas and tips for best results
8. **Settings Screen** - Customize app preferences
9. **Privacy Policy** - Complete privacy documentation
10. **Terms of Use** - Legal terms and conditions
11. **Language Selector** - Choose from 14 languages

### 🎨 UI/UX Features
- **Dark Theme** with neon blue/purple gradient aesthetic
- **Light Theme** support with system theme detection
- **Responsive Design** using flutter_screenutil
- **Smooth Animations** throughout the app
- **Haptic Feedback** for button interactions
- **Sound Effects** for scan and capture actions
- **Accessibility** labels and semantics

### 🌍 Internationalization
Supports 14 languages:
- English, Spanish, French, German
- Hindi, Arabic, Portuguese, Russian
- Chinese, Japanese, Korean, Turkish
- Italian, Indonesian

### 💰 Monetization
- **Banner Ads** on home screen
- **Interstitial Ads** after photo capture
- **Rewarded Ads** infrastructure ready
- Google AdMob integration (test IDs included)

### ⚙️ Settings & Preferences
- **Sound Effects Toggle** - Enable/disable sounds and haptics
- **Theme Selection** - System, Dark, or Light mode
- **Language Selection** - 14 languages supported
- **Persistent Storage** - SharedPreferences for settings

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.5.0 or higher
- Android Studio / VS Code
- Android SDK for Android builds
- Xcode for iOS builds (Mac only)

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd x_ray_karo
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

### Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📦 Dependencies

### Core
- `flutter` - Flutter SDK
- `camera` ^0.10.5+9 - Camera access
- `flutter_screenutil` ^5.9.3 - Responsive design

### Ads & Monetization
- `google_mobile_ads` ^5.1.0 - AdMob integration

### Permissions
- `permission_handler` ^11.3.1 - Runtime permissions

### Storage & Files
- `shared_preferences` ^2.3.2 - Local storage
- `path_provider` ^2.1.4 - File paths
- `path` ^1.9.0 - Path manipulation

### Image Processing
- `image` ^4.2.0 - Image manipulation

### Sharing & External
- `share_plus` ^10.0.2 - Native sharing
- `url_launcher` ^6.3.1 - Open URLs
- `package_info_plus` ^8.1.2 - App info

### Localization
- `intl` - Internationalization
- `flutter_localizations` - Flutter i18n

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── core/
│   ├── constants.dart        # Colors, strings, ad IDs
│   ├── theme.dart            # Theme configuration
│   └── utils.dart            # Utility functions
├── screens/                  # All app screens
│   ├── splash_screen.dart
│   ├── disclaimer_screen.dart
│   ├── home_screen.dart
│   ├── camera_screen.dart
│   ├── result_screen.dart
│   ├── gallery_screen.dart
│   ├── samples_screen.dart
│   ├── settings_screen.dart
│   ├── privacy_screen.dart
│   ├── terms_screen.dart
│   └── language_selector_screen.dart
├── services/                 # Business logic
│   ├── ad_service.dart       # AdMob management
│   ├── permission_service.dart
│   ├── storage_service.dart
│   └── sound_service.dart    # Sound & haptics
└── widgets/                  # Reusable components
    ├── skeleton_overlay.dart
    ├── animated_scan_line.dart
    └── primary_button.dart
```

## 🎯 Key Features Implementation

### Camera & Image Processing
- Pre-fetches cameras in `main()` for instant startup
- Uses `CameraController` with high resolution preset
- Applies color matrix filter for X-ray effect
- Overlays skeleton graphics using `CustomPaint`
- Saves to Pictures/XrayFunCamera directory

### Sound & Haptics
- System sounds for scan/capture/success
- Light/medium/heavy haptic feedback
- Respects user's sound settings toggle
- Graceful fallback if unavailable

### Theme System
- Dark theme with neon aesthetics
- Light theme support
- System theme detection
- Persistent theme preference
- Real-time theme switching

### Gallery Management
- Lists all saved X-ray images
- Sorted by date (newest first)
- Delete images with confirmation
- Tap to view in result screen
- Empty state with CTA

## 🔧 Configuration

### Ad Unit IDs
Update in `lib/core/constants.dart`:
```dart
class AdIds {
  static const String bannerAdUnitId = 'YOUR_BANNER_ID';
  static const String interstitialAdUnitId = 'YOUR_INTERSTITIAL_ID';
  static const String rewardedAdUnitId = 'YOUR_REWARDED_ID';
}
```

### App Strings
Customize in `lib/core/constants.dart`:
```dart
class AppStrings {
  static const String contactEmail = 'your@email.com';
  static const String playStoreUrl = 'YOUR_PLAY_STORE_URL';
}
```

### Permissions
Already configured in:
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`

## 📱 Platform-Specific Setup

### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Permissions: Camera, Storage

### iOS
- Minimum iOS: 12.0
- Permissions: Camera, Photo Library
- Update `Info.plist` with usage descriptions

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run with specific device:
```bash
flutter run -d <device-id>
```

## 📝 Legal & Compliance

### Disclaimer
The app includes comprehensive disclaimers:
- Entertainment purpose only
- Not real X-ray scanning
- No medical functionality
- User acceptance required

### Privacy Policy
Complete privacy policy included covering:
- Data collection (minimal)
- Camera usage (local only)
- AdMob integration
- User rights

### Terms of Use
Full terms of use covering:
- Acceptable use
- Intellectual property
- Liability limitations
- Governing law

## 🎨 Design System

### Colors
- Background: Dark blue gradient (#050B18 → #0A1628)
- Primary: Neon Blue (#00D4FF)
- Secondary: Neon Purple (#7C3AED)
- Success: #00E096
- Danger: #FF3D71

### Typography
- Font: Roboto
- Responsive sizing with flutter_screenutil
- Design base: 360x690

## 🚀 Performance Optimizations

1. **Camera Pre-fetching** - Cameras loaded in main()
2. **Image Caching** - Cached width for gallery thumbnails
3. **Lazy Loading** - Gallery loads on demand
4. **Efficient Rendering** - CustomPaint for overlays
5. **Memory Management** - Proper disposal of controllers

## 🐛 Known Issues & Limitations

- Image processing is CPU-intensive on older devices
- Gallery requires storage permission
- AdMob test IDs need replacement for production
- Localization strings not yet translated (infrastructure ready)

## 🔮 Future Enhancements

- [ ] Add actual translations for all 14 languages
- [ ] Implement rewarded ads for premium features
- [ ] Add more skeleton overlay styles
- [ ] Photo editing tools (crop, rotate, adjust)
- [ ] Social media direct sharing
- [ ] In-app purchases for ad removal
- [ ] Cloud backup of images
- [ ] AR mode with real-time skeleton tracking

## 📄 License

This project is for educational and entertainment purposes only.

## 🤝 Contributing

Contributions are welcome! Please ensure:
- Code follows Flutter best practices
- All features are tested
- Documentation is updated
- Commit messages are clear

## 📧 Support

For issues or questions:
- Email: support@xrayfuncamera.app
- Create an issue in the repository

## ⚠️ Important Notice

This app is for ENTERTAINMENT ONLY. It does not perform real X-ray scanning, medical imaging, or provide any health-related functionality. Always consult qualified healthcare professionals for medical concerns.

---

Made with ❤️ using Flutter
