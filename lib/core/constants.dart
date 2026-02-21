import 'package:flutter/material.dart';

// ─── Colors ───────────────────────────────────────────────────────────────────
class AppColors {
  static const Color bgDark = Color(0xFF050B18);
  static const Color bgDark2 = Color(0xFF0A1628);
  static const Color neonBlue = Color(0xFF00D4FF);
  static const Color neonPurple = Color(0xFF7C3AED);
  static const Color neonGlow = Color(0xFF4F86F7);
  static const Color scanLine = Color(0xFF00FFFF);
  static const Color overlay = Color(0x8800D4FF);
  static const Color cardBg = Color(0xFF0D1F3C);
  static const Color textPrimary = Color(0xFFE2F3FF);
  static const Color textSecondary = Color(0xFF88AACE);
  static const Color danger = Color(0xFFFF3D71);
  static const Color success = Color(0xFF00E096);

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [bgDark, bgDark2, Color(0xFF0B1E3A)],
  );

  static const LinearGradient neonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [neonBlue, neonPurple],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D4FF), Color(0xFF7C3AED)],
  );
}

// ─── Strings ──────────────────────────────────────────────────────────────────
class AppStrings {
  static const String appName = 'Xray Fun Camera';
  static const String appSubtitle = 'Skeleton Prank Simulator';
  static const String tagline = '🦴 Apply fun skeleton filter to any photo!';
  static const String entertainmentDisclaimer =
      '⚠️ For entertainment only. Not real X-ray.';
  static const String fullDisclaimer =
      'This app is for entertainment purposes only. It does not provide real X-ray scanning or medical diagnosis.';

  static const String startScan = '🔥 Start Fun Xray Scan';
  static const String scanAgain = '🔄 Scan Again';
  static const String saveImage = '💾 Save Image';
  static const String shareImage = '📤 Share';

  static const String shareText =
      '😂 OMG check out this crazy skeleton prank! Try it yourself 💀🔥\n#XrayFunCamera #SkeletonPrank #FunFilter';

  static const String cameraPermissionDenied =
      '📷 Camera access needed to apply the fun skeleton effect!\nTap below to grant permission.';

  static const String scanningText = '🔍 Applying fun skeleton filter...';

  static const String contactEmail = 'support@xrayfuncamera.app';
  static const String appVersion = '1.0.0';
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.xrayfuncamera.skeletonprank';
  static const String actionGallery = 'Gallery';
  static const String actionSamples = 'Samples';

  static const List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Español', 'code': 'es'},
    {'name': 'Français', 'code': 'fr'},
    {'name': 'Deutsch', 'code': 'de'},
    {'name': 'हिन्दी', 'code': 'hi'},
    {'name': 'العربية', 'code': 'ar'},
    {'name': 'Português', 'code': 'pt'},
    {'name': 'Русский', 'code': 'ru'},
    {'name': '中文', 'code': 'zh'},
    {'name': '日本語', 'code': 'ja'},
    {'name': '한국어', 'code': 'ko'},
    {'name': 'Türkçe', 'code': 'tr'},
    {'name': 'Italiano', 'code': 'it'},
    {'name': 'Bahasa Indonesia', 'code': 'id'},
  ];
}

// ─── Ad Unit IDs (Test IDs) ───────────────────────────────────────────────────
class AdIds {
  // Use real IDs in production
  static const String bannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111'; // Test banner
  static const String interstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712'; // Test interstitial
  static const String rewardedAdUnitId =
      'ca-app-pub-3940256099942544/5224354917'; // Test rewarded
}

// ─── SharedPreferences Keys ───────────────────────────────────────────────────
class PrefKeys {
  static const String disclaimerAccepted = 'disclaimer_accepted';
  static const String privacyAccepted = 'privacy_accepted';
  static const String soundEnabled = 'sound_enabled';
  static const String themeMode = 'theme_mode';
  static const String scanCount = 'scan_count';
  static const String locale = 'selected_locale';
}
