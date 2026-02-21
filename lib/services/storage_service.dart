import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    if (_prefs == null) throw Exception('StorageService not initialized');
    return _prefs!;
  }

  // ── Disclaimer & Privacy ────────────────────────────────────────────────────
  static bool get disclaimerAccepted =>
      _instance.getBool(PrefKeys.disclaimerAccepted) ?? false;

  static Future<void> acceptDisclaimer() async =>
      await _instance.setBool(PrefKeys.disclaimerAccepted, true);

  static bool get privacyAccepted =>
      _instance.getBool(PrefKeys.privacyAccepted) ?? false;

  static Future<void> acceptPrivacy() async =>
      await _instance.setBool(PrefKeys.privacyAccepted, true);

  // ── Settings ────────────────────────────────────────────────────────────────
  static bool get soundEnabled =>
      _instance.getBool(PrefKeys.soundEnabled) ?? true;

  static Future<void> setSoundEnabled(bool value) async =>
      await _instance.setBool(PrefKeys.soundEnabled, value);

  static String get themeMode =>
      _instance.getString(PrefKeys.themeMode) ?? 'system';

  static Future<void> setThemeMode(String value) async =>
      await _instance.setString(PrefKeys.themeMode, value);

  static String get locale => _instance.getString(PrefKeys.locale) ?? 'en';

  static Future<void> setLocale(String value) async =>
      await _instance.setString(PrefKeys.locale, value);

  // ── Scan Count (for engagement tracking) ────────────────────────────────────
  static int get scanCount => _instance.getInt(PrefKeys.scanCount) ?? 0;

  static Future<void> incrementScanCount() async =>
      await _instance.setInt(PrefKeys.scanCount, scanCount + 1);
}
